local item, super = Class("red_scarf", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "I hate Ralsei they are my least favorite character god I hate them",
        brandon = "It's soft!"
    })
end

return item