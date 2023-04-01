local ChaserOrb, super = Class(Wave)

function ChaserOrb:onStart()
    self:spawnBullet("poseur/chaserbullet", Game.battle.arena.right, Game.battle.arena.top)
end

return ChaserOrb