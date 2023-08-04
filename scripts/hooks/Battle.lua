---@class Battle
local Battle, super = Class("Battle", true)

function Battle:init()
	super.init(self)
	
	self.super_timer = 0
	
	self.superpower = false
end

function Battle:update()
	super.update(self)
	
	if self.superpower then
		if (self.super_timer - (DT * 30))%10 > self.super_timer%10 then
			Game:removeTension(1)
			
			if Game.tension <= 0 then
				self.superpower = false
			end
		end
	
		self.super_timer = self.super_timer + DT * 30
	end
end

return Battle