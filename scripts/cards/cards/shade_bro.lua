local Forest, super = Class(Card, "shade_bro")

function Forest:init()
	super:init(self)
	
	self.image = "cards/shade_bro"
	self.name = "Shade Bro"
	
	self.value = 3
	self.cost = 3
	
	self.defense = false
	self.attack = true
	
	self.status = { }
end

return Forest