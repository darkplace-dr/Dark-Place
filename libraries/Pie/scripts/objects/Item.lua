---
---@class Item
---
---@field heal_bonus                   number      Bonus healing added when consuming a HealItem.
---@field heal_mult                    number|nil  Healing multiplier when consuming a HealItem.
---@field heal_bonuses                 table       Bonus healing added for specific HealItems.       
---@field heal_mults                   table       Healing multiplier for specific HealItems.
---
---@field victory_heal                 number      Amount of health restored when winning a battle.
---@field starting_tension             number      Amount of tension given at the start of battle.
---
--- Amount of health restored by passive healing. \
--- Defaults to `nil`, where no passive healing will occur.
---@field passive_heal_amount          number|nil
---@field passive_heal_cost            number      Amount of tension required for passive healing. Defaults to `0`.
---@field passive_heal_frequency       number      Number of turns between each passive heal. Defaults to `1`.
---
--- Amount of damage dealt to the player by this item. \
--- Defaults to `nil`, where the item does not deal any damage.
---@field passive_hurt_amount          number|nil
---@field passive_hurt_frequency       number      Number of turns between each time damage is dealt. Defaults to `1`.
---
--- Amount of tension gained passively by this item. \
--- Defaults to `nil`, where no tension is given.
---@field passive_tension_amount       number|nil
---@field passive_tension_cost         number      Amount of health taken when granting tension. Defaults to `0`.
---@field passive_tension_frequency    number      Number of turns between tension being given. Defaults to `1`.
---
--- The ID of an item to be given to the party. \
--- Defaults to `nil`, where no item is given.
---@field passive_item_name            string|nil
---@field passive_item_tensioncost     number      Amount of tension required to give the item. Defaults to `0`.
---@field passive_item_healthcost      number      Amount of health taken when giving the item. Defaults to `0`.
---@field passive_item_frequency       number      Number of turns between each instance of the item being spawned. Defaults to `1`.
---
--- The chance for this party member to dodge incoming damage. \
--- Ranges from `0` (No chance) to `1` (100% chance), defaulting to `0`.
---@field dodge_chance                 number
---@field dodge_defend_bonus           number      When defending, this is added to `dodge_chance` to get the final dodge chance. Defaults to `0`.
--- The sound file to play when this item's dodge effect is triggered. \
--- Defaults to `nil`, which will play the sword pullback sound from Asriel in UNDERTALE. \
--- When set to `"none"`, no sound will be played.
---@field dodge_sound                  string|nil
---@field dodge_text_color             table       An `{r, g, b}` table of the color to use for the MISS text when dodging. Defaults to white.
---
--- The chance for this party member to strike a random enemy when taking damage. \
--- Ranges from `0` (No chance) to `1` (100% chance), defaulting to `0`.
---@field thorns_chance                number
---@field thorns_defend_bonus          number      When defending, this is added to `thorns_chance` to get the final chance for thorns to activate. Defaults to `0`.
--- The amount of damage dealt to an enemy, as a proportion of damage taken. \
--- Ranges from `0` (0% of damage) to `1` (100% of damage).
---@field thorns_damage_proportion     number
--- The sound file to play when this item's thorns effect is triggered. \
--- Defaults to `nil`, which will play the `"screenshake"` sound. \
--- When set to `"none"`, no sound will be played.
---@field thorns_sound                 string|nil  
---
--- The chance for this party member to reflect incoming damage onto a random enemy. \
--- Ranges from 0 (No chance) to 1 (100% chance), defaulting to 0.
---@field reflect_chance               number
---@field reflect_defend_bonus         number      When defending, this is added to `reflect_chance` to get the final chance to reflect damage. Defaults to `0`.
--- The amount of damage reflected, as a proportion of damage taken. \
--- Ranges from `0` (0% of damage) to `1` (100% of damage), defaulting to `0`.
---@field reflect_damage_proportion    number
--- The sound file to play when this item reflects damage. \
--- Defaults to `nil`, which will play the `"bell_bounce_short"` sound. \
--- When set to `"none"`, no sound will be played.
---@field reflect_sound                string|nil
---
---@overload fun(...) : Item
local Item, super = Class("Item")

