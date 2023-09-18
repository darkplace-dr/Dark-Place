local item, super = Class(Item, "focus")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Focus"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/placebo"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Hold [A] during battle to slow down time.\nTP bar determines amount of time you can use it."

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
        defense = 1
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Concentration"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        robo_susie = false
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        robo_susie = "I'm too ultimate for that.",
        noyno = "Ommmmmm....."
    }
end

-- Function overrides go here

return item