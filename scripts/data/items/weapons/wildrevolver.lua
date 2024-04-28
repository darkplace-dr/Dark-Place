local item, super = Class(Item, "wildrevolver")

function item:init()
    super.init(self)

    -- Display name
    self.name = "WildRevolver"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/gun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A six-shooter revolver that holds six bullets.\nThe grip is engraved with yellow clovers."

    -- Default shop price (sell price is halved)
    self.price = 2000
    -- Whether the item can be sold
    self.can_sell = true

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
        attack = 12,
        magic = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "JUSTICE"
    self.bonus_icon = "ui/menu/icon/gun"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        brenda = true,
		pauling = true,
    }

    self.bolt_count = 6

    -- Character reactions
    self.reactions = {
        susie = "I'm not a cowboy.",
        ralsei = "U-um, n-no thank you?",
        noelle = "I u-um, don't think I should have that.",
		dess = "yee haw",
        brenda = "Time to enact some justice!",
        ceroba = "Is that...",
    }
end

return item