local item, super = Class(Item, "ut_items/punch_card")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Punch Card"
    self.short_name = "PunchCard"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 15
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Used to make punching attacks stronger for one battle."

    -- Light world check text
    self.check = {
        "Battle Item\n* Used to make punching attacks\nstronger for one battle.",
        "* Use outside of battle\nto look at the card."
    }

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:getATIncrease(target)
    local at = 6
    if target.chara:getStat("attack") > 18 then
        at = 5
    elseif target.chara:getStat("attack") > 23 then
        at = 4
    elseif target.chara:getStat("attack") > 26 then
        at = 3
    elseif target.chara:getStat("attack") > 28 then
        at = 2
    end
    return at
end

function item:onWorldUse(target)
    Game.world:closeMenu()
    Game.world.timer:after(1/30, function()
        Game.world:openMenu(ImageViewer("world/punchcard"))
    end)
    return false
end

function item:getLightBattleText(user, target)
    if Utils.containsValue(target.chara:getWeapon().tags, "punch") then
        if target.chara.id == Game.battle.party[1].chara.id then
            return {
                "* OOOORAAAAA!!![wait:10]\n* You rip up the punch card!",
                "* Your hands are burning![wait:10]\n* AT increased by "..self:getATIncrease(target).."!"
            }
        else
            return {
                "* OOOORAAAAA!!![wait:10]\n* "..target.chara:getName().." rips up the punch card!",
                "* "..target.chara:getName().."'s hands are burning![wait:10]\n* AT increased by "..self:getATIncrease(target).."!"
            }
        end
    else
        if target.chara.id == Game.battle.party[1].chara.id then
            return {
                "* OOOORAAAAA!!![wait:10]\n* You rip up the punch card!",
                "* But nothing happened."
            }
        else
            return {
                "* OOOORAAAAA!!![wait:10]\n* "..target.chara:getName().." rips up the punch card!",
                "* But nothing happened."
            }
        end
    end
end

function item:getBattleText(user, target)
    return item:getLightBattleText(user, target)
end

function item:onLightBattleUse(user, target)
    if Utils.containsValue(target.chara:getWeapon().tags, "punch") then
        Assets.playSound("tearcard")
        target.chara:addStatBuff("attack", self:getATIncrease(target))
    end
    Game.battle:battleText(self:getLightBattleText(user, target))
    return true
end

function item:onBattleUse(user, target)
    if Utils.containsValue(target.chara:getWeapon().tags, "punch") then
        Assets.playSound("tearcard")
        target.chara:addStatBuff("attack", self:getATIncrease(target))
    end
    return true
end

return item