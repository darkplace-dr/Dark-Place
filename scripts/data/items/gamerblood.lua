-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "gamerblood")

function item:init()
    super.init(self)

    -- Display name
    self.name = "GamerBloodTM"
    -- Name displayed when used in battle (optional)
    self.use_name = "GAMER BLOOD (TM)"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Energy\no_e"
    -- Shop description
    self.shop = "Energy\nFlavored"
    -- Menu description
    self.description = "YEAH BAYBE YEAH GAMING\nTASTE THE POWER +9999HP"
	
	-- Check Text
	--self.check = "GAMERBLOOD AMPED :TM: AMPED PUT ALL YOUR EGGS IN THIS BASKET AMPED.\nDon't drink this in the light world or else the game will crash."

	self.onCheck = function()
		
		Game.world:showText({'"GamerBloodTM" - GAMERBLOOD AMPED :TM: AMPED PUT ALL YOUR EGGS IN THIS BASKET AMPED.', "Don't drink this in the light world or else the game will crash."})
		
	end

    -- Amount healed (HealItem variable)
    self.heal_amount = 9999

    -- Default shop price (sell price is halved)
    self.price = 1337
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
        susie = "Hell yeah.",
        ralsei = "This tastes like green...?",
        noelle = "How does Berdly drink these?",
        brenda = "I can just taste the heart disease.",
		jamm = "*cough* My throat... *cough*"
    }
	
	self.light_item = "light/gamerblood"
end

return item