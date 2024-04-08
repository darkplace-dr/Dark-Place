local item, super = Class(LightEquipItem, "ut_weapons/toy_knife")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Toy Knife"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Made of plastic.\nA rarity nowadays."

    -- Light world check text
    self.check = "Weapon AT 3\n* Made of plastic.\n* A rarity nowadays."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 3
    }

    self.light_bolt_speed = self.light_bolt_speed * 1.25
    self.light_bolt_direction = "random"

end

function item:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou() .." equipped Toy Knife.")
end

function item:getLightBattleText(user, target)
    -- if user == target then
        -- return "* ".. user.chara:getNameOrYou() .. " equipped " .. self:getUseName() .. "."
    -- else
        -- return "* "..user.chara:getNameOrYou().." gave "..self:getUseName().." to "..target.chara:getNameOrYou(true).." and ".. target.chara:getNameOrYou(true) .. " equipped it."
    -- end
    return "* ".. target.chara:getNameOrYou() .. " equipped " .. self:getUseName() .. "."
end


return item