local badge, super = Class("badge", "refund")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Refund"

    self.type = "badge"

    -- Menu description
    self.description = "Refunds some D$ if you use an item in battle."

    -- The cost of putting it on
    self.badge_points = 1

    -- Default shop price (sell price is halved)
    self.price = 180
end

return badge