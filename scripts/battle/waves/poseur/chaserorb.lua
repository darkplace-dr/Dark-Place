local ChaserOrb, super = Class(Wave)

function ChaserOrb:init()
    super.init(self)

    self.time = 4.0
end

function ChaserOrb:onStart()
    self:spawnBullet("poseur/chaserbullet", Game.battle.arena.right, Game.battle.arena.top)
end

return ChaserOrb