local Forest, super = Class(Card, "dummy")

function Forest:init()
	super:init(self)
	
	self.image = "cards/dummy"
	self.name = "Dummy"
	
	self.value = 1
	self.cost = 1
	
	self.attack = false
	self.defense = true
	
	self.status = { }
end

return Forest