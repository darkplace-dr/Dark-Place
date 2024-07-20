local Forest, super = Class(Card, "counter")

function Forest:init()
	super:init(self)
	
	self.image = "cards/counter"
	self.name = "Counter"
	
	self.value = 0
	self.cost = 2
	
	self.attack = false
	self.defense = true
	
	self.special = "counter"
end

return Forest