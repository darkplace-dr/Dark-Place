local item, super = Class(Item, "devil_bow")

function item:init()
    super:init(self)

    -- Display name
    self.name = "Devil's Bow"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Decreases graze range by 50%. Good for challenges."

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
    self.bonuses = {
		graze_size = -0.5,
	}
	
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Devil's Bow"
    self.bonus_icon = "minus"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {}
end

return item