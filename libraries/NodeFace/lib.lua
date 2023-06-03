_G.NodeFace = function(lookup)
	local currentName
	
	local function canAnimate(self, name)
		return (currentName == name and self:isTyping())
	end
	
	local nodeface = function(self, name)
		local npc = lookup[name]
		
		if npc then
			npc:setAnimation('talk')
		end
		
		local texture = Assets.getFramesOrTexture("nodeface/" .. name .. "/talk")

		local y = self.state.current_y + (self:getFont():getHeight() / 2)
		local sprite = Sprite(texture, self.state.current_x - 12, y)
		sprite:setOrigin(0, 0.5)
        sprite.layer = self.layer + 1
		sprite:setAnimation(function(sprite, wait)
			while (true) do
				sprite:setFrame((sprite.frame == 2 and 1) or 2)
				
				if sprite.frame == 1 and not canAnimate(self, name) then
					if npc then
						npc:setAnimation('idle')
					end
					
					sprite:setFrame(1)
					break
				else
					wait(0.15)
				end
			end
		end)
		
		self:addChild(sprite)
		table.insert(self.sprites, sprite)

		self.state.current_x = (self.state.current_x + (sprite.width) + self.state.spacing) - 8

		currentName = name
	end
	
	return nodeface, {
		functions = {
			nodeface = nodeface,
		}
	}
end