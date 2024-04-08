local item, super = Class(HealItem, "ut_items/hot_cat")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Hot Cat"
    self.short_name = "Hot Cat"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 21

    -- Default shop price (sell price is halved)
    self.price = 30
    -- Default shop sell price
    self.sell_price = 11
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Like a hot dog, but with little cat ears on the end."

    -- Light world check text
    self.check = "Heals 21 HP\n* Like a hot dog,[wait:10] but with\nlittle cat ears on the end."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:battleUseSound(user, target)
    Game.battle.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        if not MagicalGlassLib.serious_mode then
            Assets.stopAndPlaySound("catsalad")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

function item:worldUseSound(target)
    Game.world.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        if not MagicalGlassLib.serious_mode then
            Assets.stopAndPlaySound("catsalad")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

function item:onBattleUse(user, target)
    if not MagicalGlassLib.serious_mode then
        Assets.stopAndPlaySound("catsalad")
    end
    target:heal(self:getHealAmount())
    return true
end


return item