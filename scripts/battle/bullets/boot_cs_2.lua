local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/booty_cs")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
	local souldir = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
    self.physics.direction = souldir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = 6
	
	self:setScale(1,1)
	self:setOrigin(0.5,0.5)
	
	self.tp = 0
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

function SmallBullet:onShot(star)
    star:remove()
	if Game.battle.soul then
		Game.battle.soul.star = nil
	end
	self.physics.speed = -6
	Game:giveTension(3)
end

return SmallBullet