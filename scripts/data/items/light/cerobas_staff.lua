local item, super = Class(LightEquipItem, "light/cerobas_staff")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Ceroba's Staff"
    self.short_name = "CerStaff"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 200
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Belongs to Ceroba Ketsukane."

    -- Light world check text
    self.check = "Weapon\nAT 1 MG 2\n* Belongs to Ceroba Ketsukane."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 1,
        magic = 2,
    }

    self.dark_item = "cerobas_staff"

    self.light_bolt_speed = self.light_bolt_speed * 1.25
    self.light_bolt_direction = "random"

end

function item:convertToDarkEquip(chara)
    return "cerobas_staff"
end

function item:showEquipText(target)
    if target.id == "ceroba" then
        Game.world:showText("* Ceroba equipped her staff.")
    elseif target.id == Game.party[1].id then
        Game.world:showText("* You equipped Ceroba's Staff.")
    else
        Game.world:showText("* "..target:getName().." equipped Ceroba's Staff.")
    end
end

function item:getLightBattleText(user, target)
    if target.chara.id == "ceroba" then
        return "* Ceroba equipped her staff."
    elseif target.chara.id == Game.battle.party[1].chara.id then
        return "* You equipped Ceroba's Staff."
    else
        return "* "..target.chara:getName().." equipped Ceroba's Staff."
    end
end

return item