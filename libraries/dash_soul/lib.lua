local Lib = {}
function Lib:Dashinit()
	Utils.hook(Soul, "doMovement", function(orig, self)
		local speed = self.speed
		local color = self.color
		local dash_speed = self.dash_speed
		local move_x, move_y = self.move_x, self.move_y
		local isleft = Input.down("left")
		local isright = Input.down("right")
		local isup = Input.down("up")
		local isdown = Input.down("down")
		local isdash = Input.down("confirm")
		-- Do speed calculations here if required.
		if self.allow_focus then
			if Input.down("cancel") then speed = speed / 2; dash_speed = dash_speed / 2 end -- Focus mode.
		end
		if self.dash_timer > 0 then color = {1-(self.dash_timer*self._dash_divider), self.dash_timer*self._dash_divider, self.dash_timer*self._dash_divider} end -- make the soul color approach red as the ability to dash comes closer in time
	
		if isdash and self.dash_timer <= 0 then
			if isleft then move_x = -dash_speed end
			if isright then move_x = dash_speed end
			if isup  then move_y = -dash_speed end
			if isdown  then move_y = dash_speed end
			self.dash_timer = self.dash_duration
		end
		orig(self)
	end)
	Utils.hook(Soul, "doMovement", function(orig, self)
		if self.dash_timer > 0 then
			self.dash_timer = self.dash_timer - DT
		end
		orig(self)
	end)
end
-- Turns out, we do all the processing here. How useful is that?
function Lib:init()
	print("Dashing functionality loaded. Made by REFUNDINSTRUCTION Corp.")
	Lib:Dashinit()
end

return Lib