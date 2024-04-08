local item, super = Class(HealItem, "ut_items/bisicle")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Bisicle"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    self.heal_amount = 11

    -- Shop description
    self.shop = "Heals 11HP x 2\nEat it twice!"
    -- Default shop price (sell price is halved)
    self.price = 15
    -- Default shop sell price
    self.sell_price = 5
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "It's a two-pronged popsicle, so you can eat it twice."

    -- Light world check text
    self.check = "Heals 11 HP\n* It's a two-pronged popsicle,[wait:10]\nso you can eat it twice."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "ut_items/unisicle"
    -- Will this item be instantly consumed in battles?
    self.instant = false
end

function item:getWorldUseText(target)
    if target:getNameOrYou() == "You" then
        return "* You eat one half\nof the Bisicle."
    else
        return "* "..target:getName().." eats one half\nof the Bisicle."
    end
end

function item:getLightBattleText(user, target)
    if target.chara:getNameOrYou() == "You" then
        return "* You eat one half\nof the Bisicle."
    else
        return "* "..target:getName().." eats one half\nof the Bisicle."
    end
end

return item