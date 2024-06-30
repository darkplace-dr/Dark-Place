local item, super = Class(Item, "heatarmor")

function item:init()
    super.init(self)

    -- Display name
    self.name = "HeatArmor"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Armor that makes you warm.\nPrevents frostbite damage."

    -- Default shop price (sell price is halved)
    self.price = nil
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Heat"
    self.bonus_icon = "ui/menu/icon/magic"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noel = false,
    }

    -- Character reactions
    self.reactions = {
		jamm = "Toasty...",
		mario = {
				mario = "But I can just use a fire flower.",
				jamm = "Eh."
			},
        noel = "A heated blanket would do a better job.",
    }
end

return item