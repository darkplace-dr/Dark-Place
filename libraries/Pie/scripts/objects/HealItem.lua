--- Hello, I am a random code comment.
--- Hope you're having a great day today!

---@class HealItem
---
---@field future_heal_amount   number      The amount of health restored by this item after a given number of turns.
---@field future_heal_turns    number      The number of turns before the future heal arrives.
---@field block_heal_bonus     boolean     When `true`, this item's healing cannot be affected by heal bonuses.
---
---@overload fun(...) : HealItem
local HealItem, super = Class("HealItem")

function HealItem:init()
    super:init(self)

    self.future_heal_amount = 0
    self.future_heal_turns = 0

    self.block_heal_bonus = false
end

--- Gets the amount of future healing given by this item.
---@param chara PartyMember The PartyMember consuming this HealItem. 
---@return number
function HealItem:getFutureHealAmount(chara) return self.future_heal_amount end

--- Gets the number of turns before this item's future heal arrives.
---@param chara PartyMember The PartyMember consuming this HealItem.
---@return number
function HealItem:getFutureHealTurns(chara) return self.future_heal_turns end

function HealItem:onWorldUse(target)
    if self.target == "ally" then
        -- Heal single party member
        local amount = self:getWorldHealAmount(target.id)
        Game.world:heal(target, amount)
        return true
    elseif self.target == "party" then
        -- Heal all party members
        for _,party_member in ipairs(target) do
            local amount = self:getWorldHealAmount(party_member.id)
            Game.world:heal(party_member, amount)
        end
        return true
    else
        -- No target or enemy target (?), do nothing
        return false
    end
end

function HealItem:onBattleUse(user, target)
    if self.target == "ally" then
        -- Heal single party member
        local amount = self:getBattleHealAmount(target.chara.id)
        -- Healing will not occur if the item has 0 healing, unless the config overrides it.
        if amount > 0 or Kristal.getLibConfig("pie", "alwaysDoHealItemHealing", true) then
            target:heal(amount)
        end
        -- Apply future healing
        if self.future_heal_amount ~= 0 then
            local amount = self:getFutureHealAmount(target.chara)
            target.chara:addFutureHeal(amount, self:getFutureHealTurns(target.chara))
            self:onFutureHealStart(user, target, amount)
        end
    elseif self.target == "party" then
        -- Heal all party members
        for _,battler in ipairs(target) do
            local amount = self:getBattleHealAmount(battler.chara.id)
            if amount > 0 or Kristal.getLibConfig("pie", "alwaysDoHealItemHealing", true) then
                battler:heal(amount)
            end
            -- Apply future healing to everyone!
            if self.future_heal_amount ~= 0 then
                local amount = self.future_heal_amount
                battler.chara:addFutureHeal(amount, self.future_heal_turns)
                self:onFutureHealStart(user, battler, amount)
            end
        end
    elseif self.target == "enemy" then
        -- Heal single enemy (why)
        local amount = self:getBattleHealAmount(target.id)
        target:heal(amount)
    elseif self.target == "enemies" then
        -- Heal all enemies (why????)
        for _,enemy in ipairs(target) do
            local amount = self:getBattleHealAmount(enemy.id)
            enemy:heal(amount)
        end
    else
        -- No target, do nothing
    end
end

--- A callback that triggers whenever a future heal is started. \
--- A multi-target item will call this once per battler.
---@param user PartyBattler     The PartyBattler instance that used this item.
---@param target PartyBattler   The target of this HealItem.
---@param amount integer        The amount of health that will be restored by this HealItem.
function HealItem:onFutureHealStart(user, target, amount) 
    -- Small visual and audio cue for a future heal being set.
    Assets.stopAndPlaySound("spellcast")
    target:sparkle(1, 1, 0)
end

return HealItem