local item, super = Class(Item, "aeonlance")

function item:init()
    super.init(self)

    -- Display name
    self.name = "AeonLance"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A powerful lance once wielded by the legendary\nAeon Hero. Attacks hurt all foes."

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
        attack = 15,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Hurt ALL"
    self.bonus_icon = "ui/menu/icon/sword"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
        YOU = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Nah, lances aren't really my style.",
        ralsei = "Um, that looks dangerous, Kris.",
        noelle = "It feels... magical?",
		jamm = {
            jamm = "I never was a swords guy.",
            brenda = "Grah, lances aren't swords !! /lh",
        },
        noel = "Sure, give it to the possesed kid...",
    }
end

return item
