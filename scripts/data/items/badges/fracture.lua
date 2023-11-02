local badge, super = Class("badge", "fracture")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Fracture"

    self.type = "badge"

    -- Menu description
    self.description = "Your ATK grows as you take damage in battle."

    -- The cost of putting it on
    self.badge_points = 3

    -- Default shop price (sell price is halved)
    self.price = 180
end

return badge