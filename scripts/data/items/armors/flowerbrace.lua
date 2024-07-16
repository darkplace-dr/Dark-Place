local item, super = Class(Item, "flowerbrace")

function item:init()
    super.init(self)

    -- Display name
    self.name = "FlowerBrace"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A flower bracelet that can awaken limitless potential in a specific person."

    -- Default shop price (sell price is halved)
    self.price = 0
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
        attack = 1,
        defense = 2,
        magic = 3
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
		susie = false,
		noelle = false,
        brenda = false,
        mario = false,
        noel = false,
	}

    -- Character reactions
    self.reactions = {
        noel = {
            noel = "(Dead wife? CRINGE.)",
            jamm = "Noel, shut the fuck up."
        },
        susie = "Looks dumb, feels dumb. I don't want it.",
        ralsei = "Look at all the colors!",
        noelle = "(It doesn't fit...?)",
        brenda = "This uh... isn't mine.",
		jamm = "Thank you, Ania. I won't forget this.",
		mario = {
				mario = "Blech! That tastes like shit!",
				jamm = "Did you try to eat it!?"
			}
    }
end

function item:onEquip(character, replacement)
    if character.id == "jamm" then
        character:increaseStat("defense", 5)
        character:increaseStat("magic", 5)
        character:increaseStat("attack", 6)
        character:increaseStat("health", 60)
        character:addSpell("electric_havoc")
        self.bonus_name = "Reminded"
        self.bonus_icon = "ui/menu/icon/magic"
    end
    return true
end

function item:onUnequip(character, replacement)
    if character.id == "jamm" then
        character:increaseStat("defense", -5)
        character:increaseStat("magic", -5)
        character:increaseStat("attack", -6)
        character:increaseStat("health", -60)
        character:removeSpell("electric_havoc")
        self.bonus_name = nil
        self.bonus_icon = nil
    end
    return true
end

return item
