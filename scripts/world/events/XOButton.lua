local XOButton, super = Class(TileButton, "xobutton")

function XOButton:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data.properties)
end

function XOButton:onPressed()
    self:setSprite(self.pressed_sprite)
    if self.on_sound and self.on_sound ~= "" then
        Assets.stopAndPlaySound(self.on_sound)
    end
	local solved = true
	if not Game:getFlag(self.world.map:getEvents("xo")[1].flag) then
		for k,v in ipairs(self.world.map:getEvents("xo")) do
			if v.state ~= 1 then
				solved = false
			end
		end
	end
	
	if solved then
		for k,v in ipairs(self.world.map:getEvents("xo")) do
			v.state = 3
			v:setSprite("world/events/xo/win")
		end
		Game:setFlag(self.world.map:getEvents("xo")[1].flag, true)
	else
		for k,v in ipairs(self.world.map:getEvents("xo")) do
			v.state = 0
			v:setSprite("world/events/xo/x")
		end
	end
end

return XOButton