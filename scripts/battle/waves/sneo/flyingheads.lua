local FlyingHeads, super = Class(Wave)

function FlyingHeads:init()
    super.init(self)
	
	self.time = 15
	self:setArenaSize(240, 110)
	self:setArenaPosition(300, 175)

    self.sneo = Game.battle:getEnemyBattler("sneo")
	self.sneo.sprite:setPartSine("head", 2)
	
    self.wave_type = 2
    self.type = 5
	
    self.spawn_timer = 0
	
    self.row = 0
    self.rowy = 0
    self.prevrow = 0
    self.prevrowy = 0
	
    self.spawncount = 0
    self.firstspawn = 0
	
    self.debug_render = false
end


function FlyingHeads:onStart()
	Game.battle:swapSoul(YellowSoul())

    if self.wave_type == 1 then
	    self.type = 2
    end	
    if self.wave_type == 2 then
	    self.type = 5
        self.sneo:setAnimation("walk")
        self.sneo.sprite.head:setFrame(3)
        self.sneo:setMode("shoot")
    end
	
    self.debug_render = true
end


function FlyingHeads:update()
    super.update(self)
	
    self.spawn_timer = self.spawn_timer + DTMULT
	
    if self.type == 1 or self.type == 2 or self.type == 3 or self.type == 4 or self.type == 5 or self.type == 6 or self.type == 7 then
        if self.spawn_timer == 1 then
            if self.type == 1 then
                self.row = Utils.pick{0, 1}
                if self.prevrow == 2 then
                    self.row = Utils.pick{0, 1}
                end
            end
			
            if self.type == 2 then
                local aa = Utils.pick{0, 1, 2}
                if prevrow_y == 0 then
                    aa = Utils.pick{1, 2}
                end
                if prevrow_y == 1 then
                    aa = Utils.pick{0, 2}
                end
                if prevrow_y == 2 then
                    aa = Utils.pick{0, 1}
                end
                self.rowy = 210 - 46 * aa
                prevrow_y = aa
                self.row = 2
            end
			
            if self.type == 3 or self.type == 4 then
                self.rowy = 210 - 40 * (Utils.pick{0, 1})
                self.row = Utils.pick{0, 1, 3, 6}
                if self.prevrow == 2 then
                    self.row = Utils.pick{0, 1, 3, 6}
                end
                if self.prevrow == 3 then
                    self.row = Utils.pick{0, 1}
                end
                if self.row == 3 and self.firstspawn == 0 then
                    self.row = Utils.pick{0, 1}
                end
                self.firstspawn = 1
            end
			
            if self.type == 5 then
                self.rowy = 210 - 40 * (Utils.pick{0, 1, 2})
                self.row = Utils.pick{0, 1, 2, 2, 3, 6}
                if self.prevrow == 2 then
                    self.row = Utils.pick{0, 1, 3, 6}
                end
                if self.prevrow == 3 then
                    self.row = Utils.pick{0, 1, 2}
                end
            end
		   
            if self.type == 6 then
                self.row = 6
            end
		   
            if self.type == 7 then
                self.row = 7
            end
        end
		
        if self.spawn_timer == 5 or self.spawn_timer == 10 or self.spawn_timer == 15 or self.spawn_timer == 20 then
            if self.row == 0 or self.row == 1 or self.row == 2 then
                local guy = self:spawnBullet("sneo/lilguy", 700, 280)
                guy.physics.speed_x = -18
                guy.physics.friction = -0.1
                guy.physics.speed_y = -2
                guy.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                guy.timer:after(40/30, function() guy:fire() end)
                guy.timer:after(32/30, function() guy:resetAnimationIndex() end)
                guy.physics.gravity = 0.5
                guy.physics.gravity_direction = math.rad(0)
                guy.collider.collidable = true
                guy.change_direction = false
                guy.altdirection = 0
                guy.altspeed = 4
                guy.altfriction = -0.2
                guy.altgravity = 0

                if self.type == 2 then
                    guy.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                end
				
                if self.row == 1 then
                    guy.y = guy.y - 240
                    guy.physics.speed_y = -guy.physics.speed_y
                end
				
                if self.row == 2 then
                    guy.y = guy.y - 120
                    guy.physics.speed_y = 0
                    guy.physics.speed_x = -21
                end
				
                if self.row == 2 and self.type == 2 then
                    guy.physics.speed_x = -21
                    guy.physics.gravity = 0
                    guy.physics.friction = 0.5
                    guy.timer:after(36/30, function() guy:switchToAlternatePhysics() end)
                    guy.change_direction = true
                end
				
                if (self.type == 2 or self.type == 3 or self.type == 4 or self.type == 5) and self.row == 2 then
                    guy.y = self.rowy
                end
		    end
			
            if self.row == 3 and self.spawn_timer ~= 20 then
                for guyi = 0, 1 do
                    local guy = {}
					
                    guy[guyi] = self:spawnBullet("sneo/lilguy", 300, -40 + 400 * guyi)
                    guy[guyi].physics.speed_y = 18 - 36 * guyi
                    guy[guyi].timer:after(44/30, function() guy[guyi]:switchToAlternatePhysics() end)
                    guy[guyi].timer:after(40/30, function() guy[guyi]:fire() end)
                    guy[guyi].timer:after(32/30, function() guy[guyi]:resetAnimationIndex() end)
                    guy[guyi].physics.gravity = 0.8 - 1.6 * guyi
                    guy[guyi].physics.gravity_direction = math.rad(90)
                    guy[guyi].collider.collidable = true
                end
            end
			
            if self.row == 6 and self.spawn_timer == 5 then
                self.spawncount = 2
                local a = 0
                for i = 1, self.spawncount do
                    local guy = self:spawnBullet("sneo/lilguy", (445 + (a * 70)), (-20 + 400))
                    guy.physics.speed_y = -15
                    guy.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                    guy.timer:after(40/30, function() guy:fire() end)
                    guy.timer:after(32/30, function() guy:resetAnimationIndex() end)
                    guy.collider.collidable = true
                    guy.physics.gravity = 0.53
                    guy.physics.gravity_direction = math.rad(90)

                    local guy = self:spawnBullet("sneo/lilguy", (410 + (a * 70)), (-20 + 0))
                    guy.physics.speed_y = 15
                    guy.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                    guy.timer:after(40/30, function() guy:fire() end)
                    guy.timer:after(32/30, function() guy:resetAnimationIndex() end)
                    guy.collider.collidable = true
                    guy.physics.gravity = -0.53
                    guy.physics.gravity_direction = math.rad(90)
					
                    a = a + DTMULT
                end
            end
        end
		
        if self.type == 2 and self.spawn_timer >= 41 then
            self.spawn_timer = 0
        end
        if self.type == 3 and self.spawn_timer >= 69 then
            self.spawn_timer = 0
        end
        if self.type == 6 and self.spawn_timer >= 69 then
            self.spawn_timer = 0
        end
        if self.type == 4 and self.spawn_timer >= 50 then
            self.spawn_timer = 0
        end
        if self.type == 5 and self.spawn_timer >= 69 then
            self.spawn_timer = 0
        end
        if self.spawn_timer >= 50 then
            self.spawn_timer = 0
        end
        if self.spawn_timer == 0 then
            self.prevrow = self.row
        end
    end
end

function FlyingHeads:draw()
    super.draw(self)
	
    if self.debug_render == true then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.setFont(Assets.getFont("sans"))
		
        local dbg1 = string.format(
            [[type = %d
row = %d
rowy = %d
prevrow = %d
spawntimer = %d
            ]],
            self.type, 
            self.row, 
            self.rowy,
            self.prevrow,
            self.spawn_timer
        )

        love.graphics.printf("--FLYING HEADS DEBUG--", 10, 370, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
        love.graphics.printf(dbg1, 10, 390, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
    end
end

function FlyingHeads:onEnd()
    super.onEnd(self)
	
	self.sneo.sprite:setPartSine("head", 0)
    self.sneo:setAnimation("idle")
    self.sneo:setMode("normal")
	
    self.debug_render = false
end

return FlyingHeads