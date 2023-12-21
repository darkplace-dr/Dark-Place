BadgesLib = {}
local lib = BadgesLib

function lib:init()
    self.total_bp = 3
end


Utils.hook(Item, 'getTypeName', function(orig, self, ...)
    if self.type == "item" then
        return "ITEM"
    elseif self.type == "key" then
        return "KEYITEM"
    elseif self.type == "weapon" then
        return "WEAPON"
    elseif self.type == "armor" then
        return "ARMOR"
    elseif self.type == "badge" then
        return "BADGE"
    end
    return "UNKNOWN"
end)

function lib:load(data, is_new_file, index)
    if data.total_bp then
        self.total_bp = data.total_bp
    end
end

function lib:save(data)
    data.total_bp = self.total_bp
end

function lib:createDarkInventory(inventory)
    inventory.storages["badges"] = {id = "badges", max = 48, sorted = true, name = "BADGEs", fallback = nil}
end

---@param ignore_light? boolean -- if you still want some stats etc. despite being in LW
function lib:getBadgeStorage(ignore_light)
    if Game:isLight() and not ignore_light then return {} end
    local inventory ---@type DarkInventory
    if not Game:isLight() then
        inventory = Game.inventory
    else
        inventory = Game.inventory:getItemByID("light/ball_of_junk").inventory
    end
    return inventory:getStorage("badges")
end

function lib:postUpdate()
    for _, badge in ipairs(self:getBadgeStorage()) do
        badge:update(badge.equipped)
    end
end

function lib:getUsedBadgePoints(ignore_light)
    local total_bp = 0
    for _, badge in ipairs(self:getBadgeStorage(ignore_light)) do
        if badge.equipped then
            total_bp = total_bp + badge:getBadgePoints()
        end
    end
    return total_bp
end

function lib:getBadgeEquipped(badge, ignore_light)
    local total_count = 0
    for _, b in ipairs(self:getBadgeStorage(ignore_light)) do
        if b.equipped and b.id == badge then
            total_count = total_count + 1
        end
    end
    return total_count
end

return lib