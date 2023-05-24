-- Instead of Item, create a HealItem, a convenien  t class for consumable healing items
local item, super = Class(HealItem, "calizonia special")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CaliSpecil"
    -- Name displayed when used in battle (optional)
    self.use_name = "CALIZONIA SPECIAL"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals Party\n 50HP"
    -- Shop description
    self.shop = "California\n BABEY!!!"
    -- Menu description
    self.description = "An Italian-style Calzone made a Filipino rat\nliving in California. Heals Party."

    -- Amount healed (HealItem variable)
    self.heal_amounts = {
        ["kris"] = 50,
        ["susie"] = 50,
        ["ralsei"] = 50,
        ["noelle"] = 50,
        ["YOU"] = 50,
		["dess"] = 50,
        ["brandon"] = 50
	}

    -- Default shop price (sell price is halved)
    self.price = 300
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
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
        susie = "Cheesy!",
        ralsei = "Nice to have a new chef!",
        noelle = "This is actually nice...",
		dess = "Bro isn't from Florida",
    }
end

return item