function Item:init()
    super:init(self)

    self.heal_bonus = 0
    self.heal_mult = 1
    self.heal_bonuses = {}
    self.heal_mults = {}

    self.victory_heal = 0

    self.starting_tension = 0

    self.passive_heal_amount = nil
    self.passive_heal_cost = 0
    self.passive_heal_frequency = 1

    self.passive_hurt_amount = nil
    self.passive_hurt_frequency = 1

    self.passive_tension_amount = nil
    self.passive_tension_cost = 0
    self.passive_tension_frequency = 1

    self.passive_item_name = nil
    self.passive_item_tensioncost = 0
    self.passive_item_healthcost = 0
    self.passive_item_frequency = 1

    self.dodge_chance = 0
    self.dodge_defend_bonus = 0
    self.dodge_sound = nil
    self.dodge_text_color = {1, 1, 1}

    self.thorns_chance = 0
    self.thorns_defend_bonus = 0
    self.thorns_damage_proportion = 0
    self.thorns_sound = nil

    self.reflect_chance = 0
    self.reflect_defend_bonus = 0
    self.reflect_damage_proprotion = 0
    self.reflect_sound = nil
end

--- Gets the bonus healing added when consuming a HealItem.
---@param chara     PartyMember     The character consuming the item.
---@param item      HealItem        The HealItem being consumed.
---@return number
function Item:getHealBonus(chara, item)
    return self.heal_bonuses[item.id] or self.heal_bonus
end

--- Gets the healing multiplier when consuming a HealItem.
---@param chara     PartyMember     The character consuming the item.
---@param item      HealItem        The HealItem being consumed.
---@return number|nil
function Item:getHealMultiplier(chara, item)
    return self.heal_mults[item.id] or self.heal_mult
end

--- Gets the amount of health restored when winning a battle.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getVictoryHealAmount(chara) return self.victory_heal end

--- Gets the amount of tension given at the start of battle.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getStartingTensionAmount(chara) return self.starting_tension end


--- Checks whether this item is able to conduct passive healing. \
--- By default, checks to see whether the value of health restored is not `nil`.
---@param chara     PartyMember     The character holding this item.
---@return boolean
function Item:doesPassiveHeal(chara) return self:getPassiveHealAmount(chara) ~= nil end

--- Gets the amount of health restored by the passive healing effect.
---@param chara     PartyMember     The character holding this item.
---@return number|nil
function Item:getPassiveHealAmount(chara) return self.passive_heal_amount end

--- Gets the amount of tension consumed to restore health by passive healing.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveHealCost(chara) return self.passive_heal_cost end

--- Gets the number of turns between each passive heal.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveHealFrequency(chara) return self.passive_heal_frequency end

--- Checks whether this item is able to deal passive damage. \
--- By default, checks to see whether the value of damage dealt is not `nil`.
---@param chara     PartyMember     The character holding this item.
---@return boolean
function Item:doesPassiveHurt(chara) return self:getPassiveHurtAmount(chara) ~= nil end

--- Gets the amount of damage this item deals as part of its passive hurt effect.
---@param chara     PartyMember     The character holding this item.
---@return number|nil
function Item:getPassiveHurtAmount(chara) return self.passive_hurt_amount end

--- Gets the number of turns between each time this item deals damage.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveHurtFrequency(chara) return self.passive_hurt_frequency end


--- Checks whether this item is able to grant passive tension. \
--- By default, checks to see whether the value of tension given is not `nil`.
---@param chara     PartyMember     The character holding this item.
---@return boolean
function Item:doesPassiveTension(chara) return self:getPassiveTensionAmount(chara) ~= nil end

--- Gets the amount of tension granted by the passive tension effect.
---@param chara     PartyMember     The character holding this item.
---@return number|nil
function Item:getPassiveTensionAmount(chara) return self.passive_tension_amount end

--- Gets the health deducted when granting tension.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveTensionCost(chara) return self.passive_tension_cost end

--- Gets the number of turns between each time tension is given.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveTensionFrequency(chara) return self.passive_tension_frequency end


--- Checks whether this item passively creates other items. \
--- By default, checks to see whether an item to be given has been specified.
---@param chara     PartyMember     The character holding this item.
---@return boolean
function Item:doesPassiveItem(chara) return self:getPassiveItemName(chara) ~= nil end

--- Gets the ID of the item that this item creates.
---@param chara     PartyMember     The character holding this item.
---@return string|nil
function Item:getPassiveItemName(chara) return self.passive_item_name end

