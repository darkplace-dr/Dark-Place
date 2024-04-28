local item, super = Class(HealItem, "spaghetti")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Spaghetti"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nParty\n???HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A plate of spaghetti. It smells terrible. Maybe someone will like it?"

    -- Amount this item heals for specific characters
	-- !! This item is specifically for Jamm. Please don't raise your number too much. !!
    self.heal_amounts = {
        ["kris"] = 0,
        ["susie"] = 0,
        ["ralsei"] = 0,
        ["noelle"] = 0,
        ["YOU"] = 0,
        ["dess"] = 0,
        ["brenda"] = 0,
		["jamm"] = 0,
		["mario"] = 999,
        ["pauling"] = 0,
	}

    -- Default shop price (sell price is halved)
    self.price = 100

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
        susie = "What the HELL is this!?",
        ralsei = "That didn't taste so good...",
        noelle = "M-medic...!",
		dess = "who taught that guy how to cook?",
		jamm = "I finally understand Gordon Ramsay...",
		mario = "That's-a so nice!"
	}
end

-- Function overrides go here

function item:onBattleUse(user, target)
	if target.chara.id == "mario" then
		target:heal(999)
	else
		target:hurt(999)
	end
end

return item
