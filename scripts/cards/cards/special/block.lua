local Forest, super = Class(Card, "block")

function Forest:init()
	super:init(self)
	
	self.image = "cards/block"
	self.back = "cards/special_back"
	
	self.value = 0
	self.cost = 6
	
	self.attack = true
	self.defense = true
	
	self.special = "block"
	
	self.sprite:setSprite(self.back)
end

return Forest