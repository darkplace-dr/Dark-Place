local item, super = Class(HealItem, "uty_items/icewater")

function item:init(inventory)
    super.init(self)

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "drink"
    -- Display name
    self.name = "Icewater"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 15

    self.price = 18
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(The prequel to ice tea.)"

    -- Light world check text
    self.check = "Heals 15 HP\n* (The prequel to ice tea.)"

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
        return "* (You drink the Icewater.[wait:5]\nDefinitely has a taste but you\ncan't describe it.)"
    else
        return "* ("..target:getName().." drinks the Icewater.)"
    end
end

function item:getLightBattleText(user, target)
    if target.chara.id == Game.battle.party[1].chara.id then
        return "* (You drink the Icewater.[wait:5]\nDefinitely has a taste but you\ncan't describe it.)"
    else
        return "* ("..target.chara:getName().." drinks the Icewater.)"
    end
end

return item