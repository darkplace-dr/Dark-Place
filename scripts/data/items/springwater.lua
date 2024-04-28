-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "springwater")

function item:init()
    super.init(self)

    -- Display name
    self.name = "SpringWater"
    -- Name displayed when used in battle (optional)
    self.use_name = "S.WATER"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Hydrate\n+20% HP"
    -- Shop description
    self.shop = "Stay hydrated.\n+20% HP."
    -- Menu description
    self.description = "Remember to stay hydrated.\n+20% HP"
	
	-- Check Text
	--self.check = "GAMERBLOOD AMPED :TM: AMPED PUT ALL YOUR EGGS IN THIS BASKET AMPED.\nDon't drink this in the light world or else the game will crash."

	--self.onCheck = function()
		
		--Game.world:showText({'"GamerBloodTM" - GAMERBLOOD AMPED :TM: AMPED PUT ALL YOUR EGGS IN THIS BASKET AMPED.', "Don't drink this in the light world or else the game will crash."})
		
	--end

    -- Amount healed (HealItem variable)
    --self.heal_amount = 65

    -- Default shop price (sell price is halved)
    self.price = 150
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
        susie = "Stay Hydrated!",
        ralsei = "Stay Hydrated!",
        noelle = "Stay Hydrated!",
        brenda = "(I should probably drink more water...)",
		jamm = "r/hydrohomies",
    }
	
	--self.light_item = "light/gamerblood"
end

function item:getHealAmount(id)

	local percenthealth = math.ceil(Game:getPartyMember(id):getStat("health", 1500) / 5)
	
	return percenthealth
end




return item