local item, super = Class("snowring", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "You did snowgrave lmao",
        brandon = "Uh, no thanks."
    })
end

return item