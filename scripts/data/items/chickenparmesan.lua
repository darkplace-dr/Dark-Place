local item, super = Class(HealItem, "chickenparmesan")

function item:init()
    super.init(self)

    -- Display name
    self.name = "C. Parmesan"
    -- Name displayed when used in battle (optional)
    self.use_name = "Chicken Parmesan"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nParty\n60HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Some chicken parmesan made and prepared by Willow. Heals party 60HP"

    -- Amount this item heals for specific characters
    self.heal_amounts = {
        ["kris"] = 60,
        ["susie"] = 60,
        ["ralsei"] = 60,
        ["noelle"] = 10,
        ["YOU"] = 60,
        ["dess"] = 60,
        ["brandon"] = 250,
		["jamm"] = 100,
		["mario"] = 10,
	}

    -- Default shop price (sell price is halved)
    self.price = 600
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Tastes great!",
        ralsei = "Oh, this tastes good!",
        noelle = "I... don't eat meat.",
		dess = "should of deep fried it lmao",
        brandon = "Made exactly how I like it!",
		jamm = "I haven't had one of these since my college days. Tuesday, specifically.",
		mario = "Can I have some spaghetti now?"
	}
end

-- Function overrides go here

return item
