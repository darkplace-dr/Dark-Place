local item, super = Class(HealItem, "chickenteriyaki")

function item:init()
    super.init(self)

    -- Display name
    self.name = "C. Teriyaki"
    -- Name displayed when used in battle (optional)
    self.use_name = "Chicken Teriyaki"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nParty\n60HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Some chicken teriyaki made in a way similar to Ania's. Heals most 60 HP."

    -- Amount this item heals for specific characters
	-- !! This item is specifically for Jamm. Please don't raise your number too much. !!
    self.heal_amounts = {
        ["kris"] = 60,
        ["susie"] = 60,
        ["ralsei"] = 60,
        ["noelle"] = 10,
        ["YOU"] = 60,
        ["dess"] = 60,
        ["brenda"] = 60,
		["jamm"] = 999,
		["mario"] = 10,
        ["pauling"] = 60,
	}

    -- Default shop price (sell price is halved)
    self.price = 600
    -- Whether the item can be sold
    self.can_sell = function()
		if Game:hasPartyMember("jamm") then
			return false
		end
		return true
	end

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
        susie = "It's meat, right? I'll try it.",
        ralsei = "A little thick on the sauce...",
        noelle = "It's JUST the meat???",
		dess = "needs more salt lmao",
		jamm = "I missed this... It's so good!",
		mario = "Blech! That tastes like shit!"
	}
end

-- Function overrides go here

function item:onBattleUse(user, target)
	if target.chara.id == "jamm" then
		target:heal(999, {1, 0, 1})
		target:addShield(45)
	elseif target.chara.id == "noelle" then
		target:heal(10, {1, 0, 1})
	else
		target:heal(60, {1, 0, 1})
	end
end

return item
