local item, super = Class("wood_blade", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "I'm not a fucking nerd",
        brandon = "How do you even hurt someone with this?"
    })
end

return item