local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/note")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
	
	if self.x <= Game.battle.arena:getLeft() then
		local angle = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
		self.wave:spawnBullet("small_note", self.x, self.y, angle, 6)
		self.wave:spawnBullet("small_note", self.x, self.y, angle + math.rad(45), 6)
		self.wave:spawnBullet("small_note", self.x, self.y, angle - math.rad(45), 6)
		Assets.playSound("sing")
		self:remove()
	end
end

return SmallBullet