--- Gets the tension consumed when creating an item by the passive item effect.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveItemTensionCost(chara) return self.passive_item_tensioncost end

--- Gets the health consumed when creating an item by the passive item effect.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveItemHealthCost(chara) return self.passive_item_healthcost end

--- Gets the number of turns between each time an item is created.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getPassiveItemFrequency(chara) return self.passive_item_frequency end

--- Checks whether this item allows the holder to dodge attacks.
---@param chara     PartyMember     The character holding this item.
---@return boolean|nil
function Item:doesDodge(chara)
    -- If the item has greater than 0 dodge chance, then it can dodge.
    if self:getDodgeChance(chara, true) > 0 then
        return true
    end
end

--- Gets the total chance of this item executing a successful dodge as a number from `0` to `1`.
---@param chara     PartyMember     The character holding this item.
---@param defending boolean         Whether the character is defending or not.
---@return number
function Item:getDodgeChance(chara, defending)
    if defending then
        return self:getBaseDodgeChance(chara) + self:getDodgeDefendBonus(chara)
    else
        return self:getBaseDodgeChance(chara)
    end
end

--- Gets the base chance of this item executing a successful dodge.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getBaseDodgeChance(chara) return self.dodge_chance end

--- Gets the bonus chance of this item executing a successful dodge when defending.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getDodgeDefendBonus(chara) return self.dodge_defend_bonus end

--- Gets the name of the sound file to play when dodging an attack.
---@param chara     PartyMember     The character holding this item.
---@return string|nil
function Item:getDodgeSound(chara) return self.dodge_sound end

--- Gets the color to use for the default MISS text when dodging an attack as an `r`, `g`, `b` table.
---@param chara     PartyMember     The character holding this item.
---@return table
function Item:getDodgeTextColor(chara) return self.dodge_text_color end

--- Checks whether this item has a thorns effect.
---@param chara     PartyMember     The character holding this item.
---@return boolean|nil
function Item:doesThorns(chara)
    -- If the item has greater than 0 thorn chance, then it can trigger thorns.
    if self:getThornsChance(chara, true) > 0 then
        return true
    end
end

--- Gets the total chance for this item's thorns effect to activate.
---@param chara     PartyMember     The character holding this item.
---@param defending boolean
---@return number
function Item:getThornsChance(chara, defending)
    if defending then
        return self:getBaseThornsChance(chara) + self:getThornsDefendBonus(chara)
    else
        return self:getBaseThornsChance(chara)
    end
end

--- Gets the base chance for this item's thorns effect to activate.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getBaseThornsChance(chara) return self.thorns_chance end

--- Gets the bonus chance for this item's thorns effect to activate when defending.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getThornsDefendBonus(chara) return self.thorns_defend_bonus end

--- Gets the proportion of damage taken to return back to the attacker.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getThornsDamageProportion(chara) return self.thorns_damage_proportion end

--- Gets the sound file to play when the thorns effect triggers.
---@param chara     PartyMember     The character holding this item.
---@return string|nil
function Item:getThornsSound(chara) return self.thorns_sound end

--- Checks whether this item is able to reflect incoming attacks.
---@param chara     PartyMember     The character holding this item.
---@return boolean|nil
function Item:doesReflect(chara)
    -- If the item has greater than 0 reflect chance, then it can reflect.
    if self:getReflectChance(chara, true) > 0 then
        return true
    end
end

--- Gets the total chance for this item's reflect effect to activate.
---@param chara     PartyMember     The character holding this item.
---@param defending boolean
---@return number
function Item:getReflectChance(chara, defending)
    if defending then
        return self:getBaseReflectChance(chara) + self:getReflectDefendBonus(chara)
    else
        return self:getBaseReflectChance(chara)
    end
end

--- Gets the base chance for this item's reflect effect to activate.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getBaseReflectChance(chara) return self.reflect_chance end

--- Gets the bonus chance for this item's reflect effect to activate when defending.
---@param chara     PartyMember     The character holding this item.
---@return number
function Item:getReflectDefendBonus(chara) return self.reflect_defend_bonus end

--- Gets the proportion of damage taken that is reflected onto an enemy.
---@param chara     PartyMember     The character holding this item.
---@return integer
function Item:getReflectDamageProportion(chara) return self.reflect_damage_proprotion end

