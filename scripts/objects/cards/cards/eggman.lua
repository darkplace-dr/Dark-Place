local Forest, super = Class(Card, "eggman")

function Forest:init()
	super:init(self)
	
	self.image = "cards/eggman"
	self.name = "Eggman"
	
	self.value = 5
	self.cost = 5
	
	self.attack = true
	self.defense = false
	
	self.status = { }
end

return Forest