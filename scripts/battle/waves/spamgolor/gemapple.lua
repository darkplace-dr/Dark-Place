local GemApple, super = Class(Wave)

function GemApple:init()
    super.init(self)
	self.time = 9
end

function GemApple:onStart()
    self.timer:every(0.75, function()
        local attackers = self:getAttackers()
        for _, attacker in ipairs(attackers) do
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
            local speed = love.math.random(5, 7) + love.math.random()
            self:spawnBullet("gemapple", x, y, angle, speed)
        end
    end)
end

return GemApple