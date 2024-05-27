local PhoneHand, super = Class(Bullet)

function PhoneHand:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/phonehand/phone")

    self:setScale(1)
    self.alpha = 0
    self.destroy_on_hit = false
	
    self.phone_init = false
	
    self.siner = 0
    self.crawlsiner = 0
	
    self.joint_x = 0
    self.joint_y = 0
    self.remjoint_y = self.joint_y
	
    self.amplitude = 4
    self.period = 5
    self.orientation = nil
	
    self.boss = Game.battle:getEnemyBattler("sneo")
    self.difficulty = 0
    self.btimer = 0
    self.moving = 0
    self.wasmoving = 0
    self.alt = 0
    self.visibiliytimer = 0
end

function PhoneHand:update()
    super.update(self)
	
    if self.phone_init == false then
        if self.boss then
            if self.orientation == "top" then
                self.joint_x = 460 - 10
                self.joint_y = self.y - 30
            end
            if self.orientation == "bottom" then
                self.scale_y = -1
                self.joint_x = 460 - 10
                self.joint_y = self.y + 30
            end
            self.remjoint_y = self.joint_y
            self.phone_init = true
        end
    end
	
    if self.btimer == 13 then
        if self.scale_y > 0 then
            self.scale_y = 1
        end
        if self.scale_y < 0 then
            self.scale_y = -1
        end
    end
	
    if self.scale_y > 1 then
        self.scale_y = self.scale_y - 0.2 * DTMULT
    end
    if self.scale_y < -1 then
        self.scale_y = self.scale_y + 0.2 * DTMULT
    end
	
    self.movingcheck = 0
	
    if self.alt == 0 then
        self.crawlsiner = self.crawlsiner + DTMULT
        if self.orientation == "top" then
            if math.sin(self.crawlsiner / self.period) < 0 then
                self.wasmoving = 1
                self.movingcheck = 1
                self.y = self.y + ((math.cos(self.crawlsiner / self.period)) * self.amplitude * 2) * DTMULT
                self.x = self.x + ((math.sin(self.crawlsiner / self.period)) * self.amplitude) * DTMULT
            end
        end
        if self.orientation == "bottom" then
            if math.cos(self.crawlsiner / self.period + 1.570796326794897) < 0 then
                self.wasmoving = 1
                self.movingcheck = 1
                self.y = self.y + ((math.sin(self.crawlsiner / self.period + 1.570796326794897)) * self.amplitude * 2) * DTMULT
                self.x = self.x + ((math.cos(self.crawlsiner / self.period + 1.570796326794897)) * self.amplitude) * DTMULT
            end
        end
        if self.boss then
            self.joint_x = (self.x + self.boss.fake_x) / 2
            self.joint_y = (self.remjoint_y + self.y) / 2
        end
    end
	
    if self.alt == 1 and self.boss then
        if self.orientation == "top" then
            self.crawlsiner = self.crawlsiner + DTMULT
        else
            self.crawlsiner = self.crawlsiner - DTMULT
        end
		
        local xx = 200
        local endx = 460 - 20
		
        self.x = xx + (endx - xx) / 2 + (math.sin(self.crawlsiner / 12)) * (endx - xx) / 2
		
        self.btimer = self.btimer + DTMULT
		
        local threshold = 18
		
        if self.orientation == "top" then
            threshold = 28
        end
		
        if self.btimer >= threshold then
            local shot = self.wave:spawnBullet("battle/bullets/sneo/phonehand/soundbullet", self.x, self.y)
            if self.orientation == "top" then
                shot.physics.direction = 270 + (Utils.random(-2, 2))
            end
            if self.orientation == "bottom" then
                shot.physics.direction = 90 + (Utils.random(-2, 2))
            end
            shot:setScale(1)
            shot.physics.speed = 3
            shot.rotation = shot.physics.direction
            shot.tp = 3
            self.btimer = 0
			
            if self.orientation == "top" then
                self.btimer = 10
            else
                self.btimer = 0
            end
        end
		
        if self.boss then
            self.joint_x = (self.x + self.boss.fake_x) / 2
            self.joint_y = (self.remjoint_y + self.y) / 2
        end
    end
	
    if self.difficulty == 99 then
        if self.movingcheck == 0 and self.wasmoving == 1 then
            self.wasmoving = 0
            for i = 1, 3 do
                local shot = self.wave:spawnBullet("battle/bullets/sneo/phonehand/soundbullet", self.x, self.y)
                if self.orientation == "top" then
                    shot.physics.direction = 270 + (Utils.random(-10, 10))
                end
                if self.orientation == "bottom" then
                    shot.physics.direction = 90 + (Utils.random(-10, 10))
                end
			    shot:setScale(1)
                shot.physics.speed = 8
                shot.rotation = shot.physics.direction
                shot.tp = 3
            end
        end
    end
	
    if self.difficulty == 99 then
        if self.btimer >= 6 then
            local shot = self.wave:spawnBullet("battle/bullets/sneo/phonehand/soundbullet", self.x, self.y)
			if self.orientation == "top" then
                shot.physics.direction = math.rad(270) + (Utils.random(-4, 4))
			end
			if self.orientation == "bottom" then
                shot.physics.direction = math.rad(90) + (Utils.random(-4, 4))
			end
			shot:setScale(1)
			shot.physics.speed = 4
			shot.rotation = shot.physics.direction
			shot.tp = 3
			self.btimer = 0
        end
    end
end

function PhoneHand:draw()
    if self.alpha < 1 then
        self.alpha = self.alpha + 0.1 * DTMULT
    end
	
    Draw.setColor(0, 0.5, 0, self.alpha)
    love.graphics.setLineWidth(4)
    love.graphics.line(29, 13, self.joint_x, self.joint_y)
	
	-- joints should be positioned where the head is, but for some reason they aren't.
    if self.boss then
        love.graphics.setLineWidth(4)
        love.graphics.line(self.joint_x, self.joint_y, self.boss.x, self.boss.y)
        for i = 0, 4 do
            Draw.draw(Assets.getTexture("battle/bullets/sneo/phonehand/joint"), Utils.lerp(29, self.joint_x, (i / 4)), Utils.lerp(13, self.joint_y, (i / 4)), 0, 2, 2, 11/2, 11/2)
            Draw.draw(Assets.getTexture("battle/bullets/sneo/phonehand/joint"), Utils.lerp(self.joint_x, self.boss.x, (i / 4)), Utils.lerp(self.joint_y, self.boss.y, (i / 4)), 0, 2, 2, 11/2, 11/2)
        end
    end
	
    super.draw(self)
end

return PhoneHand