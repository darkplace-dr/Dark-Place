-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "makissyringe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Syringe"
    -- Name displayed when used in battle (optional)
    self.use_name = "SYRINGE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Unknown\nliquid.\n+???"
    -- Shop description
    self.shop = "Not sure what's\ninside\nCause varied\neffects."
    -- Menu description
    self.description = "A syringe with a unknown liquid inside. Apparently made by a nurse. Varied effects."

    -- Amount healed (HealItem variable)
    self.heal_amount = 10

    -- Default shop price (sell price is halved)
    self.price = 150
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "syringe"
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}
end

-- Yes, that's surely an item you wouldn't want to use. Deal with it :spamtroll:
function item:onWorldUse(target)
    local effect = love.math.random(1, 100)
    local is_leader = Game.party[1].id == target.id
    local yourself = (is_leader and "yourself" or target.name)
    local feel = (is_leader and "You feel" or target.name.." feels")
    local your = (is_leader and "your" or target.name.."'s")
    local dont = (is_leader and "You don't" or target.name.." doesn't")
    local defense = (target.ribbit and " placebos" or " defense")
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* (You inject "..yourself.." with the content of the syringe...)")
        cutscene:text("[noskip]*[speed:0.1] (...)")
        if effect < 10 then
            Assets.playSound("hurt")
            cutscene:text("* (Oh no!! That's poison!!)")
            local poison_left = 60
            target.poison_effect_timer = Game.world.timer:every(1, function()
                if not Game.world.cutscene then -- Don't hurt anyone during a cutscene
                    if poison_left == 0 then
                        Game.world:showText("* ("..feel.." better now.)")
                        return false
                    end
                    local char_health = target:getHealth()
                    if char_health > 1 then
                        Assets.playSound("hurt")
                        target:setHealth(char_health - 1)
                        poison_left = poison_left - 1
                    else
                        poison_left = 0
                        Game.world:showText("* ("..feel.." dead inside now.)")
                        return false
                    end
                end
            end)
        elseif effect >= 10 and effect < 30 then
            cutscene:text("* (Looks like "..your..defense.." decreased...\nTemporarely.)")
            target:increaseStat("defense", -10)
            target.defense_effect_timer = Game.world.timer:after(300, function()
                Assets.playSound("boost")
                target:increaseStat("defense", 10)
                if not Game.world.cutscene then
                    Game.world:showText("* ("..feel.." better now.)")
                end
            end)
        elseif effect >= 30 and effect < 50 then
            target:heal(-5, false)
            Assets.playSound("hurt")
            cutscene:text("* (Ow. It's a damage potion!)")
        elseif effect == 50 then
            cutscene:text("* ("..dont.." feel better, nor worse.)")
        elseif effect > 50 and effect < 70 then
            target:heal(1)
            cutscene:text("* (It healed... 1HP?)")
        elseif effect >= 70 and effect < 90 then
            cutscene:text("* (Looks like "..your..defense.." increased...\nTemporarely.)")
            target:increaseStat("defense", 10)
            target.defense_effect_timer = Game.world.timer:after(300, function()
                Assets.playSound("boost")
                target:increaseStat("defense", -10)
                if not Game.world.cutscene then
                    Game.world:showText("* ("..feel.." normal again.)")
                end
            end)
        elseif effect >= 90 then
            target:heal(target:getStat("max_health"))
            cutscene:text("* (A perfect 100!)")
        end
        cutscene:text("* (And now, you have an empty syringe.)")
    end)
end

function item:onBattleUse(user, target)
    if love.math.random(0, 1) == 1 then
        target:heal(target.chara.stats["health"] / 2)
    else
        target:hurt(target.chara.stats["health"] / 2, true)
    end
end

function Item:getBattleText(user, target)
    return "* "..user.chara:getName().." administered the "..self:getUseName().."!"
end

return item
