local Racket1, super = Class(Bullet)

function Racket1:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/tennisracket")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
	
	self.tp = 0
	self.destroy_on_hit = false
	self.time_bonus = 0
	
	--self.collider = Collider(self, Hitbox(self, 0, 0, 16, 24))
end

function Racket1:update()
    -- For more complicated bullet behaviours, code here gets called every update
	
	self.x = Game.battle.soul.x + 16
	self.y = Game.battle.soul.y - 24

    super.update(self)
end

function Racket1:onCollide(soul)
	-- don't deal damage
end

return Racket1