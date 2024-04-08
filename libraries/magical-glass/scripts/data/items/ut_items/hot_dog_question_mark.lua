local item, super = Class(HealItem, "ut_items/hot_dog_question_mark")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Hot Dog...?"
    self.short_name = "Hot Dog"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 20

    -- Default shop price (sell price is halved)
    self.price = 30
    -- Default shop sell price
    self.sell_price = 10
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "The \"meat\" is made of something called a \"water sausage.\""

    -- Light world check text
    self.check = "Heals 20 HP\n* The \"meat\" is made of something\ncalled a \"water sausage.\""

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
            Assets.stopAndPlaySound("dogsalad")
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
            Assets.stopAndPlaySound("dogsalad")
        else
            Assets.stopAndPlaySound("power")
        end
    end)
end

function item:onBattleUse(user, target)
    if not MagicalGlassLib.serious_mode then
        Assets.stopAndPlaySound("dogsalad")
    end
    target:heal(self:getHealAmount())
    return true
end


return item