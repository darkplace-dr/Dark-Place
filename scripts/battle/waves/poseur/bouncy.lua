local Bouncy, super = Class(Wave)

function Bouncy:init()
    super.init(self)

    self.time = 4.0
end

function Bouncy:onStart()
    -- wt += 1 then (if wt%30 == 0) ...
    self.timer:every((30-1)/60, function()
        self:spawnBullet("poseur/bouncybullet",
            Game.battle.arena.x + love.math.random(-30, 30),
            Game.battle.arena.top
        )
    end)
end

return Bouncy