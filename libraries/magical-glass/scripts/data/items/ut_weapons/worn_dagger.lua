local item, super = Class(LightEquipItem, "ut_weapons/worn_dagger")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Worn Dagger"
    self.short_name = "WornDG"
    self.serious_name = "W. Dagger"
    self.use_name = "dagger"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 250
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Perfect for cutting plants and vines."

    -- Light world check text
    self.check = "Weapon AT 15\n* Perfect for cutting plants\nand vines."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 15
    }

    self.light_bolt_direction = "random"

end

function item:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou() .. " equipped the dagger.")
end

return item