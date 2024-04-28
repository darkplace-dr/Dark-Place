-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "healitem")

function item:init()
    super.init(self)

    -- Display name
    self.name = "HealItem"
    -- Name displayed when used in battle (optional)
    self.use_name = "HEALITEM"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "It heals.\n+?? HP"
    -- Shop description
    self.shop = "Unfinished\nHealItem\n+?? HP"
    -- Menu description
    self.description = "An item that is supposed to heal. Does not have texture, taste or anything. +?? HP."

    -- Amount healed (HealItem variable) (It's "broken" on purpose)
    self.heal_amount = Utils.random(5, 200)

    -- Default shop price (sell price is halved)
    self.price = 150
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "(Did I eat something?)",
        ralsei = "It's, uh... good for invisible food!",
        noelle = "(What is it supposed to be??)",
        dess = "bro its unfinished",
        brenda = "Is this a mime sandwich?",
		jamm = "I feel the glitches inside me.",
		mario = "Sonic"
    }
end

return item
