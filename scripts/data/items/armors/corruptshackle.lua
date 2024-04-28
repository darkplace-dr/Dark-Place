local item, super = Class(Item, "corruptshackle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CorruptShackle"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A corrupted spiked shackle worn around the neck.\nFills the wearer with draconic power."

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
		jamm = false,
	}

    -- Character reactions
    self.reactions = {
        susie = "Hell yeah! I feel so strong!",
        ralsei = "It's really heavy...",
        noelle = "(Smells like Susie...)",
        dess = "I feel just like Halojack Metropolis",
        brenda = "Jeez it's hard to move my head...",
		jamm = "No thanks. Not after last time."
    }
end

function item:onEquip(character, replacement)
    if character.id == "susie" then
        character:increaseStat("defense", 4)
        character:increaseStat("magic", 3)
        character:increaseStat("attack", 5)
        character:increaseStat("health", 75)
        character:addSpell("flame_buster")
        self.bonus_name = "Awakened"
        self.bonus_icon = "ui/menu/icon/magic"
    end
    return true
end

function item:onUnequip(character, replacement)
    if character.id == "susie" then
        character:increaseStat("defense", -4)
        character:increaseStat("magic", -3)
        character:increaseStat("attack", -5)
        character:increaseStat("health", -75)
        character:removeSpell("flame_buster")
        self.bonus_name = nil
        self.bonus_icon = nil
    end
    return true
end

return item