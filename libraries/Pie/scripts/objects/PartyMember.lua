---
---@class PartyMember
---
---@field future_heals table   A table that stores data on currently active future heals.
---
---@overload fun(...) : PartyMember
local PartyMember, super = Class("PartyMember")

function PartyMember:init()
    super:init(self)

    self.future_heals = {}
end

--- Called whenever a HealItem is used. \
--- Calculates the amount of healing an item should apply based on the character's healing bonuses.
---@param amount integer The amount of base healing for the item.
---@param item any The HealItem that is being used.
function PartyMember:applyHealBonus(amount, item)
    -- Check to see whether this item allows heal bonuses, return original amount if it does not.
    if item.block_heal_bonus then
        return amount
    end
    
    -- Doesn't apply bonuses if the original heal amount is 0 or less, unless the config overrides this behaviour.
    if amount <= 0 and not Kristal.getLibConfig("pie", "alwaysApplyHealBonus", true) then
        return amount
    end
    
    local equipment = self:getEquipment()
    local final_amount = amount
    local multiplier = 1
    local bonus = 0

    -- Gathers all the heal bonuses from the character's equipment.
    for _,equipitem in ipairs(equipment) do
        if equipitem:includes(Item) then
            multiplier = multiplier * equipitem:getHealMultiplier(self, item)
            bonus = bonus + equipitem:getHealBonus(self, item)
        end
    end

    -- Applies the heal bonus, based on the order set in the config.
    if Kristal.getLibConfig("pie", "healMultiplierTakesPriority", true) then
        final_amount = (final_amount * multiplier) + bonus
    else
        final_amount = (final_amount + bonus) * multiplier
    end

    return math.floor(final_amount)
end

--- Registers a future heal for this party member.
---@param amount integer Amount of HP to restore.
---@param turns integer Amount of turns this heal happens in.
function PartyMember:addFutureHeal(amount, turns)
    table.insert(self.future_heals, {amount = amount, turns = turns})
end

--- Callback for when a future heal activates. \
--- If this function returns `true`, the future heal will be cancelled.
---@param amount integer The amount of HP restored by this heal.
---@param battler PartyBattler The PartyBattler associated with this character.
function PartyMember:onFutureHeal(amount, battler) end

return PartyMember