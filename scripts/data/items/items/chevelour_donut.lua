-- Instead of Item, create a HealItem, a convenien  t class for consumable healing items
local item, super = Class(HealItem, "chevelour_donut")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ChevelourDonut"
    -- Name displayed when used in battle (optional)
    self.use_name = "CHEVELOUR DONUT"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nVaries"
    -- Shop description
    self.shop = "100% Red Velvet\nFlavor!"
    -- Menu description
    self.description = "A donut shaped like Chevelour's face.\nIt's just a bagel with jam inside. Heals +??HP"

    -- Amount healed (HealItem variable)
    self.heal_amounts = {
        ["kris"] = 80,
        ["susie"] = 20,
        ["ralsei"] = 100,
        ["noelle"] = 250,
        ["YOU"] = 80,
		["dess"] = 60,
        ["brandon"] = 80
	}

    -- Default shop price (sell price is halved)
    self.price = 80
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
        susie = "It's just a jam sandiwch...",
        ralsei = "I never knew Chevelour can bake well!",
        noelle = "The jam's taste reminds me of new year's eve...!",
		dess = "Should've been hollyberry...",
        brandon = "Creamy!"
    }
end

return item