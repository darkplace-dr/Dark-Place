local item, super = Class(LightEquipItem, "ut_armors/the_locket")

function item:init()
    super.init(self)

    -- Display name
    self.name = "The Locket"
    self.short_name = "TheLocket"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 500
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "You can feel it beating."

    -- Light world check text
    self.check = "Armor DF 99\n* You can feel it beating."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 99
    }

end

function item:showEquipText()
    Game.world:showText("* Right where it belongs.")
end

function item:getLightBattleText(user, target)
    -- if user == target then
        -- return "* Right where it belongs."
    -- else
        -- return "* "..user.chara:getNameOrYou().." gave the "..self:getUseName().." to "..target.chara:getNameOrYou(true)..".\n* Right where it belongs."
    -- end
    return "* Right where it belongs."
end

function item:getBattleText(user, target)
    if user == target then
        return "* Right where it belongs."
    else
        return "* "..user.chara:getName().." gave the "..self:getUseName().." to "..target.chara:getName()..".\n* Right where it belongs."
    end
end

return item