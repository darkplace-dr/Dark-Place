local character, super = Class(PartyMember, "YOU")

function character:init()
    super.init(self)

    -- Display name
    self.name = "YOU"

    -- Actor (handles overworld/battle sprites)
    self:setActor("you")
    self:setLightActor("you_lw")

    -- Display level (saved to the save file)
    self.level = 1
    -- Default title / class (saved to the save file)
    self.title = "Frog\nPotential heros.\nThe pression's on!"

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 2
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = false

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "Y-Action"

    -- Current health (saved to the save file)
    self.health = 90

    -- Base stats (saved to the save file)
    self.stats = {
        health = 90,
        attack = 10,
        defense = 2,
        magic = 0
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 120
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/sword"

    -- Equipment (saved to the save file)
    self:setWeapon("wood_blade")
    if Game.chapter >= 2 then
        self:setArmor(1, "amber_card")
        self:setArmor(2, "amber_card")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {0, 1, 1}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {0.5, 1, 1}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {0, 162/255, 232/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {0, 0, 1}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {0.5, 1, 1}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/you/head"
    -- Path to head icons used in battle
    self.head_icons = "party/you/icon"
    -- Name sprite
    self.name_sprite = "party/you/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = {2, 1}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end

function character:levelUp()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("defense", 2)
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

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:onPowerSelect(menu)
    if Utils.random() < ((Game.chapter == 1) and 0.02 or 0.04) then
        menu.kris_dog = true
    else
        menu.kris_dog = false
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 and menu.kris_dog then
        local frames = Assets.getFrames("misc/dog_sleep")
        local frame = math.floor(Kristal.getTime()) % #frames + 1
        love.graphics.print("Dog:", x, y)
        love.graphics.draw(frames[frame], x+120, y+5, 0, 2, 2)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        if Game.chapter >= 2 then
            love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        end
        return true
    end
end

return character