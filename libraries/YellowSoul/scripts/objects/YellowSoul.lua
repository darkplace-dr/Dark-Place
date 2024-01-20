local YellowSoul, super = Class(Soul)

function YellowSoul:init(x, y, angle)
    super:init(self, x, y)

    self.rotation = angle and math.rad(angle) or math.rad(270)
    self.direction = "right"
    self.color = {1,1,0}


    self.shooting_angles = {
        ["up"] = math.rad(180),
        ["down"] = math.rad(0),
        ["left"] = math.rad(90),
        ["right"] = math.rad(270)
    }

    -- customizable variables
    self.can_use_bigshot = true -- whether the soul can use bigshots
    self.can_use_shots = true -- whether the soul can use normal shots
    self.can_shoot = true -- whether the soul is allowed to shoot in general
    self.teaching = false -- whether big shots should charge slowly
    self.allow_cheat = Kristal.getLibConfig("yellowsoul", "allowcheat") -- whether the player is allowed to chain bigshots rapidly
    self.can_rotate = false -- whether WASD can be used to fire in different directions.

    -- internal variables
    self.hold_timer = 0
    self.charge_sfx = nil

    self.dpad = Sprite("player/dpad")
    self.dpad:setOrigin(0.5, 0.5)
    self:addChild(self.dpad)

    self.dpad.debug_select = false

    --[[
    function self.dpad:getDebugInfo()
        local info = super:getDebugInfo(self)
        table.insert(info, "Rotation (DEG): " .. math.deg(Game.battle.soul.rotation))
        table.insert(info, "Rotation (RAD): " .. Game.battle.soul.rotation)
        return info
    end
    --]]


end

function YellowSoul:update()
    super:update(self)
    self.dpad.visible = self.can_rotate
    if self.transitioning then
        if self.charge_sfx then
            self.charge_sfx:stop()
            self.charge_sfx = nil
        end
        return
    end

    if self.can_rotate then

        if self.direction == "down" then self.rotation = Utils.approach(self.rotation, math.rad(0), DTMULT) end
	    if self.direction == "up" then self.rotation = Utils.approach(self.rotation, math.rad(180), DTMULT) end
	    if self.direction == "left" then self.rotation = Utils.approach(self.rotation, math.rad(90), DTMULT) end
	    if self.direction == "right" then self.rotation = Utils.approach(self.rotation, math.rad(270), DTMULT) end

        if Input.pressed("w") then self.direction = "up" end
        if Input.pressed("a") then self.direction = "left" end
        -- Check initial rotation for these two and adjust accordingly so it doesn't spin all the way around.
        if Input.pressed("s") then 
            if self.direction == "right" then
                self.rotation = math.rad(-90)
            end
            self.direction = "down" 
        end
        if Input.pressed("d") then 
            if self.direction == "down" then
                self.rotation = math.rad(360)
            end
            self.direction = "right" 
        end
    end

    if not self:canShoot() then return end
    
    if Input.pressed("confirm") and self.hold_timer == 0 and self:canUseShots() then -- fire normal shot
        self:fireShot(false)
    end
    if self:canUseBigShot() then
        -- check release before checking hold, since if held is false it sets the timer to 0
        if Input.released("confirm") then -- fire big shot
            if self.hold_timer >= 10 and self.hold_timer < 40 then -- didn't hold long enough, fire normal shot
                self:fireShot(false)
            elseif self.hold_timer >= 40 then -- fire big shot
                if self:canCheat() and Input.down("confirm") then -- they are cheating
                    self:onCheat()
                end
                self:fireShot(true)
                if self.teaching then
                    self.teaching = false
                end
            end
            if not self:canCheat() then -- reset hold timer if cheating is disabled
                self.hold_timer = 0
            end
        end

        if Input.down("confirm") then -- charge a big shot
            self.hold_timer = self.hold_timer + DTMULT*self:getChargeSpeed()

            if self.hold_timer >= 20 and not self.charge_sfx then -- start charging sfx
                self.charge_sfx = Assets.getSound("chargeshot_charge")
                self.charge_sfx:setLooping(true)
                self.charge_sfx:setPitch(0.1)
                self.charge_sfx:setVolume(0)
                local timer = 0
                Game.battle.timer:during(2/3, function()
                    timer = timer + DT
                    if self.charge_sfx then
                        self.charge_sfx:setVolume(Utils.clampMap(timer, 0,2/3, 0,0.3))
                    end
                end, function()
                    if self.charge_sfx then
                        self.charge_sfx:setVolume(0.3)
                    end    
                end)
                self.charge_sfx:play()
            end
            if self.hold_timer >= 20 and self.hold_timer < 40 then
                self.charge_sfx:setPitch(Utils.clampMap(self.hold_timer, 20,40, 0.1,1))
            end
        else
            self.hold_timer = 0
            if self.charge_sfx then
                self.charge_sfx:stop()
                self.charge_sfx = nil
            end
        end
    end
