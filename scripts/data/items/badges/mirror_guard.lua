local badge, super = Class("badge", "mirror_guard")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Mirror Guard"

    self.type = "badge"

    -- Menu description
    self.description = "Blocks the first hit you take in battle.\nSome attacks can't be blocked, however."

    -- The cost of putting it on
    self.badge_points = 2

    -- Default shop price (sell price is halved)
    self.price = 180
end

return badge