local item, super = Class(Item, "excalibat")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Excalibat"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/bat"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Christmas-themed double-reference of incredible power.\nGame Reference: Rise of the Triad"

    -- Default shop price (sell price is halved)
    self.price = 2350
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
        attack = 4,
		magic = 7,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "SuperMagical"
    self.bonus_icon = "ui/menu/icon/magic"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = true,
    }

    -- Character reactions
    self.reactions = {
		dess = "aardwolf",
		ralsei = "I'm not worthy of this!",
		susie = "Too holy for me.",
		noelle = "How is this Christmas-themed??",
        brenda = "It sure is green.",
		jamm = "I know I like green, but...",
                noel = [[I WILL RULE "BASEBALL" ENGLAND!!!]],
    }
end

function item:onEquip(character, replacement)
	character:addSpell("save1stbase")
	return true
end

function item:onUnequip(character, replacement)
	character:removeSpell("save1stbase")
	return true
end

return item