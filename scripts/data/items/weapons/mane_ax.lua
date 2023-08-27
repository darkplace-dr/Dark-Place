local item, super = Class("mane_ax", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "Too heavy",
        brandon = "I can't carry THAT.",
		jamm = "I mean, I'm not THAT strong..."
    })
end

return item