end

function YellowSoul:draw()
    local r,g,b,a = self:getDrawColor()
    local heart_texture = Assets.getTexture(self.sprite.texture_path)
    local heart_w, heart_h = heart_texture:getDimensions()

    local charge_timer = self.hold_timer - 35
    if charge_timer > 0 then
        local scale = math.abs(math.sin(charge_timer / 10)) + 1
        love.graphics.setColor(r,g,b,a*0.3)
        love.graphics.draw(heart_texture, -heart_w/2 * scale, -heart_h/2 * scale, 0, scale)

        scale = math.abs(math.sin(charge_timer / 14)) + 1.2
        love.graphics.setColor(r,g,b,a*0.3)
        love.graphics.draw(heart_texture, -heart_w/2 * scale, -heart_h/2 * scale, 0, scale)
    end

    local circle_timer = math.min(self.hold_timer - 15, 35)
    if circle_timer > 0 then
        local circle = Assets.getTexture("player/shot/charge")
        love.graphics.setColor(r,g,b,a*(circle_timer/5))
        for i=1,4 do
            local angle = (i*math.pi/2) - (circle_timer * math.rad(5))
            local x, y = math.cos(angle) * (35 - circle_timer), math.sin(angle) * (35 - circle_timer)
            local scale = Utils.clampMap(circle_timer, 0,35, 4,2)
            x, y = x - circle:getWidth()/2 * scale, y - circle:getHeight()/2 * scale
            love.graphics.draw(circle, x, y, 0, scale)
        end
    end

    if charge_timer > 0 then
        self.color = {1,1,1}
    end
    super:draw(self)
    self.color = {r,g,b}
end

function YellowSoul:onRemoveFromStage(stage)
    super:onRemove(self, stage)
    if self.charge_sfx then
        self.charge_sfx:stop()
        self.charge_sfx = nil
    end
end

function YellowSoul:getChargeSpeed()
    if self:isTeaching() then -- charge the first shot of a save file slowly if teaching is enabled
        return 1
    else
        return 2
    end
end

function YellowSoul:canUseBigShot() return self.can_use_bigshot end
function YellowSoul:canUseShots() return self.can_use_shots end
function YellowSoul:canShoot() return self.can_shoot end
function YellowSoul:canCheat() return self.allow_cheat end
function YellowSoul:isTeaching() return self.teaching end

function YellowSoul:fireShot(big)
    local shot
    if big then
        shot = Game.battle:addChild(YellowSoulBigShot(self.x, self.y, self.shooting_angles[self.direction] + math.pi/2))
        Assets.playSound("chargeshot_fire")
    else
        if #Game.stage:getObjects(YellowSoulShot) >= 3 then return end -- only allow 3 at once
        shot = Game.battle:addChild(YellowSoulShot(self.x, self.y, self.shooting_angles[self.direction] + math.pi/2))
        Assets.playSound("heartshot")
    end
    Kristal.callEvent("onYellowShot", big, shot)
    if Game.battle.encounter.onYellowShot then
        Game.battle.encounter:onYellowShot(big, shot)
    end
end

function YellowSoul:onCheat()
    Game.battle.encounter.funnycheat = (Game.battle.encounter.funnycheat or 0) + 1
end

function YellowSoul:getDebugInfo()
    local info = super:getDebugInfo(self)
    table.insert(info, "Rotation (DEG): " .. math.deg(self.rotation))
    table.insert(info, "Rotation (RAD): " .. self.rotation)
    return info
end

return YellowSoul