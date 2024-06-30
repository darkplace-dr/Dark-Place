local item, super = Class(Item, "soulmantle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "SoulMantle"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A mantle made from purple fire.\nHuge magic increase and reflects damage."

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
        defense = 7,
        magic = 10,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Counter"
    self.bonus_icon = "ui/menu/icon/fire"

    self.thorns_chance = 1
    self.thorns_damage_proportion = 0.6

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        ralsei = false,
        noelle = false,
        noel = false,
    }

    -- Character reactions
    self.reactions = {
        susie = "Bow down to your new overlord!... Just kidding!",
        ralsei = "Um, I think that would set my fur on fire...",
        noelle = "N-no, I would MELT in that thing, fahaha...",
        dess = "i feel a sudden urge to sell microtransactions",
        brenda = "Uhh... This isn't gonna kill me, is it?",
        noel = "(I would consume it.)",
    }
end

return item