local SmallBullet, super = Class(HomingBullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/eggman/bigarm")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	
	self:setScale(0.5)
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

function SmallBullet:onHome()
    self.homing_timer = 1
	
	Game.battle.enemies[1]:hurt(50)
	Assets.playSound("metal_damage")
	if Game.battle.enemies[1].health <= 0 then
		Game.battle.encounter:onWavesDone()
	end
end

return SmallBullet