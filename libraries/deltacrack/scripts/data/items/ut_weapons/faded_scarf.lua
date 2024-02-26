local item, super = Class(LightEquipItem, "ut_weapons/faded_scarf")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Faded Scarf"
    self.short_name = "F.Scarf"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Light world check text
    self.check = "Weapon AT 3 DF 3\n* If you're cuter,[wait:10] monsters\nwon't hit you as hard."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 3,
        defense = 3
    }
    
    self.bolt_speed = self.bolt_speed * 1.25
    self.bolt_direction = "random"

    self.attack_style = "deltarune"

    -- Default dark item conversion for this item
    self.dark_item = "red_scarf"
end

function item:showEquipText(target)
    Game.world:showText("* " .. target:getNameOrYou() .." equipped Toy Knife.")
end

function item:getLightBattleText(user, target)
    return "* "..target.chara:getNameOrYou().." equipped Toy Knife."
end


return item