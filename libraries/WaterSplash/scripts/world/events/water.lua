local water, super = Class(Event, "watertile")

function water:init(data)
    super:init(self, data.x + 22, data.y + 14, data.width - 40, data.height - 24, data.properties)

	self.color = Utils.parseColorProperty(data.properties["color"] or "#00000180")
	--self.depth = data.properties["depth"] or 5
	self.depth = 5 -- this shit is broken rn
	--[[
	self.watersprite = Sprite("misc/watercirc", 0, 26)
	self.watersprite.color = self.color
	self.watersprite.alpha = 1
	]]

end

function water:onEnter(chara)
	if chara.watersplash_onwater ~= true then
		local scissor = ScissorFX(0, 0, 1000, 50)

		--chara:addChild(self.watersprite)
		if not chara.watersprite then
			chara.watersprite = Sprite("misc/watercirc", 0, 21 + self.depth)
			chara.watersprite.color = self.color
			chara.watersprite.alpha = 1
			chara:addChild(chara.watersprite)
		end

		chara:addFX(scissor, "waterscissor")
		chara.sprite.y = chara.sprite.y + self.depth
		scissor.height = scissor.height + self.depth * 2
		Assets.playSound("noise")
		chara.watersplash_onwater = true
	end
end

function water:onExit(chara)
	Game.world.timer:after(0.05, function()
		local colliding = {}
		for _, wevent in pairs(Game.world.map:getEvents("watertile")) do
			table.insert(colliding, wevent:collidesWith(chara))
			print(wevent:collidesWith(chara))
			
		end

		if Utils.containsValue(colliding, true) == false then
			--chara:removeChild(self.watersprite)
			if chara.watersprite then
				chara:removeChild(chara.watersprite)
				chara.watersprite = nil
			end
			chara:removeFX("waterscissor")
			chara.sprite.y = chara.sprite.y - self.depth
			chara.watersplash_onwater = false
		end

	end)
end

function water:getDebugInfo()
	local info = super:getDebugInfo(self)
	table.insert(info, "Depth: "    .. (self.depth or 5))
	return info
end

return water