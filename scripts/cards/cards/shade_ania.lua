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

function Forest:getReactionEquipped()
	if Game:getFlag("jamm_party") then
		if not Game:getFlag("dungeonkiller") then
			return {
				jamm = "How did they know...",
				brenda = "(Is Jamm okay?)"
			}
		else
			return {
				jamm = "...",
				brenda = "(Is Jamm okay?)"
			}
		end
	end
	return {}
end

function Forest:getReactionUnequipped()
	if Game:getFlag("jamm_party") then
		return {
			jamm = "..."
		}
	end
	return {}
end

return Forest