local Forest, super = Class(Card, "rodenteer_ex")

function Forest:init()
	super:init(self)
	
	self.image = "cards/rodenteer_ex"
	-- self.back = "cards/ex_back"
	
	self.value = 3
	self.cost = 3
	
	self.attack = true
	self.defense = false
	
	self.status = { }
	
	self.sprite:setSprite(self.back)
end

return Forest