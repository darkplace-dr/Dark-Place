local badge, super = Class("badge", "phasebadge")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Phase Badge"

    self.type = "badge"

    -- Menu description
    self.description = "Take no damage for the first hit of the battle."

    -- The cost of putting it on
    self.badge_points = 3

    -- Default shop price (sell price is halved)
    self.price = 10000
end

return badge