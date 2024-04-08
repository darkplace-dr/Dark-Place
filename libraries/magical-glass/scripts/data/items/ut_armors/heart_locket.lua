local item, super = Class(LightEquipItem, "ut_armors/heart_locket")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Heart Locket"
    self.short_name = "<--Locket"
    self.serious_name = "H. Locket"
    self.use_name = "locket"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 250
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "It says \"Best Friends Forever.\""

    -- Light world check text
    self.check = "Armor DF 15\n* It says \"Best Friends Forever.\""

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 15
    }

end

function item:showEquipText(target)
    Game.world:showText("* "..target:getNameOrYou().." equipped the locket.")
end

return item