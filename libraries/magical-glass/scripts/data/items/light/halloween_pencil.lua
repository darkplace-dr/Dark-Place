local item, super = Class("light/halloween_pencil", true)

function item:init()
    super.init(self)

    -- Display name
    self.show_name = "HallowPencil"

    self.price = 50
end

return item