local item, super = Class(Item, "wiimote")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Wiimote"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A remote for a game console. It seems to be motion-related."

    -- Default shop price (sell price is halved)
    self.price = 500
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
        attack = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
		-- Slingshot
        jamm = true,
		
		-- Gun
        brenda = true,
        pauling = true,
		
		-- Sword
        YOU = true,
        kris = true,
		
		-- Bat
        dess = true,
    }

    -- Character reactions
    self.reactions = {
		jamm = "Oh, sweet! I remember this!",
		dess = {
			dess = "oh sick",
			jamm = "The wrist strap! Use the wrist strap!",
			noel = "It's not like it's a weapon or anything."
		},
	        noel = "... It's like the ads now...",
	}
end

function item:convertToLightEquip(inventory)
    return "light/gamecube_controller"
end

function item:onEquip(character, replacement)
    character:addSpell("grab")
    return true
end

function item:onUnequip(character, replacement)
    character:removeSpell("grab")
    return true
end

return item