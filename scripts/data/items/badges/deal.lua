local badge, super = Class("badge", "deal")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "50% Off Deal"

    self.type = "badge"

    -- Menu description
    self.description = "Enemies deal 50% less damage to you,\nhowever you deal 50% less damage as well."

    -- The cost of putting it on
    self.badge_points = 2

    -- Default shop price (sell price is halved)
    self.price = 180
end

return badge