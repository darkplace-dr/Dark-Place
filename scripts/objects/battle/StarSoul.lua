local StarSoul, super = Class(Soul)

function StarSoul:init(x, y)
    super:init(self, x, y)
    self.color = {1,1,0}
	
	self.mode = "MOVE" -- MOVE, AIM
	
	self.star = nil
	
	self.aim_x = 0
	self.aim_y = 0
end

function StarSoul:update()
	super:update(self)
end

function StarSoul:draw()
	if self.mode == "AIM" then
		love.graphics.setLineWidth(2)
		if self.aim_x ~= 0 or self.aim_y ~= 0 then
			love.graphics.line(0, 0, 700 * self.aim_x, 700 * self.aim_y)
		end
	end
	super:draw(self)
end

function StarSoul:doMovement()
    if self.mode == "MOVE" then
		self.color = {1,1,0}
		local speed = self.speed

		-- Do speed calculations here if required.

		if self.allow_focus then
			if Input.down("cancel") then -- Focus mode.
				speed = speed / 2
			end
		end
		
		if Input.pressed("confirm") and not self.star then
			self.mode = "AIM"
			Assets.playSound("noise")
			return
		end

		local move_x, move_y = 0, 0

		-- Keyboard input:
		if Input.down("left")  then move_x = move_x - 1 end
		if Input.down("right") then move_x = move_x + 1 end
		if Input.down("up")    then move_y = move_y - 1 end
		if Input.down("down")  then move_y = move_y + 1 end

		self.moving_x = move_x
		self.moving_y = move_y

		if move_x ~= 0 or move_y ~= 0 then
			if not self:move(move_x, move_y, speed * DTMULT) then
				self.moving_x = 0
				self.moving_y = 0
			end
		end
	elseif self.mode == "AIM" then
		self.color = {1,0.5,0}
		if Input.pressed("cancel") then
			self.mode = "MOVE"
			Assets.playSound("ui_cancel_small")
			return
		end
		
		self.aim_x, self.aim_y = 0, 0
		
		if Input.down("left")  then self.aim_x = self.aim_x - 1 end
		if Input.down("right") then self.aim_x = self.aim_x + 1 end
		if Input.down("up")    then self.aim_y = self.aim_y - 1 end
		if Input.down("down")  then self.aim_y = self.aim_y + 1 end
		
		if Input.pressed("confirm") and (self.aim_x ~= 0 or self.aim_y ~= 0) then
			self.mode = "MOVE"
			Assets.playSound("noise")
			local angles = {
				225, 270, 315,
				180, nil, 0,
				135, 90,  45
			}
			self.star = StarSoulShot(self.x, self.y, math.rad(angles[5 + self.aim_x + (self.aim_y * 3)]))
			Game.battle:addChild(self.star)
		end
	end
end

return StarSoul