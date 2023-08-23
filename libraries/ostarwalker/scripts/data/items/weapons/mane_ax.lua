local item, super = Class("mane_ax", true)

function item:init()
    super.init(self)

    self.reactions["ostarwalker"] = "Too                sharp"

end

return item