local item, super = Class(Item, "oblitersling")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Obliterling"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sling"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A slingshot for those who have completely given up on peace."

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = false

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
        attack = 8,
        defense = -14,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Regret"
    self.bonus_icon = "sword"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        jamm = true,
    }

    -- Character reactions
	-- !! NOTE: Jamm should be the only one to have a reaction to this weapon. !!
    self.reactions = {
        jamm = "..."
    }
end

function item:convertToLightEquip(inventory)
    return "light/chain_sling"
end

return item