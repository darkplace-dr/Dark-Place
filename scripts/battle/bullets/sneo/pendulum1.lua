local Pendulum1, super = Class(YellowSoulBullet)

function Pendulum1:init(x, y)
    super.init(self, x, -30)
	
    self.layer = Game.battle.soul.layer - 1

    self.timer = 0
    self.con = 0
    self.flash = false
    self.siner = 0
    
    self.collider.collidable = true
    self.destroy_on_hit = false
	
    self.swingdir = 0
    self.myspeed = -4
    self.length = 170
    self.place = 50
    self.swing = 0

    self.target_x = 240
    self.target_y = -10
    self.sneo_arm_timer = 0
	
    self.remove_offscreen = false
end

function Pendulum1:update()
    super.update(self)
	
    self.timer = self.timer + DTMULT
	
    if (self.length < 90) then
        self.length = self.length + 5*DTMULT
    end
	
    self.x = self.target_x - math.cos(math.rad(self.place)) * self.length
    self.y = self.target_y - math.sin(math.rad(self.place)) * self.length
	
    self.place = self.place + self.myspeed * DTMULT
	
    if (self.place < -90) then
        self.myspeed = self.myspeed + 0.1*DTMULT
        self.swing = 1
    elseif (self.place > -90 and self.swing == 1) then
        self.myspeed = self.myspeed - 0.1*DTMULT
    end

    self.rotation =  math.rad(self.place + 90)
	
    if self.sprite:isSprite("battle/bullets/sneo/arm_cannon") then
        self.sneo_arm_timer = self.sneo_arm_timer + DTMULT

        if self.sneo_arm_timer == 90 then
            self.sneo_arm_timer = 0

            local bullet = self.wave:spawnBullet("sneo/lilguy_bullet", self.x, (self.y + 70))
            bullet.physics.direction = math.rad(90)
            bullet.physics.gravity_direction = math.rad(90)
            bullet:setScale(2)
            bullet.layer = self.layer - 1
            bullet.physics.speed = 4
        end
    end
end

function Pendulum1:draw()
    love.graphics.setColor(COLORS.green)
    love.graphics.setLineWidth(2)
    love.graphics.line(self.sprite.width/2, 20, self.sprite.width/2, (-self.length/2) + 20)
    super.draw(self)
end

function Pendulum1:onYellowShot(shot)
    Assets.playSound("bell", 0.8, 0.7 + Utils.random(0.1))
    if self.collider.collidable == true then
        if not shot.big then
            self.myspeed = self.myspeed - 1
        else
            self.myspeed = -4
        end
        self.flash = true

        if (math.sin(((self.siner + self.swingdir) / 20)) < math.sin((self.siner / 20))) then
            self.swingdir = self.swingdir * -1
        end
    end
	
    return "a", false
end

return Pendulum1