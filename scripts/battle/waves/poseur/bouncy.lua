local Bouncy, super = Class(Wave)

function Bouncy:onStart()
    self.timer:every(1/2, function()
        local posx = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
        local posy = Game.battle.arena.top

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("poseur/bouncybullet", posx, posy)
    end)
end

function Bouncy:update()
    -- Code here gets called every frame

    super.update(self)
end

return Bouncy