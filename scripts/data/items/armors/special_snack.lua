local item, super = Class(Item, "special_snack")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Spcl.Snack"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "'Nanner."
    -- Menu description
    self.description = "Probably a reference to something\nSomething very good."

    -- Default shop price (sell price is halved)
    self.price = 0
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
        defense = 1,
		
		-- This is a reference to how the accessory
		-- works in Undertale 2: Revenge of the Robots
		-- and how it applies secret and really good effects
		
		-- You should play that game btw
		graze_tp = 0.2,
		graze_time = 0.2,
		graze_size = 0.2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "???"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        susie = "Saving this for later.",
        ralsei = "Potassium!",
        noelle = "It's a healthy snack!",
		dess = "Play Undertale 2 Revenge of the Robots",
        brenda = "Don't mind if I do.",
		jamm = "Wait. I'm *not* supposed to eat it? Okay then.",
        noel = "I wear the banana???",
    }
end

return item