local Card, super = Class(Card, "pot_of_greed")

function Card:init()
        self.back = "cards/yugioh_back"

	super:init(self)

	self.image = "cards/pot_of_greed"

	self.name = "POT OF GREED"
	
	self.value = 0
	self.cost = 0
	
	self.attack = true
	self.defense = true

	self.special = "card_draw"

	self.card_draw = 3
	
	self.status = { }
end

return Card