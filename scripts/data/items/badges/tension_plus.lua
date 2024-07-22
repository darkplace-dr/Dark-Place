local badge, super = Class("badge", "tension_plus")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Tension Plus"

    self.type = "badge"

    -- Menu description
    self.description = "Increases maximum tension points stored."

    -- The cost of putting it on
    self.badge_points = 3

    -- Default shop price (sell price is halved)
    self.price = 180
end

local function updateMaxTensionDeferred()
    Game.world.timer:after(0.1, function()
        Mod:updateMaxTension()
    end)
end

function badge:onBadgeEquipped()
    updateMaxTensionDeferred()
end

function badge:onBadgeRemoved()
    updateMaxTensionDeferred()
end

return badge