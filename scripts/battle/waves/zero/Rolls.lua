local Rolls, super = Class(Wave)

function Rolls:init()
    super.init(self)
    self.time = 5
    self.user = self:getAttackers()[1]
    self.user.layer_old = self.user.layer
    self.user.layer = BATTLE_LAYERS["top"]
    self:setArenaSize(284)

end

function Rolls:onStart()

    self.user.sprite:set("drawsword/normal")
    Assets.playSound("sword_draw_quick")

    self.timer:after(0.5, function ()
        self:attackSoul("right")
        self.timer:every(0.7, function ()
            self:attackSoul(Utils.pick{"left", "right"})
        end)
    end)

end

function Rolls:update()
    -- Code here gets called every frame
    self.user.color[1] = Utils.approach(self.user.color[1], 1, DTMULT/8)
    super.update(self)
end

function Rolls:draw()

end

function Rolls:attackSoul(side)
    local soul = Game.battle.soul
    local time = 0.4
    Assets.playSound("zero/roll")
    Assets.playSound("shakerbreaker", 0.7)
    self.user.sprite:set("roll")

    self.timer:everyInstant(5/30, function ()
        local afterimage = AfterImage(self.user.sprite, 0.5)
        afterimage.debug_select = false
        afterimage.color = self.user.color
        self.user:addChild(afterimage)
    end, 5)

    self.user.color[1] = 0
    Game.battle.timer:tween(time, self.user, {y = soul.y + 20}, "linear")

    if side == "right" then
        Game.battle.timer:tween(time, self.user, {x = soul.x + 70}, "linear")
    elseif side == "left" then
        Game.battle.timer:tween(time, self.user, {x = soul.x - 110}, "linear")
    end

    self.timer:after((time + 0.05), function ()

        if side == "right" then
            if self.user.flip_x == true then
                self.user.flip_x = false
                self.user.x = self.user.x + 40
            end
        elseif side == "left" then
            if self.user.flip_x == false then
                self.user.flip_x = true
                self.user.x = self.user.x - 40
            end
        end




        self.user.sprite:set("attack")
        local bullet = self:spawnBulletTo(self.user, "zero/katanaslash", -45, 20)
    end)
    
end

function Rolls:onEnd()
    self.user.sprite:set("drawsword/normal_8")
    if self.user.flip_x == true then
        self.user.flip_x = false
        self.user.x = self.user.x + 40
    end

    self.timer:clear()

    self.user.physics.speed = 0
    Game.battle.timer:tween(0.5, self.user, {x = 550}, "out-expo")
    Game.battle.timer:tween(0.5, self.user, {y = 216}, "out-expo")

    self.timer:everyInstant(2/30, function ()
        local afterimage = AfterImage(self.user.sprite, 0.5)
        afterimage.debug_select = false
        self.user:addChild(afterimage)
    end, 5)
    self.user.color = {1,1,1}


    Game.battle.timer:after(0.5, function ()
        self.user.layer = self.user.layer_old
        self.user.sprite:set("drawsword/sheath")
        if self.user.x ~= 550 or self.user.y ~= 216 then -- do it again, just in case
            Game.battle.timer:tween(0.5, self.user, {x = 550}, "out-expo")
            Game.battle.timer:tween(0.5, self.user, {y = 216}, "out-expo")

            self.timer:everyInstant(2/30, function ()
                local afterimage = AfterImage(self.user.sprite, 0.5)
                afterimage.debug_select = false
                self.user:addChild(afterimage)
            end, 5)

        end
    end)

    super.onEnd(self)
end

return Rolls