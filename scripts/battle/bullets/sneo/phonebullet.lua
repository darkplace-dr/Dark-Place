local PhoneBullet, super = Class(YellowSoulBullet)

function PhoneBullet:init(x, y, dir, speed)
    super.init(self, x, y, "battle/bullets/sneo/phonebullet")
	
    self:setScale(1)
	
    self.current_frame = Utils.pick{1, 2, 3, 4}
    self.sprite:setFrame(self.current_frame)
    --self.sprite:setOrigin(0.5, 0.5)

    self.flashsiner = 0
end

function PhoneBullet:update()
    super.update(self)
	
    self.sprite:setFrame(self.current_frame)

    if self.x >= SCREEN_WIDTH + 100 or self.x <= -100 or self.y >= SCREEN_HEIGHT + 100 or self.y <= -100 then
        self:destroy()
    end
    self.physics.direction = self.physics.direction + self.graphics.spin
    self.rotation = self.physics.direction

    if self.physics.direction > 90 and self.physics.direction < 180 then
        self.sprite.flip_x = true
    end

    if self.destroy_on_hit == true then
        self.flashsiner = self.flashsiner + DTMULT
        self:setColor(Utils.mergeColor({0/255, 162/255, 232/255}, COLORS.aqua, (0.25 + (math.sin((self.flashsiner / 3)) * 0.25))))
    end
end

function PhoneBullet:onYellowShot(shot)    self.collider.collidable = false
    self.physics = {direction = 0, speed = 0, gravity = 0, friction = 0}
    Assets.playSound("bomb", 0.7, 1.4 + Utils.random(0.2))

	local death = breakeffect(self.sprite:getTexture(), 0, 0, function() self:remove() end)
	death:setScale(self.sprite:getScale())
    death:setColor(self.color)
	self:addChild(death)
	self.sprite.alpha=0

    return "c", false
end

return PhoneBullet