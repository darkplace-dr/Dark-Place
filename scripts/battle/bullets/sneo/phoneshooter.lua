local PhoneShooter, super = Class(YellowSoulBullet)

function PhoneShooter:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/phone")
	
    self.sprite:play(0.2, false)
    self:setOrigin(0.5, 0)
    self.color = {0/255, 162/255, 232/255}

    self.btimer = 0
    self.state = 0
    self.siner = 0
    self.destroy_on_hit = true
    self.shot_health = 40

    self.swingdir = 1
    self.ydrop = 0
    self.side = 0
    self.type = 0
	
	self.init_x = x
	self.init_y = y
	
    Assets.playSound("phone", 1, Utils.random(0.95, 1.05))
end

function PhoneShooter:update()
    super.update(self)
	
    if self.side == 0 then
        self.sprite:setFrame(3)
    end
    if self.side == 1 then
        self.sprite:setFrame(1)
    end
	
    if self.state == 0 and self.ydrop >= 1 then
        self.state = 1
    end
    if self.state == 1 then
        self.btimer = self.btimer + DTMULT
        if self.type == 0 then
            if self.btimer > 10 then
                Assets.playSound("wing")
                for i = 1,3 do
                    local d = self.wave:spawnBullet("sneo/phonebullet", self.x - 12, self.y + 12)
                    d.destroy_on_hit = true
                    d.physics.direction = ((math.rad(math.random(-20, 20)) + 59.5) + d.rotation)
                    d.physics.speed = 5
                end
                self.btimer = 0
            end
        end
        if self.type == 1 then
            if self.btimer > 40 then
                Assets.playSound("wing")
                for i = 1,3 do
                    if self.side == 0 then
                        local d = self.wave:spawnBullet("sneo/phonebullet", self.x - 12, self.y + 12)
                        d.destroy_on_hit = true
                        d.layer = self.layer - 1
                        d.physics.direction = ((math.rad(math.random(-20, 20)) + 59.5) + d.rotation)
                        d.physics.speed = 5
                    else
                        local d = self.wave:spawnBullet("sneo/phonebullet", self.x + 12, self.y + 12)
                        d.destroy_on_hit = true
                        d.layer = self.layer - 1
                        d.physics.direction = ((math.rad(math.random(-20, 20))) + d.rotation)
                        d.physics.speed = 5
                    end
                end
                self.btimer = 0
            end
        end
    end
end

function PhoneShooter:onYellowShot(shot)
    Assets.playSound("damage", 1.1, 0.7 + Utils.random(0.4))

    if self.destroyable == true then
        self:flash()
        if not shot.big then
            self.shot_health = self.shot_health - 1
        else
            self.shot_health = self.shot_health - 4
        end

        if not shot.big or self.shot_health <= 0 then
            if (math.sin(((self.siner + self.swingdir) / 20)) < math.sin((self.siner / 20))) then
                self.swingdir = self.swingdir * -DTMULT
            end
        end
    end
    return "c", false
end

function PhoneShooter:draw()
    super.draw(self)

    love.graphics.setColor(COLORS.white)
	
    if self.state < 2 then
        self.siner = self.siner + self.swingdir*DTMULT

        love.graphics.setLineWidth(1)
        love.graphics.line(32, 5, 0, -SCREEN_HEIGHT)
	    --love.graphics.line(4, 7,  -SCREEN_HEIGHT * 2, 2)
		
        self.rotation = (math.sin((self.siner / 20)) * 0.15)
        self.x = (self.init_x + (math.sin((self.siner / 20)) * 0.15))
		
        if self.ydrop < 1 then
            self.ydrop = self.ydrop + 0.02*DTMULT
        end
		
        self.y = Utils.ease(-90, self.init_y, self.ydrop, "outElastic")

    elseif self.state == 3 then
    end
end

return PhoneShooter