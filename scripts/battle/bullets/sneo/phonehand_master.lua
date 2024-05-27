local PhoneHandMaster, super = Class(YellowSoulBullet)

function PhoneHandMaster:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/phonehand/head_sad")
	
    self.sprite.alpha = 0
    self.destroy_on_hit = false
    self.siner = 0

    self.xdist = 70
	
    self.movedx = 0
    self.shot_health = 200
    self.difficulty = 0
    --self.difficulty = Game.battle:getEnemyBattler("sneo").difficulty
    self.btimer = 0
    self.phone_init = false

    self.bluesiner = 0
    self.blue_color = Utils.mergeColor({0/255, 162/255, 232/255}, COLORS.aqua, (0.25 + (math.sin((self.bluesiner / 3)) * 0.25)))
	
    self.graze_timer = 0
end

function PhoneHandMaster:update()
    super.update(self)
	
    local soul = Game.battle.soul
	
    self.siner = self.siner + DTMULT
    self.bluesiner = self.bluesiner + DTMULT
	
    self:setColor(self.blue_color)
	
    if self.sprite.alpha < 1 then
        self.sprite.alpha = self.sprite.alpha + 0.1 * DTMULT
    end
	
    if self.x >= 480 then
        self.x = 480
    end
	
    if self.grazed == true then
        self.graze_timer = self.graze_timer + DTMULT
        if self.graze_timer >= 3 then
            self.graze_timer = 0
            self.grazed = false
        end
    end
	
    if soul then
        if soul.x > (self.x - 36) then
            soul.x = (self.x - 36)
        end
    end
	
    if self.phone_init == false then
        self.phonehand_top = self.wave:spawnBullet("sneo/phonehand", (self.x - self.xdist), (self.y - 70))
        self.phonehand_top.orientation = "top"
        self.phonehand_top.layer = self.layer - 1
	
        self.phonehand_bottom = self.wave:spawnBullet("sneo/phonehand", (self.x - self.xdist), (self.y + 60))
        self.phonehand_bottom.orientation = "bottom"
        self.phonehand_bottom.layer = self.layer - 1
		
        if self.difficulty == 2 then
            self.phonehand_top.alt = 1
            self.phonehand_bottom.alt = 1
        end
        self.phone_init = true
    end
	
    if self.difficulty == 0 then
        self.y = self.init_y + (math.sin(self.siner / 8)) * 40
    end
    if self.difficulty == 1 or self.difficulty == 2 then
        self.y = self.init_y + (math.sin(self.siner / 10)) * 60
    end
	
    if self.phonehand_top then
        if self.difficulty < 2 then
            self.x = Utils.lerp(self.x, (self.phonehand_top.x + self.xdist), 0.2)
        else
            self.x = self.x - DTMULT
        end
    end
	
    if self.difficulty == 0 or self.difficulty == 1 or self.difficulty == 2 then
        self.btimer = self.btimer + DTMULT
        self.threshold = 20
        if self.difficulty == 1 then
            self.threshold = 15
        end
        if self.difficulty == 2 then
            self.threshold = 30
        end
        if self.btimer >= self.threshold and self.alpha >= 1 then
            self.btimer = 0
			--[[local shot
            local head_timer = 0
			head_timer = head_timer + DTMULT
			
            if self.difficulty < 2 then
                --shot = self.wave:spawnBullet("battle/bullets/sneo/phonehand/joint", self.x, self.y)
            else
                --shot = self.wave:spawnBullet("battle/bullets/sneo/phonehand/joint", self.x, self.y)
            end
			
            shot.physics.speed = 12
            shot.scale_x = 3
            shot.scale_y = 3
			
            if self.difficulty < 2 then
                shot.physics.friction = 1
            else
                shot.physics.speed = 10
            end
			
            shot.physics.direction = 180 + (Utils.random(-5, 5))
            shot.layer = self.layer - 1
            self:setSprite("battle/bullets/sneo/phonehand/head_open")
        else
            self:setSprite("battle/bullets/sneo/head")]]
        end
    end
end

function PhoneHandMaster:onYellowShot(shot)
    self.shot_health = self.shot_health - 1
	
    if self.x <= 480 then
        self.physics.friction = 0.5
		
        if shot.big then
            self.physics.speed_x = self.physics.speed_x + 8
        else
            self.physics.speed_x = self.physics.speed_x + 4
        end
		
        local rembig = shot.big

        self.phonehand_top.physics.friction = 0.5
        self.phonehand_top.physics.speed_x = self.phonehand_top.physics.speed_x + 2
        if rembig then
            self.phonehand_top.physics.speed_x = self.phonehand_top.physics.speed_x + 4
        end
		
        self.phonehand_bottom.physics.friction = 0.5
        self.phonehand_bottom.physics.speed_x = self.phonehand_bottom.physics.speed_x + 2
        if rembig then
            self.phonehand_bottom.physics.speed_x = self.phonehand_bottom.physics.speed_x + 4
        end
    end
	
    Assets.playSound("damage")
	
    if self.x >= 480 then
        self.x = 480
    end
	
    return "a", false
end

function PhoneHandMaster:draw()
    super.draw(self)
end

return PhoneHandMaster