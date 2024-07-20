local Forest, super = Class(Card, "poseur")

function Forest:init()
	super:init(self)
	
	self.image = "cards/poseur"
	self.name = "Poseur"
	
	self.value = 1
	self.cost = 1
	
	self.attack = true
	self.defense = false
	
	self.status = { }
end

return Forest