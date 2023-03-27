local item, super = Class(Item, "mets_bat")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Mets Bat"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/bat"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "WOOO YEAH THE METS BABY IT'S ALL ABOUT THE METS"

    -- Default shop price (sell price is halved)
    self.price = 700
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
        attack = 5,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "METS UP"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = true,
    }

    -- Character reactions
    self.reactions = {
		dess = "IT'S ABOUT THE METS BABY THE METS",
		ralsei = "Who? I've never 'met' them!",
		susie = "Never heard of em'.",
		noelle = "Baseball is Dess' thing...",
    }
end

--function item:convertToLightEquip(chara)
--    return "light/pencil"
--end

return item