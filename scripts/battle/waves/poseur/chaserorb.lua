local ChaserOrb, super = Class(Wave)

function ChaserOrb:onStart()
    local bullet = self:spawnBullet("poseur/chaserbullet", Game.battle.arena.right, Game.battle.arena.top)
end

function ChaserOrb:update()
    -- Code here gets called every frame

    super.update(self)
end

return ChaserOrb