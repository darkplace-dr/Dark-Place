---@class Slapper : Object
---@overload fun(...) : Slapper
local Slapper, super = Class(Object)

function Slapper:init(user, target)
    super.init(self, 0, 0)

    self.caster = user

    self.target = target

    self.font = Assets.getFont("main")

    self.hits = 0
    self.timer = 0
    self.snowspeed = 0
    self.thing = 5
    self.damage = 0
    self.power = user.chara:getStat("attack")
    self.init = true

end

function Slapper:update()
    super.update(self)

    if Input.pressed("z") then
        self.caster:setAnimation("battle/attack_repeat")
        if self.target.health > 0 then
            self.hits = self.hits + 1
            Game.battle:shakeCamera(4)
            Assets.playSound("damage")
            self.target:hurt(self.power, self.caster, self.target.onDefeatFatal)
            self.target:flash()
            self.target.hit_count = 0
        end
    end

    if self.thing <= 0 then
        Game.battle:finishAction()
        self:remove()
    end

end

function Slapper:drawTiled(x, y, alpha)
    Draw.setColor(1, 1, 1, alpha)

end

function Slapper:draw()
    love.graphics.setFont(self.font)
    love.graphics.print("PRESS (Z) REPEATEDLY", 220, 150)
    love.graphics.print("X"..self.hits, 320, 180)

    if self.snowspeed == 0 then
        self.snowspeed = 1
        Game.battle.timer:tween(6, self, {thing = -1})
    end

    if self.hits >= 50 then
        love.graphics.print("WOW!!!", 170, 90)
    end

    if self.thing >= 4 then
        love.graphics.print("5", 330, 120)
    elseif self.thing >= 3 then
        love.graphics.print("4", 330, 120)
    elseif self.thing >= 2 then
        love.graphics.print("3", 330, 120)
    elseif self.thing >= 1 then
        love.graphics.print("2", 330, 120)
    elseif self.thing >= 0 then
        love.graphics.print("1", 330, 120)
    end

    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end

return Slapper