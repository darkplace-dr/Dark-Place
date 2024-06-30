local item, super = Class(Item, "crescentpin") -- File name is staying the same just so I don't break an save files.

function item:init()
    super.init(self)

    -- Display name
    self.name = "SkyLense"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A gift from one lover to another.\nGrants extra bonuses to a specific person."

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
    self.bonuses = {
        defense = 3
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "???"
    self.bonus_icon = "ui/menu/icon/magic"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = false,
        noel = false,
    }

    -- Character reactions
    self.reactions = {
        susie = "Looks pretty cool!",
        ralsei = "A monocle...?",
        noelle = "(I wonder if I should give Susie a gift...)",
		dess = "I'm allergic to love",
        brenda = "Thank you Celesy...",
		jamm = "No use for me.",
	noel = "Lame.",
    }
end

function item:onEquip(character, replacement)
    if character.id == "brenda" then
        character:increaseStat("defense", 2)
        character:increaseStat("magic", 5)
        character:increaseStat("health", 50)
        character:addSpell("heal_prayer")
        self.bonus_name = "Stats Up"
        self.bonus_icon = "ui/menu/icon/up"
    end
    return true
end

function item:onUnequip(character, replacement)
    if character.id == "brenda" then
        character:increaseStat("defense", -2)
        character:increaseStat("magic", -5)
        character:increaseStat("health", -50)
        character:removeSpell("heal_prayer")
        self.bonus_name = "???"
        self.bonus_icon = "ui/menu/icon/magic"
    end
    return true
end

return item