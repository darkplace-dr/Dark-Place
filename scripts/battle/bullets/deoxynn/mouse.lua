local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "battle/bullets/deoxynn/mouse")

    -- Origin point (will be rotated around it)
    self:setOrigin(0.5, 0.5)
	
	self:setHitbox(10,-4,24,36)
	
	self.scale_x = 1
	self.scale_y = 1

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = math.pi
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    -- Destroy this bullet when it damages the player
    self.destroy_on_hit = false
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
	if self.x < Game.battle.arena.x then
		self:setParent(Game.battle)
	end
end

return SmallBullet