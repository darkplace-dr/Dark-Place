local character, super = Class(PartyMember, "susie")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Susie"

    -- Actor (handles sprites)
    self:setActor("susie")
    self:setLightActor("susie_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Dark Knight\nDoes damage using\ndark energy."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "S-Action"

    -- Spells
    self:addSpell("rude_buster")
    self:addSpell("pacify")
    if Game.chapter >= 2 then
        self:addSpell("ultimate_heal")
    end

    -- Current health (saved to the save file)
    if Game.chapter == 1 then
        self.health = 110
    else
        self.health = 140
    end

    -- Base stats (saved to the save file)
    if Game.chapter == 1 then
        self.stats = {
            health = 110,
            attack = 14,
            defense = 2,
            magic = 1
        }
    else
        self.stats = {
            health = 140,
            attack = 16,
            defense = 2,
            magic = 1
        }
    end

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/axe"

    -- Equipment (saved to the save file)
    self:setWeapon("mane_ax")
    if Game.chapter >= 2 then
        self:setArmor(1, "amber_card")
        self:setArmor(2, "amber_card")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 0, 1}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {0.8, 0.6, 0.8}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {234/255, 121/255, 200/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {0.5, 0, 0.5}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 0.5, 1}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/susie/head"
    -- Path to head icons used in battle
    self.head_icons = "party/susie/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/susie/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/mash"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 0.9

    -- Battle position offset (optional)
    self.battle_offset = {3, 1}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil -- Handled by getGameOverMessage for Susie

    -- Character flags (saved to the save file)
    self.flags = {
        ["auto_attack"] = false,
    }
end

function character:levelUp()
    self:increaseStat("health", 15)
    self:increaseStat("attack", 2)
    self:increaseStat("magic", 1)
    self:increaseStat("defense", 1)
    self.love = self.love + 1
    if self.love == 1 then
        self.req_exp = 10
    elseif self.love == 2 then
        self.req_exp = 30
    elseif self.love == 3 then
        self.req_exp = 70
    elseif self.love == 4 then
        self.req_exp = 120
    elseif self.love == 5 then
        self.req_exp = 200
    elseif self.love == 6 then
        self.req_exp = 300
    elseif self.love == 7 then
        self.req_exp = 500
    elseif self.love == 8 then
        self.req_exp = 800
    elseif self.love == 9 then
        self.req_exp = 1200
    elseif self.love == 10 then
        self.req_exp = 1700
    elseif self.love == 11 then
        self.req_exp = 2500
    elseif self.love == 12 then
        self.req_exp = 3500
    elseif self.love == 13 then
        self.req_exp = 5000
    elseif self.love == 14 then
        self.req_exp = 7000
    elseif self.love == 15 then
        self.req_exp = 10000
    elseif self.love == 16 then
        self.req_exp = 15000
    elseif self.love == 17 then
        self.req_exp = 25000
    elseif self.love == 18 then
        self.req_exp = 50000
    elseif self.love == 19 then
        self.req_exp = 99999
    elseif self.love == 20 then
        self.req_exp = 0
    end
end

function character:onTurnStart(battler)
    if self:getFlag("auto_attack", false) then
        Game.battle:pushForcedAction(battler, "AUTOATTACK", Game.battle:getActiveEnemies()[1], nil, {points = 150})
    end
end

function character:onAttackHit(enemy, damage)
    if damage > 0 then
        Assets.playSound("impact", 0.8)
        Game.battle:shakeCamera(4)
    end
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 2 == 0 then
        self:increaseStat("health", 1)
    end
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:getGameOverMessage(main)
    return {
        "Come on,[wait:5]\nthat all you got!?",
        main.name..",[wait:5]\nget up...!"
    }
end

function character:canEquip(item, slot_type, slot_index)
    if item then
        return super.canEquip(self, item, slot_type, slot_index)
    else
        local item
        if slot_type == "weapon" then
            item = self:getWeapon()
        elseif slot_type == "armor" then
            item = self:getArmor(slot_index)
        else
            return true
        end
        return false
    end
end

function character:getReaction(item, user)
    if item or user.id ~= self.id then
        return super.getReaction(self, item, user)
    else
        return "Hey, hands off!"
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Rudeness", x, y)
        if Game.chapter == 1 then
            love.graphics.print("99", x+130, y)
        else
            love.graphics.print("89", x+130, y)
        end
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        if Game.chapter == 1 then
            love.graphics.print("Crudeness", x, y, 0, 0.8, 1)
            love.graphics.print("100", x+130, y)
        else
            love.graphics.print("Purple", x, y, 0, 0.8, 1)
            love.graphics.print("Yes", x+130, y)
        end
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        return true
    end
end

return character