local HomingSoul, super = Class(Soul)

function HomingSoul:init(x, y)
    super:init(self, x, y)
    -- Do not modify these variables
	self.color = {0, 0, 1}
    self.jumped = false
    self.ground_pounded = false
    self.gravity = 0
    self.jumps_left = 0
	self.blue = true -- Checking this to disable the reduced hitbox for it
	self.mode = "MOVE" -- MOVE, HOMING
	
	self.dash_time = 0.05
	if Game.battle.encounter.light_speed then
		Game.battle.encounter.light_speed = false
		self.dash_time = 0
	end
	
	self.start_gravity = -5
	if Game.battle.encounter.high_jump then
		Game.battle.encounter.high_jump = false
		self.start_gravity = -6.5
	end
	
	self.homing_collider = CircleCollider(self, 0, 0, 50)
end

function HomingSoul:update()
	super:update(self)
	
	if self.mode == "MOVE" then
		local connected = {}
		
		for _,bullet in ipairs(Game.stage:getObjects(HomingBullet)) do
			if self.homing_collider:collidesWith(bullet) and bullet:canHome() then
				table.insert(connected, bullet)
			end
		end
		
		if #connected > 0 then
			local bulletselect = nil
			local distance = math.huge
			
			for _,bullet in ipairs(connected) do
				if Utils.dist(self.x,self.y,bullet.x,bullet.y) < distance then
					distance = Utils.dist(self.x,self.y,bullet.x,bullet.y)
					bulletselect = bullet
				end
			end
			
			self.selected = bulletselect
			
			if self.selected then
				for _,bullet in ipairs(Game.stage:getObjects(HomingBullet)) do
					if self.selected == bullet then
						bullet.color = {1,1,0,1}
					else
						bullet:deselect()
					end
				end
			end
		else
			self.selected = nil
			
			for _,bullet in ipairs(Game.stage:getObjects(HomingBullet)) do
				bullet:deselect()
			end
		end
	end
end

function HomingSoul:draw()
	super:draw(self)
	if DEBUG_RENDER then
		self.collider:draw(0,1,0,1)
		self.homing_collider:draw(0,0,1,1)
	end
end

function HomingSoul:onCollide(bullet)
    -- Handles damage
	if self.mode == "MOVE" then
		bullet:onCollide(self)
	end
end

function HomingSoul:doMovement()
    if self.mode == "MOVE" then
		local speed = self.speed

		if Input.down("cancel") then speed = speed / 2 end -- Focus mode.

		local move_x, move_y = 0, 0

		-- Keyboard input:
		if Input.down("left")  then move_x = move_x - 1 end
		if Input.down("right") then move_x = move_x + 1 end
		if Input.pressed("up") then 
			self:jumpStart()
		end
		if Input.released("up") then 
			self:jumpEnd()
		end
		
		if Input.pressed("confirm") and self.selected and self.jumped then
			self.mode = "HOMING"
			Assets.playSound("whoosh", 1, 1)
			Game.battle.timer:tween(self.dash_time, self, {x = self.selected.x, y = self.selected.y}, "linear", function()
				if self.collider:collidesWith(self.selected) then
					self.selected:onHome()
					self.selected = nil
					self.gravity = -1
				end
				self.mode = "MOVE"
			end)
		end

		if self.ground_pounded then 
			self.gravity = self.gravity + 5*DTMULT
		end
		
		move_y = self.gravity
		
		if self.last_collided_y == 1 and self.gravity >= 0 then
			self:jumpReset()
		else
			self.jumped = true
		end
		if self.last_collided_y == -1 and self.gravity < 0 then
			self.gravity = 0
		end
		
		self:doGravity()
		
		if move_x ~= 0 or move_y ~= 0 then
			self:move(move_x * speed, move_y, DTMULT)
		end
		
		self.moving_x = move_x
		self.moving_y = move_y
	end
end

function HomingSoul:jumpStart()
	if not self.jumped then
		self.gravity = self.start_gravity
		self.jumped = true
	end
end

function HomingSoul:jumpEnd()
	if self.gravity < 0 then
		self.gravity = 0
	end
end

function HomingSoul:jumpReset()
	self.jumps_left = self.jump_count
	self.jumped = false
	self.gravity = 0
end

function HomingSoul:doGravity()
	if self.gravity >= -25 and self.gravity < -6 then self.gravity = self.gravity + 0.25*DTMULT end
	if self.gravity >= -6 and self.gravity < -0.8 then self.gravity = self.gravity + 0.20*DTMULT end
	if self.gravity >= -0.8 and self.gravity < 0.8 then self.gravity = self.gravity + 0.15*DTMULT*2 end
	if self.gravity >= 0.8 and self.gravity < 2.5 then self.gravity = self.gravity + 0.20*DTMULT*2 end
	if self.gravity >= 2.5 and self.gravity < 6 then self.gravity = self.gravity + 0.25*DTMULT*2 end
	if self.gravity >= 6 and self.gravity < 13 then self.gravity = self.gravity + 0.30*DTMULT*2 end
end

return HomingSoul