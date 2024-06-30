local item, super = Class("wood_blade", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "I'm not a fucking nerd",
        brenda = "How do you even hurt someone with this?",
		jamm = "Ow! Splinter...",
        noel = "you can only get one of these..."
    })
end

return item