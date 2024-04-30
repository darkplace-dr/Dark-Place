-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "spray_bottle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Spray Bottle"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Water"
    -- Shop description
    self.shop = nil
    -- Menu description
    self.description = "A spray bottle. Like one you'd use on dogs."

    -- Default shop price (sell price is halved)
    self.price = 200
    -- Whether the item can be sold
    self.can_sell = true
	
	self.refundable = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "spray_bottle"
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
		jamm = "Hey! Cut that out!"
    }
end

function item:getBattleText(user, target)
    return "* "..user.chara:getName().." sprayed "..target.chara:getName().." with the "..self:getUseName().."."
end

return item
