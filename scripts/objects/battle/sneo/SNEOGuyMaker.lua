local SNEOGuyMaker, super = Class(Object)

function SNEOGuyMaker:init(x, y)
    super.init(self, x, y)

    self.type = 2
	
    self.spawn_timer = 0
    self.prevrow = 0
    self.row = 0
    self.prevrow_y = 0

    self.spawncount = 0
    self.firstspawn = 0
	
    self.timer = Timer()
    self:addChild(self.timer)
end

function SNEOGuyMaker:update()
    super.update(self)

    self.shift_x = self.x
    self.shift_y = self.y

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
                if self.prevrow_y == 0 then
                    aa = Utils.pick{1, 2}
                end
                if self.prevrow_y == 1 then
                    aa = Utils.pick{0, 2}
                end
                if self.prevrow_y == 2 then
                    aa = Utils.pick{0, 1}
                end
                self.row_y = (self.shift_y + 210) - (46 * aa)
                self.prevrow_y = aa
                self.row = 2
            end

            if self.type == 3 or self.type == 4 then
                self.row_y = (self.shift_y + 210) - (40 * Utils.pick{0, 1})
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
                self.row_y = (self.shift_y + 210) - (40 * Utils.pick{0, 1, 2})
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
                local guy = self.wave:spawnBullet("sneo/lilguy", self.shift_x + 700, self.shift_y + 280)
                
                guy.physics.speed_x = -18
                guy.physics.friction = -0.1
                guy.physics.speed_y = -2
                self.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                self.timer:after(40/30, function() guy:fire() end)
                self.timer:after(32/30, function() guy:resetAnimationIndex() end)
                guy.physics.gravity = 0.5
                guy.physics.gravity_direction = 0
                guy.collider.collidable = true
                --guy.change_direction = false
                guy.alt_direction = 0
                guy.alt_speed = 4
                guy.alt_friction = -0.2

                if self.type == 2 then
                    self.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                end
                if self.row == 1 then
                    guy.y = guy.y - 240
                    guy.physics.speed_y = 2
                end
                if self.row == 2 then
                    guy.y = guy.y - 120
                    guy.physics.speed_y = 0
                    guy.physics.speed_x = -21
                    guy.alt_speed = -4
                end
                if self.row == 2 and self.type == 2 then
                    guy.physics.speed_x = -21
                    guy.physics.gravity = 0
                    guy.physics.friction = 0.5
                    self.timer:after(36/30, function() guy:switchToAlternatePhysics() end)
                    guy.alt_direction = guy.physics.direction
                end
                if (self.type == 2 or self.type == 3 or self.type == 3 or self.type == 4 or self.type == 5) and self.row == 2 then
                    guy.y = self.row_y
                end
            end

            -- this one is kinda broken lol.
            if self.row == 3 and self.spawn_timer ~= 20 then
                for guyi = 0, 1 do
                    local guy = self.wave:spawnBullet("sneo/lilguy", self.shift_x + 300, (self.shift_y - 40) + (400 * guyi))
                    guy.physics.speed_y = 18 - (36 * guyi)
                    self.timer:after(44/30, function() guy:switchToAlternatePhysics() end)
                    self.timer:after(30/30, function() guy:fire() end)
                    self.timer:after(32/30, function() guy:resetAnimationIndex() end)
                    guy.physics.gravity = 0.8 - (1.6 * guyi)
                    guy.collider.collidable = true
                end
            end

            if self.row == 6 and self.spawn_timer == 5 then
                self.spawncount = 2
				for a = 0, self.spawncount-1 do
                    local guy = self.wave:spawnBullet("sneo/lilguy", (self.shift_x + 410) + (a * 70), (self.shift_y - 20) + 0)
                    guy.physics.speed_y = 15
                    self.timer:after(30/30, function() guy:fire() end)
                    self.timer:after(22/30, function() guy:resetAnimationIndex() end)
                    guy.physics.direction = 0
                    guy.physics.gravity = -0.53
                    guy.collider.collidable = true

                    local guy = self.wave:spawnBullet("sneo/lilguy", (self.shift_x + 445) + (a * 70), (self.shift_y - 20) + 400)
                    guy.physics.speed_y = -15
                    self.timer:after(30/30, function() guy:fire() end)
                    self.timer:after(22/30, function() guy:resetAnimationIndex() end)
                    guy.physics.direction = 0
                    guy.physics.gravity = 0.53
                    guy.collider.collidable = true

                    a = a + a
				end
            end
			
			-- the unused variant that's on a set path, lol. Unfinished, so that's why it's commented out.
			
            --[[if self.row == 7 and self.spawn_timer ~= 20 then
                local guy_path = self.wave:spawnBullet("sneo/lilguy", self.shift_x + 630, self.shift_y + 100)
                guy_path.physics.speed_y = 15
                self.timer:after(44/30, function() guy_path:switchToAlternatePhysics() end)
                self.timer:after(40/30, function() guy_path:fire() end)
                self.timer:after(32/30, function() guy_path:resetAnimationIndex() end)
                guy_path.collider.collidable = true
            end]]
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

return SNEOGuyMaker