local item, super = Class(Item, "ds_hammer")

function item:init()
    super.init(self)

    -- Display name
    self.name = "DS Hammer"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/hammer"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A hammer that has two screens attached to it. Good for Mario Kart."

    -- Default shop price (sell price is halved)
    self.price = 100
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
        attack = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        mario = true,
    }

    -- Character reactions
    self.reactions = {
        mario = {
			mario = "Who beat-a my high score!?",
			brenda = "(Please don't hurt me, but...)"
		},
        noel = "wow... nintendo go supermario nintendo bes company go ninwahooo- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    }
end

function item:convertToLightEquip(inventory)
    return "light/dsi"
end

return item
