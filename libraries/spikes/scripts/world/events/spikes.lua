local Spikes, super = Class(Event, "spikes")

function Spikes:init(data)
    super.init(self, data.x, data.y, data.properties)
	
	self.sprite_up = data.properties["sprite"] or "world/events/spikes_up"
	self.sprite_down = data.properties["spritedown"] or "world/events/spikes_down"
	
	self.flag = data.properties["flag"]
	self.default = data.properties["default"]
	if self.default == nil then
		self.default = true
	end
	if data.properties["spikedeath"] == nil then
		self.spikedeath = Kristal.getLibConfig("spikes", "spikedeath")
	else
		self.spikedeath = data.properties["spikedeath"]
	end
	
	self.solid = false
	self:setSprite(self.sprite_down)
end

function Spikes:update()
	if self.flag then
		if Game:getFlag(self.flag, false) == true or Game:getFlag(self.flag, false) == false then
			if self.default then
				if Game:getFlag(self.flag, false) == false then
					self:setSprite(self.sprite_up)
				else
					self:setSprite(self.sprite_down)
				end
				self.solid = not Game:getFlag(self.flag, false)
			else
				if Game:getFlag(self.flag, false) == true then
					self:setSprite(self.sprite_up)
				else
					self:setSprite(self.sprite_down)
				end
				self.solid = Game:getFlag(self.flag, false)
			end
		end
	elseif self.default == true then
		self:setSprite(self.sprite_up)
		self.solid = true
	else
		self:setSprite(self.sprite_down)
		self.solid = false
	end
	if self.solid and self:collidesWith(self.world.player) and self.spikedeath then
		Game.stage.timer:after(0.1, function()
			Game:gameOver(self.world.player.x, self.world.player.y)
		end)
	end
	super.update(self)
end

function Spikes:getDebugInfo()
	local info = super.getDebugInfo(self)
	if self.flag then
		table.insert(info, "Flag: "    .. self.flag)
	end
	table.insert(info, "Death On Skewer: "    .. (self.spikedeath and "True" or "False"))
	return info
end

return Spikes