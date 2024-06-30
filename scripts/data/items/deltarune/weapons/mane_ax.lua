local item, super = Class("mane_ax", true)

function item:init()
    super.init(self)

    self.reactions = Utils.merge(self.reactions, {
		dess = "Too heavy",
        brenda = "I can't carry THAT.",
		jamm = "I mean, I'm not THAT strong...",
        noel = "I'm gonna pull a [Rude Buster].",
    })
end

return item