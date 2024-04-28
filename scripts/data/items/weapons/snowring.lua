local item, super = Class("snowring", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "You did snowgrave lmao",
        brenda = "Uh, no thanks.",
		jamm = "It feels cold..."
    })
end

return item