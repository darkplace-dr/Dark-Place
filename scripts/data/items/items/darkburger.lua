local item, super = Class("darkburger", true)

function item:init()
    super.init(self)

    self.world_heal_amounts = Utils.merge(self.world_heal_amounts, {
		["dess"] = 20
    })

    self.reactions = Utils.merge(self.reactions, {
		dess = "Sorry man I only eat lettuce",
        brandon = "I love burgers!"
    })
end

return item