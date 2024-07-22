local Card, super = Class(Object)

function Card:init()
	super:init(self)
	
	self.image = "cards/rodenteer"					-- For template use
	self.back = "cards/norm_back"
	
	self.value = 2									-- For template use
	self.cost = 2									-- For template use
	
	self.attack = true								-- For template use
	self.defense = false							-- For template use
	
	self.status = { }								-- For template use
	
	self.special = "none"							-- For template use
	
	self.flip_over = true
	
	self.webbed = false
	
	self.sprite = Sprite(self.back)
	self.sprite:setOrigin(0.5, 0.5)
	self.layer = CARD_LAYERS["cards"]
	
	self:addChild(self.sprite)
	
	self.selected = false
end

function Card:flip()
	if self.flip_over then
		self.flip_over = false
		self.sprite:setSprite(self.image)
	else
		self.flip_over = true
		self.sprite:setSprite(self.back)
	end
end

function Card:selectUnselect(silent)
	if self.selected == true then
		self.selected = false
		if self.select_outline then
			self.select_outline:remove()
		end
	else
		self.selected = true
		if not silent then
			self.select_outline = Sprite("cards/selection")
			self.select_outline:setOrigin(0.5,0.5)
			self.select_outline.layer = self.layer + 1
			self:addChild(self.select_outline)
		end
	end
end

function Card:webUnweb()
	if self.webbed == true then
		self.webbed = false
		if self.web_outline then
			self.web_outline:remove()
		end
	else
		self.webbed = true
		self.web_outline = Sprite("cards/web")
		self.web_outline:setOrigin(0.5,0.5)
		self.web_outline.layer = self.layer + 1
		self:addChild(self.web_outline)
	end
end

function Card:getReactionEquipped()
	return {}
end

function Card:getReactionUnequipped()
	return {}
end

return Card