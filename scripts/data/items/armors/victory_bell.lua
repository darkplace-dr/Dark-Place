local item, super = Class(Item, "victory_bell")

function item:init()
    super:init(self)

    -- Display name
    self.name = "VictoryBell"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Heals you 20 HP after battle (for the most part)."

    -- Shop buy price
    self.buy_price = 0
    -- Shop sell price (set to nil)
    self.sell_price = nil

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = nil
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
	
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "VictoryBell"
    self.bonus_icon = "plus"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noel = false,
    }

    -- Character reactions
    self.reactions = {
        noel = "(I don't think this is meant for me)",
    }
end

return item
