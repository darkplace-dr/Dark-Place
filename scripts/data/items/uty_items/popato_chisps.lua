local item, super = Class(HealItem, "uty_items/popato_chisps")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Popato Chisps"
    self.short_name = "PT Chisps"
    self.serious_name = "Chips"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 13

    -- Default shop price (sell price is halved)
    self.price = 24
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(Regular old popato chisps.)"

    -- Light world check text
    self.check = "Heals 13HP\"\n* (Regular old popato chisps.)"

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:onWorldUse(target)
    target:heal(self:getWorldHealAmount())
    Game.world:showText(self:getWorldUseText(target))
    return true
end

function item:onLightBattleUse(target)
    target:heal(self:getBattleHealAmount())
    self:battleUseSound(user, target)
    Game.battle:battleText(self:getLightBattleText(user, target))
    return true
end

function item:getWorldUseText(target)
    if target.id == Game.party[1].id then
        return "* (You eat the Popato Chisps.[wait:5]\nThe crunch is deafening.)"
    else
        return "* ("..target:getName().." eats the Popato Chisps.[wait:5]\nThe crunch is deafening.)"
    end
end

function item:getLightBattleText(user, target)
    if target.chara.id == Game.battle.party[1].chara.id then
        return "* (You eat the Popato Chisps.[wait:5]\nThe crunch is deafening.)"
    else
        return "* ("..target.chara:getName().." eats the Popato Chisps.[wait:5]\nThe crunch is deafening.)"
    end
end

return item