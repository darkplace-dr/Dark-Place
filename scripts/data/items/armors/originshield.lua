local item, super = Class(Item, "originshield")

function item:init()
    super.init(self)

    -- Display name
    self.name = "OriginShield"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A shield that's completely unbreakable.\nChance to nullify damage taken."

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
        defense = 6,
		magic = 3
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Immunity"
    self.bonus_icon = "ui/menu/icon/magic"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noel = false,
    }

    -- Character reactions
    self.reactions = {
        susie = "This is kinda cool, actually.",
        ralsei = "I feel like a knight with this!",
        noelle = {
            noelle = "I-I'll um, p-protect you, Susie!",
            susie = "Uh, thanks I guess?"
        },
        brenda = "So I can just say \"no\" to damage sometimes with this?",
		jamm = "Oof! It's heavy...",
		mario = "Mario feels like a gladiator again.",
        noel = "(My quirk does a better job.)",
    }

    self.dodge_chance = 0.1
    self.dodge_defend_bonus = 0.15
    self.dodge_text_color = {1, 0.5, 1}
    self.dodge_sound = "bell"
end

return item
