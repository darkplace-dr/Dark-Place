local item, super = Class(HealItem, "mediumpizza")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Medium Pizza"
    -- Name displayed when used in battle (optional)
    self.use_name = "Medium Pizza"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n30HP"
    -- Shop description
    self.shop = "Medium-sized\npizza.\nHeals 30HP."
    -- Menu description
    self.description = "A medium-sized pizza made by Fazbear Entertainment. Heals 30HP."

    -- Amount this item heals for specific characters
    self.heal_amounts = {
        ["kris"] = 30,
        ["susie"] = 30,
        ["ralsei"] = 30,
        ["noelle"] = 30,
        ["YOU"] = 30,
        ["dess"] = 25,
        ["brenda"] = 30,
		["jamm"] = nil,
	}

    -- Default shop price (sell price is halved)
    self.price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "The sauce tastes like blood!",
        ralsei = "Isn't this just plastic?",
        noelle = "Not the best, but it's fine.",
		dess = "ew fnaf",
        brenda = "WAS THAT THE BITE OF 87?!",
		jamm = "Hold on. There are mushrooms."
	}
end

-- Function overrides go here

return item