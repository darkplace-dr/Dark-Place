local Touhou, super = Class(Wave)

function Touhou:onStart()
    local mult = 0.5
	local yOffset = 80
    self.timer:everyInstant(1/2, function()
        local numbullets = 10
        for i = 1, numbullets do
            local bullet = self:spawnBullet("poseur/touhoubullet", SCREEN_WIDTH / 2, yOffset)
            bullet.offset = math.pi * 2 * i / numbullets
            bullet.negmult = mult
            mult = mult + 0.05
        end
    end)
end

return Touhou
