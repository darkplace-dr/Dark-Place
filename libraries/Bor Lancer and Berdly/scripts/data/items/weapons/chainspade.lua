local item, super = Class(Item, "chainspade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ChainSpade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/spade"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A magic chained spade. Made of spades,\nby spades, for spades."

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
        attack = 4,
        magic = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Spadyness UP"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        lancer = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Heh, cold and rusty. Like me.",
        ralsei = "It's... Umm... Interesting.",
        noelle = "Looks... Metal-ly???",
        berdly = "That's not an iron sword!",
        lancer = "...",
    }
end

return item