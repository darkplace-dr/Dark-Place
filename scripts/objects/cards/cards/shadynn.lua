local Forest, super = Class(Card, "shadynn")

function Forest:init()
	super:init(self)
	
	self.image = "cards/shadynn"
	self.name = "Shadynn"
	
	self.value = 3
	self.cost = 3
	
	self.attack = false
	self.defense = true
	
	self.status = { }
end

return Forest