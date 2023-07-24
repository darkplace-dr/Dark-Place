---@class Badge : Item
---@overload fun(...) : Badge
local Badge, super = Class(Item)

function Badge:init()
    super.init(self)

    self.badge_points = 1

    self.equipped = false

    self.target = "none"
    self.usable_in = "world"
end

function Badge:isEquipped()
    return self.equipped
end

function Badge:setEquipped(equipped)
    if self.equipped and not equipped then
        self:onBadgeRemoved()
    end
    if not self.equipped and equipped then
        self:onBadgeEquipped()
    end
    self.equipped = equipped
end

function Badge:onBadgeEquipped()
end

function Badge:onBadgeRemoved()
end

function Badge:update()
end

function Badge:getBadgePoints()
    return self.badge_points
end

function Badge:onSave(data)
    data.equipped = self.equipped
end

function Badge:onLoad(data)
    self.equipped = data.equipped
end

return Badge