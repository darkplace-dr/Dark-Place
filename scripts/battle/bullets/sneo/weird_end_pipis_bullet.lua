local WeirdEndPipisBullet, super = Class(YellowSoulBullet)

function WeirdEndPipisBullet:init(x, y, dir, speed)
    super:init(self, x, y)
	
	self:setScale(1,1)
	
    self.timer = 0
    self.con = 0
    self.target = 1
    self.damage = 16
    self.color = {0/255, 42/255, 142/255}
	
	self.collider = CircleCollider(self, 12, 10, 10)

    self.remove_offscreen = false
end

function WeirdEndPipisBullet:destroy(shot)
    Assets.playSound("bomb", 0.5)
    self.physics = {
	    speed = 0,
	}
    self.collider.collidable = false
	
	local death = breakeffect(self.sprite:getTexture(), -22, -5, function() self:remove() end)
	death:setColor(5/255, 183/255, 239/255)
	death:setScale(self.sprite:getScale())
	self:addChild(death)
	self.sprite.alpha=0
    self.sprite:setOrigin(0.5, 0.5)
end

return WeirdEndPipisBullet