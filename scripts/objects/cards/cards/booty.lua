local Forest, super = Class(Card, "booty")

function Forest:init()
	super:init(self)
	
	self.image = "cards/booty"
	self.name = "Booty"
	
	self.value = 5
	self.cost = 6
	
	self.attack = true
	self.defense = true
	
	self.status = { }
end

return Forest