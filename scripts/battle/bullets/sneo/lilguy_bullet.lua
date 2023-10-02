local LilGuyBullet, super = Class(Bullet)

function LilGuyBullet:init(x, y, dir, speed)
    super.init(self, x, y, dir, speed)
	
    self:setSprite("battle/bullets/sneo/lilguy_bullet")
	self:setScale(1,1)
    self:setHitbox(6, 8, 8, 8)
	
    self.physics.direction = dir
    self.physics.speed = speed

    self.graphics.spin = 0.36
end

function LilGuyBullet:update()
    super.update(self)
	
    if self.x >= (SCREEN_WIDTH + 100) or self.x <= -100 or self.y >= (SCREEN_HEIGHT + 100) or self.y <= -100 then
        self:remove()
    end
end

return LilGuyBullet