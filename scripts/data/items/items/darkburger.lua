local item, super = Class("darkburger", true)

function item:init()
    super.init(self)

    self.world_heal_amounts = Utils.merge(self.world_heal_amounts, {
        ["dess"] = 20,
		["jamm"] = 60
    })

    self.reactions = Utils.merge(self.reactions, {
        dess = "Sorry man I only eat lettuce",
        brandon = "I love burgers!",
		jamm = "I get these for free at Mcbangbang's."
    })
end

return item