--- Gets the sound file to play when a reflect is successfully executed.
---@param chara     PartyMember     The character holding this item.
---@return string|nil
function Item:getReflectSound(chara) return self.reflect_sound end

--- A callback that is run when the battle has initialized.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onBattleInit(battler) end

--- A callback that runs at the start of every battle. \
--- By default, this controls the starting tension effect, so `super:onBattleEnd()` should be called in overrides.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onBattleStart(battler) 
    local amount = self:getStartingTensionAmount(battler.chara)

    Game:giveTension(amount)
end

--- A callback that runs at the end of battle, during the transition to the overworld. \
--- By default, this controls the victory healing effect, so `super:onBattleEnd()` should be called in overrides.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onBattleEnd(battler) 
    local amount = self:getVictoryHealAmount(battler.chara)
    if amount > 0 then
        battler:heal(amount)
    end
end

--- A callback that runs at the start of every turn.
---@param battler   PartyBattler    The battler that is holding this item.
---@param turn      integer         The current turn of the battle.
function Item:onTurnStart(battler, turn) end

--- A callback that runs at the end of every turn. \
--- By default, this is responsible for calling the passive item effects, so `super:onTurnEnd()` must be called in overrides.
---@param battler   PartyBattler    The battler that is holding this item.
---@param turn      integer         The current turn of the battle.
function Item:onTurnEnd(battler, turn)
    self:passiveHeal(battler, turn)
    self:passiveHurt(battler,turn)
    self:passiveTensionRestore(battler, turn)
    self:passiveItem(battler, turn)
end

--- A callback that runs when the party begin to execute their actions.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onActionsStart(battler) end

--- A callback that runs after every party member has finished their actions.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onActionsEnd(battler) end

--- A callback that is run whenever a state change is about to occur in battle.
---@param battler   PartyBattler    The battler that is holding this item.
---@param old       string          The state the battle is currently in.
---@param new       string          The state the battle is about to enter.
function Item:beforeStateChange(battler, old, new) end

--- A callback that is run whenever a state change occurs in battle.
---@param battler   PartyBattler    The battler that is holding this item.
---@param old       string          The state the battle was previously in.
---@param new       string          The state the battle has entered.
function Item:onStateChange(battler, old, new) end

--- A callback that is run whenever the entire party is downed in battle. \
--- This callback runs before the wave is stopped. See `onGameOver()` for a callback where the wave has been stopped. \
--- Returning `true` will stop the game over process.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:beforeGameOver(battler) end

--- A callback that is run whenever the entire party is downed in battle. \
--- The wave is stopped just before this - see `beforeGameOver()` for a callback before the wave ends. \
--- Returning `true` will cancel the game over process.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onGameOver(battler) end

--- A callback that is run whenever the wearer deals damage to an enemy.
---@param battler   PartyBattler    The battler that is holding this item.
---@param enemy     EnemyBattler    The enemy that has been hit.
---@param damage    integer         The amount of damage dealt in the attack.
function Item:onEnemyHit(battler, enemy, damage) end

