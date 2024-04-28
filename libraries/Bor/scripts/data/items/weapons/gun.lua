local item, super = Class(Item, "borgun")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Mr. Gun III"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/borgun"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An ancient, powerful gun made of...\ndiamonds???"

    -- Default shop price (sell price is halved)
    self.price = 500
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
        attack = 69,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Murder"
    self.bonus_icon = "ui/menu/icon/exclamation"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        dess = true,
        brenda = true,
        bor = true,
    }

    -- Character reactions
    self.reactions = {
        bor = "It's morbin' time!",
        berdly = "A gun?! Haha, no. Gamers have STANDARS, you know?",
        dess = "HELL FUCKING YUEHAH GIMME",
        brenda = "I- Uh... Well... Sure??",
        susie = "(HOW DID YOU GET A GUN???)",
        ralsei = "Ummm... I'd rather not use this...",
        noelle = "(I- I don't think it's legal to have this-)",
    }
end

return item