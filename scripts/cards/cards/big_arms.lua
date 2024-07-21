local Forest, super = Class(Card, "big_arms")

function Forest:init()
	super:init(self)
	
	self.image = "cards/big_arms"
	self.name = "Big Arms"
	
	self.value = 5
	self.cost = 5
	
	self.attack = false
	self.defense = true
	
	self.status = { }
end

return Forest