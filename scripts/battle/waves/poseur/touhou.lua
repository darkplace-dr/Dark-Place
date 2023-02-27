local Touhou, super = Class(Wave)

function Touhou:onStart()
    local mult = 0.5
    self.timer:every(1/2, function()
        local numbullets = 10
        for i=1,numbullets+1 do
            local bullet = self:spawnBullet("poseur/touhoubullet", Game.battle.arena.right + 80, (Game.battle.arena.top + Game.battle.arena.bottom) / 2)
            bullet.offset = math.pi * 2 * i / numbullets
            bullet.negmult = mult
            mult = mult + 0.05
        end
    end)
end

function Touhou:update()
    -- Code here gets called every frame

    super.update(self)
end

return Touhou