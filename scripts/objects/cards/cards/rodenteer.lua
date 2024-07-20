local Forest, super = Class(Card, "rodenteer")

function Forest:init()
	super:init(self)
	
	self.image = "cards/rodenteer"
	self.name = "Rodenteer"
	
	self.value = 2
	self.cost = 2
	
	self.attack = true
	self.defense = false
	
	self.status = { }
end

return Forest