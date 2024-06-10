local item, super = Class(LightEquipItem, "light/gamecube_controller")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Gamecube Cont."

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 150

    -- Item description text (unused by light items outside of debug menu)
    self.description = "An old remote to an old console."

    -- Light world check text
    self.check = "Weapon AT 6\n* An old remote to an\nold console."

    self.bonuses = {
        attack = 6
    }

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
end

function item:convertToDarkEquip(chara)
    return "wiimote"
end

return item