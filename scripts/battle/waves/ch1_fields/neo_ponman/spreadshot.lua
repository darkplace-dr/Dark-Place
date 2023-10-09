local Spreadshot, super = Class(Wave)

function Spreadshot:init()
    super.init(self)
	
    self.time = 6
	
    self.enemies = self:getAttackers()
end

function Spreadshot:onStart()
    for _, enemy in ipairs(self.enemies) do
        enemy.sprite.eyecon = 20
		
        --[[self.timer:every(1/4, function()
            for i = 0, 3 do
                local bullet = self:spawnBullet("neo_ponman/diamond_black", enemy.sprite.eye.x, enemy.sprite.eye.y)
                bullet.physics.speed = -8
                bullet.physics.fricition = 0.2
            end
        end)]]
    end
end

function Spreadshot:update()
    super.update(self)
end

function Spreadshot:onEnd()
    for _, enemy in ipairs(self.enemies) do
        enemy.sprite.eyecon = 0
    end
end

return Spreadshot