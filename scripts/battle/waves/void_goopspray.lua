local VoidGoopSpray, super = Class(Wave)

function VoidGoopSpray:init()
    super.init(self)

    self.time = 10
end

function VoidGoopSpray:onStart()
    local battlers = Game.battle:getActiveEnemies()
    self.timer:every(1.5*#battlers, function()
        local attackers = self:getAttackers()

        for _, attacker in ipairs(attackers) do
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            Assets.stopAndPlaySound("splash")
            self:spawnBullet("void_homingblob", x, y, math.rad(math.random(360)), 0)
        end
    end)
end

function VoidGoopSpray:update()
    super.update(self)
end

return VoidGoopSpray