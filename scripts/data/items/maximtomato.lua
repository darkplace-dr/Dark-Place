-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "maximtomato")

function item:init()
    super:init(self)

    -- Display name
    self.name = "MaximTomato"
    -- Name displayed when used in battle (optional)
    self.use_name = "MAXIM TOMATO"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nall HP"
    -- Shop description
    self.shop = "Fully heals"
    -- Menu description
    self.description = "A magical tomato.\nfully heals HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 999

    -- Default shop price (sell price is halved)
    self.price = 5000
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
        susie = "Who knew vegtables could taste so good!",
        ralsei = "I feel great!",
        noelle = "Wow, did that fully heal?",
		dess = "mm tomate",
    }
end

return item
