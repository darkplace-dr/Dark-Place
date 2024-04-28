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
    if target.id == Game.party[1].id then
        return "* (You eat the Feisty Slider.[wait:5]\nMuch like the team,[wait:5] its flavor\nis...[wait:10] ambitious.)"
    else
        return "* ("..target:getName().." eats the Feisty Slider.)"
    end
end

function item:getLightBattleText(user, target)
    if target.chara.id == Game.battle.party[1].chara.id then
        return "* (You eat the Feisty Slider.[wait:5]\nMuch like the team,[wait:5] its flavor\nis...[wait:10] ambitious.)"
    else
        return "* ("..target.chara:getName().." eats the Feisty Slider.)"
    end
end

return item