local item, super = Class(HealItem, "ut_items/glamburger")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Glamburger"
    self.short_name = "GlamBurg"
    self.serious_name = "G. Burger"

    -- How this item is used on you (ate, drank, eat, etc.)
    self.use_method = "eat"
    -- How this item is used on other party members (eats, etc.)
    self.use_method_other = "eats"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 27

    -- Shop description
    self.shop = "Heals 27HP\nVery popular\nfood."
    -- Default shop price (sell price is halved)
    self.price = 120
    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A hamburger made of edible glitter and sequins."

    -- Light world check text
    self.check = "Heals 27 HP\n* A hamburger made of edible\nglitter and sequins."

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
        Assets.stopAndPlaySound("sparkle1")
    end)
end

function item:worldUseSound(target)
    Game.world.timer:script(function(wait)
        Assets.stopAndPlaySound("swallow")
        wait(0.4)
        Assets.stopAndPlaySound("sparkle1")
    end)
end

return item