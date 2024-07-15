local Forest, super = Class(Card, "fake")

function Forest:init()
	super:init(self)
	
	self.image = "cards/fake"
	self.back = "cards/fake"
	
	self.value = 0
	self.cost = 999999
	
	self.attack = false
	self.defense = false
	
	self.expire = 3
	
	self.sprite:setSprite(self.back)
end

return Forest