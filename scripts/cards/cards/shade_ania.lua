local Forest, super = Class(Card, "shade_ania")

function Forest:init()
	super:init(self)
	
	self.image = "cards/shade_ania"
	self.name = "Shade Ania"
	
	self.value = 4
	self.cost = 5
	
	self.defense = false
	self.attack = true
	
	self.status = { "web" }
end

return Forest