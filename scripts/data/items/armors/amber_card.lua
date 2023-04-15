local item, super = Class("amber_card", true)

function item:init()
    super.init(self)

    -- Character reactions
    self.reactions = Utils.merge(self.reactions, {
		dess = "Yummy glue",
        brandon = "It stained my clothes!"
    })
end

return item