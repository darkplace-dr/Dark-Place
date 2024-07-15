local Forest, super = Class(Card, "froglin")

function Forest:init()
	super:init(self)
	
	self.image = "cards/froglin"
	-- self.back = "cards/norm_back"				-- Technically not required since it's this by default anyways
	
	self.value = 1
	self.cost = 1
	
	self.attack = false
	self.defense = true
	
	self.status = { }
end

return Forest