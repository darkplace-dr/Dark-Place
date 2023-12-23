local XO, super = Class(Event, "xo")

function XO:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
	
	local properties = data.properties or {}
	
	self:setHitbox(0, 0, data.width, data.height)
	
	self.flag = properties["flag"]
	
	self.solved = Game:getFlag(self.flag)
	
	self:setSprite(self.solved and "world/events/xo/win" or "world/events/xo/x")
	self.state = self.solved and 3 or 0
end

function XO:onEnter(chara)
    if chara == Game.world.player then
        if self.state == 0 then
			self.state = 1
			self:setSprite("world/events/xo/o")
		elseif self.state == 1 then
			self.state = 2
			self:setSprite("world/events/xo/fail")
		end
    end
end

return XO