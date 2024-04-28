local item, super = Class(Item, "casey_bat")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Casey Bat"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/bat"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Maybe an EarthBound reference,\nmaybe not."

    -- Default shop price (sell price is halved)
    self.price = 1200
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
    self.bonuses = {
        attack = 14,
		defense = -8,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "UNLUCKY"
    self.bonus_icon = "ui/menu/icon/smile_dog"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = true,
		susie = true,
    }

    -- Character reactions
    self.reactions = {
		dess = "What is 'humility'",
		ralsei = "I'm not good enough!",
		susie = "You know what? Sure.",
		noelle = "I'm not good at baseball!!",
		brenda = "I don't play sports.",
		jamm = "Don't want to hit a crotch again!"
    }
end

--function item:convertToLightEquip(chara)
--    return "light/pencil"
--end

return item