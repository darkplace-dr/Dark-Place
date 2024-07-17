local Forest, super = Class(Card, "owlen")

function Forest:init()
	super:init(self)
	
	self.image = "cards/owlen"
	self.name = "Owlen"
	
	self.value = 6
	self.cost = 6
	
	self.attack = true
	self.defense = false
	
	self.status = { }
	
	self.sprite:setSprite(self.back)
end

return Forest