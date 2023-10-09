local NEOPonmanActor, super = Class(ActorSprite)

function NEOPonmanActor:init(actor)
    super.init(self, actor)

    self.draw_children_below = 0
    self.draw_children_above = 1

    local eye = Sprite("battle/enemies/neo_ponman/eye")
    eye.visible = true
    eye.layer = self.layer + 1
    eye.angle = 0
    eye.radius = 0

    self.eye = eye
    self:addChild(eye)

    self.addup = false
    self.timer = 0
	
    self.eyecon = 0
    self.pontotal = 1
    self.spin_speed = 0
    self.x_angle = 0
	
    self.grandbuffer = 0
    self.shotbuffer = 0
	
    self.shotcount = 0
    self.totalshotcount= 0
    self.maxshot = 0
	
    self.maxtimer = 0
end

function NEOPonmanActor:update()
    super.update(self)

    self.timer = self.timer + DTMULT

    if self.eyecon == 0 then
        self.eye.angle = math.rad(180 + (math.sin(self.timer / 8) * 30))

        if self.eye.radius < 4 then
            self.eye.radius = self.eye.radius + DTMULT
        else
            self.eye.radius = 4
        end

        if self.addup == false then
            self:setFrame(1)
        else
            self:setFrame(3)
        end

        if self.eye.angle > math.rad(200) then
            self:setFrame(0)
            self.addup = true
        end
        if self.eye.angle < math.rad(160) then
            self:setFrame(2)
            self.addup = false
        end
    end


    if self.eyecon == 10 then
        self:setFrame(1)
        self.eye.radius = self.eye.radius * 0.7
		
        if math.abs(self.eye.radius) < 0.5 then
            self.eye.radius = 0
            self.eye.angle = 0
        end
    end


    if self.eyecon == 20 then
        if self.spin_speed == 0 then
            self.spin_speed = self.spin_speed + DTMULT
        end

        if self.pontotal > 1 then
            self.timer = self.timer + self.spin_speed / 2
        else
            self.timer = self.timer + self.spin_speed / 5
        end

        self.eye.angle = math.rad(180 + (math.sin(self.timer / 8) * 70))
		
        if self.eye.radius < 4 then
            self.eye.radius = self.eye.radius + DTMULT
        end
		
        self.grandbuffer = self.grandbuffer - DTMULT
		
        if Game.battle.soul then
            self.x_angle = Utils.angle(self.eye.x + 28, self.eye.y + 32, Game.battle.soul.x, Game.battle.soul.y)
        else
            self.x_angle = 0
        end
		
        if (math.abs(self.x_angle - self.eye.angle) < 25 and self.eye.angle >= 120 and self.eye.angle <= 240) then
            if self.shotbuffer < 0 and self.shotcount < 3 and self.totalshotcount < self.maxshot then
                
				self.shotcount = self.shotcount + DTMULT
                if self.pontotal == 2 then
                    self.shotcount = self.shotcount + DTMULT
                end
                if self.pontotal >= 3 then
                    self.shotcount = self.shotcount + DTMULT
                end
				
                if self.shotcount >= 3 then
                    self.totalshotcount = self.totalshotcount + DTMULT
                    self.shotcount = 0

                    if self.pontotal == 1 then
                        self.shotbuffer = 10
                    end
                    if self.pontotal == 2 then
                        self.shotbuffer = 13
                    end
                    if self.pontotal >= 3 then
                        self.shotbuffer = 22
                    end
                end
                if self.totalshotcount >= self.maxshot then
                    self.maxtimer = 1
                end
				
                Assets.playSound("hurt", 1, 0.7 + Utils.random(0.5))

                local bullet = self.wave:spawnBullet("ch1_fields/neo_ponman/diamond_black", (self.eye.x + 28) + self.x, (self.eye.y + 32) + self.y)
                bullet.physics.speed = 8
                bullet.tp = 1.5
                bullet.physics.friction = -0.11
                if self.pontotal == 1 then
                    bullet.physics.friction = -0.12
                end
                bullet.physics.direction = self.eye.angle
            end
        end
        if self.maxtimer > 0 then
            self.maxtimer = self.maxtimer + DTMULT
        end
    end

    self.shotbuffer = self.shotbuffer - DTMULT

    if self.eye.angle < math.rad(0) then
        self.eye.angle = self.eye.angle + math.rad(360)*DTMULT
    end
    if self.eye.angle > math.rad(360) then
        self.eye.angle = self.eye.angle - math.rad(360)*DTMULT
    end

    self.eye.x = math.cos(self.eye.angle)*self.eye.radius + 12
    self.eye.y = math.sin(self.eye.angle)*self.eye.radius + 14
end

return NEOPonmanActor