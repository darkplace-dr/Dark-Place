local Bouncy, super = Class(Wave)

function Bouncy:init()
    super.init(self)

    self.time = 4.0
end

function Bouncy:onStart()
    self.timer:every(30/60, function()
        self:spawnBullet("poseur/bouncybullet",
            Game.battle.arena.x + love.math.random(-30, 30),
            Game.battle.arena.bottom
        )
    end)
end

return Bouncy