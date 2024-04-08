local item, super = Class(HealItem, "uty_items/feisty_slider")

function item:init(inventory)
    super.init(self)

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- Display name
    self.name = "Feisty Slider"
    self.short_name = "FeistSlidr"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 30

    self.price = 30
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "(It's family friendly!)"

    -- Light world check text
    self.check = {"Heals 30 HP\"", "* (A small burger with big\nflavor! Just 30G at the\nSaloon!)", "* (...Says an ad printed on its\nwrapper.)"}

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
    return "* (You eat the Feisty Slider.\nMuch like the team, its flavor\nis... ambitious.)"
end

function item:getLightBattleText(user, target)
    return "* (You eat the Feisty Slider.\nMuch like the team, its flavor\nis... ambitious.)"
end

return item