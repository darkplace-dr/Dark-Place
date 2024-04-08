local item, super = Class(LightEquipItem, "ut_armors/cloudy_glasses")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Cloudy Glasses"
    self.short_name = "ClodGlass"
    self.serious_name = "Glasses"
    self.use_name = "glasses"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Shop description
    self.shop = "Invincible\nlonger"
    -- Default shop price (sell price is halved)
    self.price = 35
    -- Default shop sell price
    self.sell_price = 50
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Glasses marred with wear."

    -- Light world check text
    self.check = {
        "Weapon DF 6\n* Glasses marred with wear.\n* Increases INV by 9.",
        "* (After you get hurt by an\nattack,[wait:10] you stay invulnerable\nfor longer.)" -- doesn't show up in UT???
    }

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"

    self.inv_bonus = 1

    self.bonuses = {
        defense = 6
    }

end

function item:showEquipText(target)
    Game.world:showText("* "..target:getNameOrYou().." equipped the glasses.")
end

return item