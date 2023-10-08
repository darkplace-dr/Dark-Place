---@class Item
local Item, super = Class("Item", true)

function Item:getTypeName()
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
end

return Item