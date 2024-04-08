local item, super = Class(LightEquipItem, "ut_armors/faded_ribbon")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Faded Ribbon"
    self.short_name = "Ribbon"
    self.use_name = "ribbon"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "If you're cuter, monsters won't hit you as hard."

    -- Light world check text
    self.check = "Armor DF 3\n* If you're cuter,[wait:10] monsters\nwon't hit you as hard."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 3
    }

    -- Default dark item conversion for this item
    self.dark_item = "white_ribbon"
end

function item:showEquipText(target)
    Game.world:showText("* "..target:getNameOrYou().." equipped the ribbon.")
end

return item