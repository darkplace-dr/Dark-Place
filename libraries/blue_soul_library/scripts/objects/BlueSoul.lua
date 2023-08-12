local BlueSoul, super = Class(Soul)

function BlueSoul:init(x, y, angle)
    super.init(self, x, y)

	-- Do not modify these variables
    self.color = {0,0,1}
    self.jumped = false
    self.ground_pounded = false
    self.gravity = 0
    self.jumps_left = 0
	
	-- Variables that can be changed
    self.can_jump = true 		-- Can the blue soul jump? [boolean] (true; false) | default: true
    self.can_doublejump = true -- Can the blue soul double jump? [boolean] (true; false) | default: false
    self.can_groundpound = true-- Can the blue soul ground pound? W.I.P. [boolean] (true; false) | default: true
    self.jump_height = 3 		-- How high can the blue soul jump? [real] (any number) | default: 5
    self.jump_count = 2 		-- How much can the blue soul double jump? [real] (any number) | default: 2
    self.direction = "down" 	-- What directiion is the soul facing and falling? [string] ("down"; "left"; "up"; "right") | default: "down"
end

function BlueSoul:update()
    super.update(self)
	if self.direction == "down" then self.rotation = math.rad(0) end
	if self.direction == "up" then self.rotation = math.rad(180) end
	if self.direction == "left" then self.rotation = math.rad(90) end
	if self.direction == "right" then self.rotation = math.rad(270) end
end

function BlueSoul:doMovement()
    local speed = self.speed

    if Input.down("cancel") then speed = speed / 2 end -- Focus mode.

    local move_x, move_y = 0, 0
	
	if self.direction == "down" then
		-- Keyboard input:
		if Input.down("left")  then move_x = move_x - 1 end
		if Input.down("right") then move_x = move_x + 1 end
		if Input.pressed("up") then 
			self:jumpStart()
		end
		if Input.released("up") then 
			self:jumpEnd()
		end

		if Input.pressed("down") then
			self:doGroundPound()
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
	elseif self.direction == "up" then
		-- Keyboard input:
		if Input.down("left")  then move_x = move_x - 1 end
		if Input.down("right") then move_x = move_x + 1 end
		if Input.pressed("down") then 
			self:jumpStart()
		end
		if Input.released("down") then 
			self:jumpEnd()
		end

		if Input.pressed("up") then
			self:doGroundPound()
		end

		if self.ground_pounded then 
			self.gravity = self.gravity + 5*DTMULT
		end
		
		move_y = self.gravity
		
		if self.last_collided_y == -1 and self.gravity >= 0 then
			self:jumpReset()
		else
			self.jumped = true
		end
	elseif self.direction == "left" then
		-- Keyboard input:
		if Input.down("up")  then move_y = move_y - 1*DTMULT end
		if Input.down("down") then move_y = move_y + 1*DTMULT end
		if Input.pressed("right") then 
			self:jumpStart()
		end
		if Input.released("right") then 
			self:jumpEnd()
		end

		if Input.pressed("left") then
			self:doGroundPound()
		end

		if self.ground_pounded then 
			self.gravity = self.gravity + 5*DTMULT
		end
		
		move_x = self.gravity
		
		if self.last_collided_x == -1 and self.gravity >= 0 then
			self:jumpReset()
		else
			self.jumped = true
		end
	elseif self.direction == "right" then
		-- Keyboard input:
		if Input.down("up")  then move_y = move_y - 1 end
		if Input.down("down") then move_y = move_y + 1 end
		if Input.pressed("left") then 
			self:jumpStart()
		end
		if Input.released("left") then 
			self:jumpEnd()
		end

		if Input.pressed("right") then
			self:doGroundPound()
		end

		if self.ground_pounded then 
			self.gravity = self.gravity + 5*DTMULT
		end
		
		move_x = self.gravity
		
		if self.last_collided_x == 1 and self.gravity >= 0 then
			self:jumpReset()
		else
			self.jumped = true
		end
	end
	
	self:doGravity()
	
	if self.direction == "down" then
		if move_x ~= 0 or move_y ~= 0 then
			self:move(move_x * speed, move_y, DTMULT)
		end
	elseif self.direction == "up" then
		if move_x ~= 0 or move_y ~= 0 then
			self:move(move_x * speed, -move_y, DTMULT)
		end
	elseif self.direction == "left" then
		if move_x ~= 0 or move_y ~= 0 then
			self:move(-move_x, move_y * speed, DTMULT)
		end
	elseif self.direction == "right" then
		if move_x ~= 0 or move_y ~= 0 then
			self:move(move_x, move_y * speed, DTMULT)
		end
	end

    self.moving_x = move_x
    self.moving_y = move_y
end

function BlueSoul:draw()
    local r,g,b,a = self:getDrawColor()
    local heart_texture = Assets.getTexture(self.sprite.texture_path)
    local heart_w, heart_h = heart_texture:getDimensions()

    super.draw(self)
    self.color = {r,g,b}
end

function BlueSoul:jumpStart()
	if self.can_jump then
		if self.can_doublejump then
			if self.jumps_left > 0 then
				self.gravity = -self.jump_height
				self.jumps_left = self.jumps_left - 1*DTMULT
			end
		else
			if not self.jumped then
				self.gravity = -self.jump_height
			end
		end
	end
end

function BlueSoul:jumpEnd()
	if self.gravity < 0 then
		self.gravity = 0
	end
end

function BlueSoul:jumpReset()
	self.jumps_left = self.jump_count
	self.jumped = false
	self.ground_pounded = false
	self.gravity = 0
end

function BlueSoul:doGroundPound()
	if self.can_groundpound then
		if not self.ground_pounded and self.jumped then
			Assets.playSound("groundpound")
			self.ground_pounded = true
		end
	end
end

function BlueSoul:doGravity()
	if self.gravity >= -25 and self.gravity < -6 then self.gravity = self.gravity + 0.25*DTMULT end
	if self.gravity >= -6 and self.gravity < -0.8 then self.gravity = self.gravity + 0.20*DTMULT end
	if self.gravity >= -0.8 and self.gravity < 0.8 then self.gravity = self.gravity + 0.15*DTMULT end
	if self.gravity >= 0.8 and self.gravity < 2.5 then self.gravity = self.gravity + 0.20*DTMULT end
	if self.gravity >= 2.5 and self.gravity < 6 then self.gravity = self.gravity + 0.25*DTMULT end
	if self.gravity >= 6 and self.gravity < 13 then self.gravity = self.gravity + 0.30*DTMULT end
end

return BlueSoul