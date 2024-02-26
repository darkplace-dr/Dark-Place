local item, super = Class(Item, "bugblade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "BugBlade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "CHOP CHOP\nGOOD THROW!\nCRIMINAL!"
    -- Menu description
    self.description = "An obscure, broken blade. Perhaps someone else can use this?"

    -- Default shop price (sell price is halved)
    self.price = 2
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
        attack = 100,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Glitch"
    self.bonus_icon = "ui/menu/icon/fluff"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true
    }

    -- Character reactions
    self.reactions = {
        asriel      = "(Why can't I grab this properly?!)",
        ralsei      = "(Err, is all of this supposed to happen...?)",
        synthlave   = "(Fellow.)",
    }
end

function item:getShopDescription()
    -- Don't automatically add item type
    return self.shop
end

return item