--- A callback that is run just before the wearer takes damage. \
--- Returning `true` will cancel the holder being hurt. \
--- This callback handles the reflect effect, so `super:beforeHolderHurt()` should be called when overriding this function.
---@param battler   PartyBattler    The battler that is holding this item.
---@param damage    integer         The amount of damage dealt in the attack.
---@param defending boolean         Whether the battler is defending.
function Item:beforeHolderHurt(battler, damage, defending) 
    if self:doesDodge(battler.chara) then
        -- Get the actual dodge chance
        local chance = self:getDodgeChance(battler.chara, defending) * 100
        -- Then pull a random number between 1 and 100 and compare it to chance
        if love.math.random(1, 100) <= chance then
            -- Trigger callback and return true to block damage
            self:onDodge(battler, damage, defending)
            return true
        end
    end
    -- Something similar for reflects, but with a few changes.
    if self:doesReflect(battler.chara) then
        local chance = self:getReflectChance(battler.chara, defending) * 100
        if love.math.random(1, 100) <= chance then
            -- Calculate the amount of damage that is being reflected and being taken by the battler.
            local ref_amount = math.floor(damage * self:getReflectDamageProportion(battler.chara))
            local hurt_amount = damage - ref_amount
            -- Hurt the battler for the damage minus reflected amount.
            if hurt_amount > 0 then 
                battler:hurt(hurt_amount, true)
            end
            -- Then reflect the rest to an enemy.
            local enemies = {}
            for _, e in ipairs(Game.battle.enemies) do
                if e.health > 1 then
                    table.insert(enemies, e)
                end
            end
            -- Return early if no available enemies to reflect damage to.
            if #enemies == 0 then
                return
            end
            local enemy = Utils.pick(enemies)
            -- Prevent the reflect from being lethal. (This damage simply disappears, rather than compromising the effect of the user's reflect.)
            if enemy.health < ref_amount then
                ref_amount = enemy.health - 1
            end
            enemy:hurt(ref_amount)
            -- Trigger callback
            self:onReflect(battler, damage, ref_amount, enemy, defending)
            -- Return true to block the original damage.
            return true
        end
    end
end

--- A callback that is run whenever the wearer is hurt. \
--- This callback handles the thorns effect, so `super:onHolderHurt()` should be called when overriding this function.
---@param battler   PartyBattler    The battler that is holding this item.
---@param damage    integer         The amount of damage dealt in the attack.
---@param defending boolean         Whether the battler is defending.
function Item:onHolderHurt(battler, damage, defending) 
    -- Very similar to reflect.
    if self:doesThorns(battler.chara) then
        local chance = self:getThornsChance(battler.chara, defending) * 100
        if love.math.random(1, 100) <= chance then
            -- Calculate the amount of damage that is being thorned.
            local amount = math.floor(damage * self:getThornsDamageProportion(battler.chara))
            -- Then deal it to any eligible enemy (any enemy with more than 1 hp.)
            local enemies = {}
            for _, e in ipairs(Game.battle.enemies) do
                if e.health > 1 then
                    table.insert(enemies, e)
                end
            end
            -- Return early if no available enemies to hit with thorns.
            if #enemies == 0 then
                return
            end
            local enemy = Utils.pick(enemies)
            -- Prevent thorns from being lethal.
            if enemy.health < amount then
                amount = enemy.health - 1
            end
            enemy:hurt(amount)
            self:onThorns(battler, damage, amount, enemy, defending)
        end
    end
end

--- A callback that is run before the wearer is downed. \
--- If this function returns `true`, then the wearer will not be downed.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:beforeHolderDowned(battler) end

--- A callback that is run when the wearer is downed.
---@param battler   PartyBattler    The battler that is holding this item.
function Item:onHolderDowned(battler) end

--- Controls the passive healing effect.
---@param battler   PartyBattler    The battler that is holding this item.
---@param turn      integer         Current battle turn.
function Item:passiveHeal(battler, turn)
    -- Standard checks & check to only activate if not at max HP.
    if self:doesPassiveHeal(battler.chara) and turn % self:getPassiveHealFrequency(battler.chara) == 0 and battler.chara.health < battler.chara:getStat("health") then
        -- If the cost (TP) is less than or equal to the current party tension, the battler is healed and tension is removed.
        if self:getPassiveHealCost(battler.chara) <= Game.tension then
            battler:heal(self:getPassiveHealAmount(battler.chara))
            Game:removeTension(self:getPassiveHealAmount(battler.chara)) 
        end
    end
end

--- Controls the passive damage/damage over time effect.
---@param battler   PartyBattler    The battler that is holding this item.
---@param turn      integer         Current battle turn.
function Item:passiveHurt(battler, turn)
    -- Standard checks & check that battler is not downed.
    if self:doesPassiveHurt(battler.chara) and turn % self:getPassiveHurtFrequency(battler.chara) == 0 and not battler.is_down and (Kristal.getLibConfig("pie", "passsiveHurtCanKill", true) or battler.chara.health > self:getPassiveHurtAmount(battler.chara)) then
        battler:hurt(self:getPassiveHurtAmount(battler.chara), true, {1, 1, 1}, {ignore_callback = true})
    end
end

--- Controls the passive Tension restoring effect.
---@param battler   PartyBattler    The battler that is holding this item.
---@param turn      integer         Current battle turn.
function Item:passiveTensionRestore(battler, turn)
    -- Standard checks and check to only activate if not at max TP.
    if self:doesPassiveTension(battler.chara) and turn % self:getPassiveHurtFrequency(battler.chara) == 0 and Game.tension < 100 then
        -- Since battler:hurt() deals a minimum of 1 damage, the HP cost must be checked to see if it is above 0.
        if self:getPassiveTensionCost(battler.chara) > 0 then
            -- If there is enough HP to cover the cost, then TP is given and the battler is hurt.
            if self:getPassiveTensionCost(battler.chara) < battler.chara.health or Kristal.getLibConfig("pie", "passiveEffectCostCanKill", true) then
                Game:giveTension(self:getPassiveTensionAmount(battler.chara))
                battler:hurt(self:getPassiveTensionCost(battler.chara), true, {1, 1, 1}, {ignore_callback = true})
            end
        -- If there is no cost, tp is given directly, and battler:hurt() is not called.
        else
            Game:giveTension(self:getPassiveTensionAmount(battler.chara))
        end
    end
end

--- Controls the passive item giving effect.
---@param battler   PartyBattler    The battler that is holding this item.
---@param turn      integer          Current battle turn.
function Item:passiveItem(battler, turn)
    if self:doesPassiveItem(battler.chara) and turn % self:getPassiveItemFrequency(battler.chara) == 0 then
        -- When giving an item, it can cost BOTH hp and tp, so both must be checked.
        local can_afford = (self:getPassiveItemTensionCost(battler.chara) <= Game.tension and (self:getPassiveItemHealthCost(battler.chara) < battler.chara.health or Kristal.getLibConfig("pie", "passiveEffectCostCanKill", true)))

        -- If both checks pass then an attempt to add the item is made.
        if can_afford then
            local res_item = Game.inventory:addItemTo("items", self:getPassiveItemName(battler.chara), false)

            -- If the item is added successfully (there was space in the main inventory) then TP and HP are deducted.
            if res_item ~= nil then
                Game:removeTension(self:getPassiveItemTensionCost(battler.chara))
                -- Once again, only call battler:hurt() if there is a HP cost.
                if self:getPassiveItemHealthCost(battler.chara) > 0 then
                    battler:hurt(self:getPassiveItemHealthCost(battler.chara), true, {1, 1, 1}, {ignore_callback = true})
                end
            end
        end
    end
end

-- Damage effect callbacks below.
-- Extend these to add custom effects or messages when effects trigger!

--- The callback that occurs whenever an attack is dodged by this item. \
--- By default, plays a sound and creates a MISS battle text.
---@param battler   PartyBattler    The battler that is holding this item.
---@param damage    integer         The damage this battler would have taken.
---@param defending boolean         Whether the battler was defending or not.
function Item:onDodge(battler, damage, defending)
    -- Retrieve sound and color
    local snd = self:getDodgeSound(battler.chara) or "mus_sfx_a_pullback"  -- This sound is asriel's sword pullback from UNDERTALE.
    local color = self:getDodgeTextColor(battler.chara)

    -- Make a "miss" status message and play sound cue.
    battler:statusMessage("msg", "miss", color)
    -- If the sound is none then don't play anything.
    if snd ~= "none" then
        Assets.playSound(snd)
    end
end

--- The callback that occurs whenever this item's thorns effect is triggered. \
--- By default, plays a sound.
---@param battler   PartyBattler    The battler that is holding this item.
---@param damage    integer         The damage that the battler has taken.
---@param thorned   integer         The damage thorned onto the enemy.
---@param enemy     EnemyBattler    The enemy that has been struck.
---@param defending boolean         Whether the battler was defending or not.
function Item:onThorns(battler, damage, thorned, enemy, defending)
    local snd = self:getThornsSound(battler.chara) or "screenshake"

    if snd ~= "none" then
        Assets.playSound(snd)
    end

end

--- The callback that occurs whenever this item reflects damage. \
--- By default, plays a sound.
---@param battler   PartyBattler    The battler that is holding this item.
---@param damage    integer         The damage that the battler has taken.
---@param reflected integer         The damage reflected onto the enemy.
---@param enemy     EnemyBattler    The enemy that has been struck.
---@param defending boolean         Whether the battler was defending or not.
function Item:onReflect(battler, damage, reflected, enemy, defending)
    local snd = self:getReflectSound(battler.chara) or "bell_bounce_short"
    
    if snd ~= "none" then
        Assets.playSound(snd)
    end
end

return Item