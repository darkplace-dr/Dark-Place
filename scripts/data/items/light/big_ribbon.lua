local item, super = Class(LightEquipItem, "light/big_ribbon")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Big Ribbon"
    self.short_name = "BigRibbn"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Made from high quality materials."

    -- Light world check text
    self.check = "Armor 7 DF\n* Made from high quality\nmaterials."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 0,
        defense = 7
    }

    -- Default dark item conversion for this item
    self.dark_item = "hair_ribbon"
end

function item:convertToDarkEquip(chara)
    return "hair_ribbon"
end

function item:showEquipText(target)
    if target.id == "ceroba" then
        Game.world:showText("* Ceroba equipped her ribbon.")
    elseif target.id == Game.party[1].id then
        Game.world:showText("* You equipped Big Ribbon.")
    else
        Game.world:showText("* "..target:getName().." equipped Big Ribbon.")
    end
end

function item:getLightBattleText(user, target)
    if target.chara.id == "ceroba" then
        return "* Ceroba equipped her ribbon."
    elseif target.chara.id == Game.battle.party[1].chara.id then
        return "* You equipped Big Ribbon."
    else
        return "* "..target.chara:getName().." equipped Big Ribbon."
    end
end

return item