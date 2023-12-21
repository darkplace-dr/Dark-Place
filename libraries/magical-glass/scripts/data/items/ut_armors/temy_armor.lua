local item, super = Class(LightEquipItem, "ut_armors/temy_armor")

function item:init()
    super.init(self)

    -- Display name
    self.name = "temy armor"
    self.short_name = "Temmie AR"
    self.serious_name = "Tem.Armor"
    self.equip_display_name = "Temmie Armor"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 500
    -- Whether the item can be sold
    self.can_sell = true

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
    return "* "..target.chara:getNameOrYou().." donned the Temmie Armor."
end

function item:getPrice()
    local gm = MagicalGlassLib.game_overs
    local price = 9999
    for i = 0, math.min(gm, 30) do
        if i ~= 0 then
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
            elseif i <= 20 then
                price = 1000
            elseif i <= 24 then
                price = 750
            elseif i == 30 then
                price = 500
            end
        end
    end
    return price
end

function item:onTurnEnd(battler)
    if Game.battle.turn_count % 2 == 0 then
        battler:heal(1)
        Assets.stopAndPlaySound("power")
    end
end

return item