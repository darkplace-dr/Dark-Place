local item, super = Class("brokenswd", true)

function item:init()
    super.init(self)

    self.reactions["ostarwalker"] = "But it's     broken"

end

return item