local item, super = Class("red_scarf", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "I hate Ralsei they are my least favorite character god I hate them",
		noel = "blood?... no, that's the other one.",
        brenda = "It's soft!",
		jamm = "Too soft!"
    })
end

return item