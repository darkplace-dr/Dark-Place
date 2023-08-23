local item, super = Class("bounceblade", true)

function item:init()
    super.init(self)

    self.reactions["ostarwalker"] = "Too         squishy"
end

return item