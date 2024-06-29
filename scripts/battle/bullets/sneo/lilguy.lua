local LilGuy, super = Class(YellowSoulBullet)

function LilGuy:init(x, y)
    super.init(self, x, y)
	
    self:setSprite("battle/bullets/sneo/lilguy", 0, false)
    self:setScale(1, 1)
	
    self:setHitbox(10, 14, 20, 22)
	self.collider.collidable = false

    self.blue_siner = 0
    self.red_siner = 0
	
    self.loop = false
    self.loopy_1 = 90
    self.loopy_2 = 240
	
    self.false_speed_y = 0
    self.big_hitbox = 0
    self.big_head = 0
	
    self.alt_direction = 0
    self.alt_speed = 0
    self.alt_friction = 0
    self.alt_gravity = 0
	
    self.angle_speed = 0
    self.angle_adjust = 0
	
    self.change_direction = false
	
    self.bullet_speed = 8

    self.is_cutscene = false

    self.tp = 2
	
    self.timer = Timer()
    self:addChild(self.timer)
end

function LilGuy:update()
    super.update(self)
	
    if self.is_cutscene == false then
        if self.x >= Game.battle.camera.x/2 + 1000 or self.x <= Game.battle.camera.x/2 - 200 or self.y >= Game.battle.camera.y/2 + 600 or self.y <= Game.battle.camera.y/2 - 200 then
            self:remove()
        end
    end

    self.physics.direction = self.physics.direction + self.angle_speed * DTMULT
	
    if self.angle_adjust == 1 then
        self.sprite.angle = self.physics.direction
    end
	
    if self.collider.collidable == true then
        self.blue_siner = self.blue_siner + DTMULT
        self:setColor(Utils.mergeColor({0/255, 162/255, 232/255}, COLORS.aqua, (0.25 + math.sin(self.blue_siner / 3)) * 0.25))
    end

    if self.loop == true then
        if self.y < self.loopy_1 then
            self.y = self.loopy_2 - (self.loopy_1 - self.y) * DTMULT
		end
        if self.y > self.loopy_2 then
            self.y = self.loopy_1 + (self.y - self.loopy_2) * DTMULT
        end
    end

    self.y = self.y + self.false_speed_y * DTMULT

	for i,shot in ipairs(Game.stage:getObjects(YellowSoulShot)) do
        if self.big_head == 1 and self.bullet_collider:collidesWith(shot) then
            Assets.playSound("bell", 0.8, 0.7 + Utils.random(0.1))
            shot.x = shot.x - math.abs(shot.physics.speed_x)
            shot.physics.speed_x = -8
            shot.physics.speed_y = Utils.pick{-8, 8, 10, -10}
        end
        if self.big_hitbox == 1 then
        
        end
    end
end

function LilGuy:switchToAlternatePhysics()
    if self.change_direction then
	    self.physics.direction = self.alt_direction
        self.physics.gravity = self.alt_gravity
	    self.physics.friction = self.alt_friction
	    self.physics.speed_x = self.alt_speed
    end
end

function LilGuy:fire()
    if self.collider.collidable == true then
        local bullet = self.wave:spawnBullet("sneo/lilguy_bullet", self.x, self.y + 12)
        bullet.physics.speed = self.bullet_speed
        bullet.physics.direction = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
        bullet.layer = self.layer - 1
    end
end

function LilGuy:resetAnimationIndex()
    if self.collider.collidable == true then
        self:setSprite("battle/bullets/sneo/lilguy", 0.1, false)
    end
end

function LilGuy:onCollide(soul)
    super.onCollide(self, soul)

    self.collider.collidable = false
end

function LilGuy:destroy(shot)
    self.collider.collidable = false
    self.physics = {direction = 0, speed = 0, gravity = 0, friction = 0}
    Assets.playSound("bomb", 0.7, 1.1 + Utils.random(0.2))
	
	local death = AfterImageCut(self.sprite:getTexture(), function() self:remove() end)
	death:setScale(self.sprite:getScale())
    death:setColor(self.color)
	self:addChild(death)
	self.sprite.alpha=0

    return "a", false
end

return LilGuy