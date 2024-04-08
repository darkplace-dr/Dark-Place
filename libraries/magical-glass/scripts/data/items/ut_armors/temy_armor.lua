local item, super = Class(LightEquipItem, "ut_armors/temy_armor")

function item:init()
    super.init(self)

    -- Display name
    self.name = "temy armor"
    self.short_name = "Temmie AR"
    self.serious_name = "Tem.Armor"
    self.equip_display_name = "Temmie Armor"
    self.use_name = "Temmie Armor"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Shop description
    self.shop = "ARMOR 20DF\nmakes\nbattles\ntoo easy"
    self.shop_dont_show_change = true
    -- Default shop sell price
    self.sell_price = 500
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "The things you can do with a college education!"

    -- Light world check text
    self.check = {
        "Armor DF 20\n* The things you can do with\na college education!",
        "* Raises ATTACK when worn.\n* Recovers HP every other turn.\n* INV up slightly."
    }

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.inv_bonus = 15/30

    self.bonuses = {
        defense = 20,
        attack = 10
    }

end

function item:showEquipText(target)
    Game.world:showText("* "..target:getNameOrYou().." donned the Temmie Armor.")
end

function item:getLightBattleText(user, target)
    -- if user == target then
        -- return "* "..user.chara:getNameOrYou().." donned the "..self:getUseName().."."
    -- else
        -- return "* "..user.chara:getNameOrYou().." gave the "..self:getUseName().." to "..target.chara:getNameOrYou(true).." and "..user.chara:getNameOrYou(true).." donned it."
    -- end
    return "* "..target.chara:getNameOrYou().." donned the "..self:getUseName().."."
end

function item:getPrice()
    local price = 9999
    for i = 1, math.min(MagicalGlassLib.game_overs, 30) do
        if i == 1 then
            price = price - 999
        elseif i <= 5 then
            price = price - 1000
        elseif i <= 9 then
            price = price - 500
        elseif i <= 17 then
            price = price - 200
        elseif i <= 19 then
            price = price - 150
        end
        if i >= 20 then
            price = 1000
        end
        if i >= 25 then
            price = 750
        end
        if i >= 30 then
            price = 500
        end
    end
    return price
end

function item:onTurnEnd(battler)
    if Game.battle.turn_count % 2 == 0 then
        battler:heal(1)
        if Game.battle.light then
            Assets.stopAndPlaySound("power")
        end
    end
end

return item