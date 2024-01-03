local badge, super = Class("badge", "tension_storage")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Keep Tension"

    self.type = "badge"

    -- Menu description
    self.description = "Keep your tension, to cast spells in the overworld."
    self.shop = "Keeps tension\nafter battle."
    -- The cost of putting it on
    self.badge_points = 1

    -- Default shop price (sell price is halved)
    self.price = 830
end

function badge:update(equipped)
    if equipped then
        Game:setFlag("tension_storage", true)
    end
    if not equipped then
        Game:setFlag("tension_storage", false)
    end
end

return badge