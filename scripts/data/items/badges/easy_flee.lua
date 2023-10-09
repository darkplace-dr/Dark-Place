local badge, super = Class("badge", "easy_flee")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Easy Flee"

    self.type = "badge"

    -- Menu description
    self.description = "Allows you an easier escape from most battles."

    -- The cost of putting it on
    self.badge_points = 3

    -- Default shop price (sell price is halved)
    self.price = 180
end

return badge