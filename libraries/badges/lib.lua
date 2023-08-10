BadgesLib = {}
local lib = BadgesLib

function lib:init()
    self.total_bp = 3
end

function lib:load(data, is_new_file, index)
    if data.total_bp then
        self.total_bp = data.total_bp
    end
end

function lib:save(data)
    data.total_bp = self.total_bp
end

function lib:preUpdate()
end

function lib:postUpdate()
    for _, badge in ipairs(Game.inventory:getStorage("badges")) do
        badge:update(badge.equipped)
    end
end

function lib:createDarkInventory(inventory)
    inventory.storages["badges"] = {id = "badges", max = 48, sorted = true, name = "BADGEs", fallback = nil}
end

function lib:getUsedBadgePoints()
    local total_bp = 0
    for _, badge in ipairs(Game.inventory:getStorage("badges")) do
        if badge.equipped then
            total_bp = total_bp + badge:getBadgePoints()
        end
    end
    return total_bp
end

function lib:getBadgeEquipped(badge)
    local total_count = 0
    for _, b in ipairs(Game.inventory:getStorage("badges")) do
        if b.equipped and b.id == badge then
            total_count = total_count + 1
        end
    end
    return total_count
end

return lib