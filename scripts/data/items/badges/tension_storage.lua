local badge, super = Class("badge", "tension_storage")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Tension-Storage"

    self.type = "badge"

    -- Menu description
    self.description = "Keep your tension,\nto cast spells in the overworld."

    -- The cost of putting it on
    self.badge_points = 1

    -- Default shop price (sell price is halved)
    self.price = 20000
end



return badge