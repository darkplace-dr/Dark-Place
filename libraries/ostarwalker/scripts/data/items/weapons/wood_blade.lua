local item, super = Class("wood_blade", true)

function item:init()
    super:init(self)

    self.reactions["ostarwalker"] = "That's                   just a stick"

end

return item