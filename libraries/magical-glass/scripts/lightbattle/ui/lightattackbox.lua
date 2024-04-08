local LightAttackBox, super = Class(Object)

function LightAttackBox:init(x, y)
    super.init(self, x, y)

    self.arena = Game.battle.arena

    self.target_sprite = Game.battle.multi_mode and Sprite("ui/lightbattle/dumbtarget_multi") or Sprite("ui/lightbattle/dumbtarget")
    self.target_sprite:setOrigin(0.5, 0.5)
    self.target_sprite:setPosition(self.arena:getRelativePos(self.arena.width / 2, self.arena.height / 2))
    self.target_sprite.layer = BATTLE_LAYERS["above_ui"]
    Game.battle:addChild(self.target_sprite)

    -- called "fatal" for some reason in ut
    self.bolt_target = Game.battle.multi_mode and self.arena.x / 2 - 10 or self.arena.x

    self.shoe_finished = 0
    self.attackers = Game.battle.normal_attackers
    self.lanes = {}

    self.timer = 0

    self.done = nil
end

function LightAttackBox:createBolts()
    self.shoe_finished = 0
    for i,battler in ipairs(self.attackers) do
        local lane = {}
        lane.battler = battler
        lane.bolts = {}
        lane.weapon = battler.chara:getWeapon()
        lane.speed = lane.weapon and lane.weapon.getLightBoltSpeed and lane.weapon:getLightBoltSpeed() or 11 + (not Game.battle.multi_mode and Utils.random(0, 2, 1) or 0)
        lane.attacked = false
        lane.score = 0
        lane.stretch = nil
        lane.direction = Game.battle.multi_mode and "left" or lane.weapon and lane.weapon.getLightBoltDirection and lane.weapon:getLightBoltDirection() or Game:isLight() and "right" or Utils.pick({"right", "left"})

        if (lane.weapon and lane.weapon.getLightBoltCount and lane.weapon:getLightBoltCount() or 1) > 1 then
            lane.attack_type = "shoe"
        else
            lane.attack_type = "slice"
        end

        local randomizer = #self.attackers == 1 and 0 or Utils.random(0,3,1) * 40
        local start_x
        if lane.direction == "left" then
            start_x = (self.target_sprite.x + self.target_sprite.width / 1.8) - randomizer
        elseif lane.direction == "right" then
            start_x = (self.target_sprite.x - self.target_sprite.width / 1.8) + randomizer
        else
            error("Invalid attack direction")
        end

        for i = 1, lane.weapon and lane.weapon.getLightBoltCount and lane.weapon:getLightBoltCount() or 1 do
            local bolt
            local scale_y = (1 / #self.attackers)
            if i == 1 then
                if lane.direction == "left" then
                    bolt = LightAttackBar(start_x + (lane.weapon and lane.weapon.getLightBoltStart and lane.weapon:getLightBoltStart() or -16), 319, battler, scale_y)
                else
                    bolt = LightAttackBar(start_x - (lane.weapon and lane.weapon.getLightBoltStart and lane.weapon:getLightBoltStart() or -16), 319, battler, scale_y)
                end
            else
                if lane.direction == "left" then
                    bolt = LightAttackBar(start_x + (lane.weapon and lane.weapon.getLightMultiboltVariance and lane.weapon:getLightMultiboltVariance(i - 1) or 24 + 40 * (i - 2)), 319, battler, scale_y)
                else
                    bolt = LightAttackBar(start_x - (lane.weapon and lane.weapon.getLightMultiboltVariance and lane.weapon:getLightMultiboltVariance(i - 1) or 24 + 40 * (i - 2)), 319, battler, scale_y)
                end
                bolt.sprite:setSprite(bolt.inactive_sprite)
            end
            local centerizer = 0
            if #self.attackers == 1 then
                centerizer = 1
            elseif #self.attackers == 2 then
                centerizer = 33
            elseif #self.attackers == 3 then
                centerizer = 43
            elseif #self.attackers == 4 then
                centerizer = 49
            elseif #self.attackers == 5 then
                centerizer = 51
            else
                centerizer = 51 + (#self.attackers - 5) * 2
            end
            bolt.y = math.ceil(bolt.y - (bolt.sprite.height * scale_y * (#self.attackers - Utils.getIndex(self.attackers, lane.battler)))) + centerizer
            bolt.layer = BATTLE_LAYERS["above_ui"]
            table.insert(lane.bolts, bolt)
            Game.battle:addChild(bolt)
        end
        table.insert(self.lanes, lane)
    end
end

function LightAttackBox:getClose(battler)
    if battler.attack_type == "shoe" then
        return math.floor(battler.bolts[1].x / battler.speed) - math.floor(self.bolt_target / battler.speed)
    elseif battler.attack_type == "slice" then
        return Utils.round(battler.bolts[1].x - self.bolt_target)
    end
end

function LightAttackBox:getFirstBolt(battler)
    return Utils.round(battler.bolts[1].x - self.bolt_target)
end

function LightAttackBox:evaluateHit(battler, close)
    local value = 0
    if close < 1 then
        value = value + 110
    elseif close < 2 then
        value = value + 90
    elseif close < 3 then
        value = value + 80 
    elseif close < 4 then
        value = value + 70
    elseif close < 5 then
        value = value + 50
    elseif close < 10 then
        value = value + 40
    elseif close < 16 then
        value = value + 20
    elseif close < 22 then
        value = value + 15
    elseif close < 28 then
        value = value + 10
    else
        value = value + 10
    end

    return value
end

function LightAttackBox:checkAttackEnd(battler, score, bolts, close)
    if #bolts == 0 then
        if battler.attack_type == "shoe" then
            self.shoe_finished = self.shoe_finished + 1
        end
        battler.attacked = true
        if self.shoe_finished >= #self.attackers then
            self.fading = true
        end
        return battler.score
    end
end

function LightAttackBox:hit(battler)
    local bolt = battler.bolts[1]
    if battler.weapon and battler.weapon.onLightBoltHit then
        battler.weapon:onLightBoltHit(battler)
    end
    if battler.attack_type == "shoe" then
        local close = math.floor(math.abs(self:getClose(battler)) * (Game.battle.multi_mode and self:getClose(battler) < -20 and 3 or 1))

        local eval = self:evaluateHit(battler, close)
        
        if battler.weapon and battler.weapon.scoreHit then
            battler.score = battler.weapon:scoreHit(battler, battler.score, eval, close)
        else
            battler.score = battler.score + eval

            if battler.score > 430 then
                battler.score = battler.score * 1.8
            end
            if battler.score >= 400 then
                battler.score = battler.score * 1.25
            end
        end

        bolt:burst()

        if close < 1 then
            bolt.x = self.bolt_target
            Assets.stopAndPlaySound("victor")
            bolt.perfect = true
        elseif close < 5 then
            Assets.stopAndPlaySound("hit")
            bolt.sprite:setColor(128/255, 1, 1)
        elseif close < 28 then
            bolt.sprite:setColor(192/255, 0, 0)
        else
            bolt.sprite:setColor(192/255, 0, 0)
        end

        table.remove(battler.bolts, 1)
        if #battler.bolts > 0 then
            battler.bolts[1].sprite:setSprite(bolt.active_sprite)
        end

        return self:checkAttackEnd(battler, battler.score, battler.bolts, close), 2
    elseif battler.attack_type == "slice" then
        battler.score = math.floor(math.abs(self:getClose(battler)) * (Game.battle.multi_mode and self:getClose(battler) < -20 and 3 or 1))
        if battler.score == 0 then
            battler.score = 1
        end

        battler.stretch = (self.target_sprite.width - battler.score) / self.target_sprite.width

        bolt:flash()
        battler.attacked = true
    
        return battler.score, battler.stretch
    end
end

function LightAttackBox:checkMiss(battler)
    if battler.attack_type == "shoe" then
        if battler.direction == "left" then
            return self:getClose(battler) < -(battler.weapon and battler.weapon.getLightAttackMissZone and battler.weapon:getLightAttackMissZone() or 2)
        else
            return self:getClose(battler) > (battler.weapon and battler.weapon.getLightAttackMissZone and battler.weapon:getLightAttackMissZone() or 2)
        end
    elseif battler.attack_type == "slice" then
        return (battler.direction == "left" and self:getClose(battler) - (Game.battle.multi_mode and 180 or 0) <= -(battler.weapon and battler.weapon.getLightAttackMissZone and battler.weapon:getLightAttackMissZone() or 280) or (battler.direction == "right" and self:getClose(battler) >= (battler.weapon and battler.weapon.getLightAttackMissZone and battler.weapon:getLightAttackMissZone() or 280)))
    end
end

function LightAttackBox:miss(battler)
    if battler.attack_type == "shoe" then
        battler.bolts[1]:fade(battler.speed, battler.direction)

        if #battler.bolts > 1 then
            battler.bolts[2].sprite:setSprite(battler.bolts[2].active_sprite)
        end
    else
        battler.bolts[1]:remove()
    end
    table.remove(battler.bolts, 1)
    return self:checkAttackEnd(battler, battler.score, battler.bolts)
end

function LightAttackBox:update()

    self.timer = self.timer + DTMULT

    -- if (not Game.battle.multi_mode and self.timer > 1 or Game.battle.multi_mode and self.timer > 5) and #self.lanes == 0 then
    if self.timer > 1 and #self.lanes == 0 then
        self:createBolts()
    end
    
    if #self.lanes ~= 0 then

        self.done = true

        for _,battler in ipairs(self.lanes) do
            if not battler.attacked then
                self.done = false
            end
        end

        if not self.done then
            for _,lane in ipairs(self.lanes) do
                if lane.direction == "right" then
                    for _,bolt in ipairs(lane.bolts) do
                        if not bolt.hit then
                            bolt:move(lane.speed * DTMULT, 0)
                        end
                    end
                elseif lane.direction == "left" then
                    for _,bolt in ipairs(lane.bolts) do
                        if not bolt.hit then
                            bolt:move(-lane.speed * DTMULT, 0)
                        end
                    end
                end
            end
        end

        if Game.battle.cancel_attack or self.fading then
            if self.lanes[1].attack_type == "slice" then
                self.target_sprite.scale_x = self.target_sprite.scale_x - 0.06 * DTMULT
            end
            self.target_sprite.alpha = self.target_sprite.alpha - 0.08 * DTMULT
            if self.target_sprite.scale_x < 0.08 or self.target_sprite.alpha < 0.08 then
                Game.battle.timer:after(1, function()
                    self:remove()
                end)
            end
        end
    end

    super.update(self)
end

function LightAttackBox:draw()

    if DEBUG_RENDER then
        local font = Assets.getFont("main", 16)
        love.graphics.setFont(font)

        local offset = 0
        for _,battler in ipairs(self.lanes) do
            Draw.setColor(1, 1, 1, 1)
            if not battler.attacked then
                Game.battle:debugPrintOutline("close: "    .. self:getClose(battler),         0, -200)
            end
            if battler.score then
                Game.battle:debugPrintOutline("score: "    .. battler.score,           0, -200 + 16)
            end
            if battler.stretch then
                Game.battle:debugPrintOutline("stretch: "  .. battler.stretch,         0, -200 + 32)
            end
            Game.battle:debugPrintOutline("attacked: "     .. tostring(battler.attacked), 0, -200 + 48)
            break
        end

    end

    super.draw(self)
end

return LightAttackBox