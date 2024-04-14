local character, super = Class(PartyMember, "alseri")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Alseri"

    -- Actor (handles sprites)
    self:setActor("alseri")

    -- Display level (saved to the save file)
    self.level = 7
    -- Default title / class (saved to the save file)
    self.title = "Lonely Prince\nDark-World being.\nEmerged in madness."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = -1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = { 1, 0, 0 }

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = false
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "A-Action"

    self.lw_portrait = "face/alseri/neutral"

    -- Spells
    self:addSpell("healing_bless")

    -- Current health (saved to the save file)
    self.health = 200

    -- Base stats (saved to the save file)
    self.stats = {
        health = 200,
        attack = 16,
        defense = 2,
        magic = 9,
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 250
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/scarf"

    -- Equipment (saved to the save file)
    self:setWeapon("tinted_scarf")
    if Game.chapter >= 2 then
        self:setArmor(1, "amber_card")
        self:setArmor(2, "pink_ribbon")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    --[[
    -- Character color (for action box outline and hp bar)
    self.color = { 158/255, 34/255, 43/255 }
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = { 228/255, 70/255, 86/255 }
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = { 181 / 255, 4 / 255, 29 / 255 }
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = { 130/255, 19/255, 28/255 }
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = { 228/255, 70/255, 86/255 }
    ]]
    -- Character color (for action box outline and hp bar)
    self.color = { 1, 0, 59/255 }
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = { 1, 0, 59/255 }
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = { 1, 0, 59/255 }
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = { 160/255, 0, 37/255 }
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = { 1, 0, 59/255 }

    -- Head icon in the equip / power menu
    self.menu_icon = "party/alseri/head"
    -- Path to head icons used in battle
    self.head_icons = "party/alseri/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/alseri/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_r"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.15

    -- Battle position offset (optional)
    self.battle_offset = { 2, 6 }
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = {
        "This is not\nyour fate...!",
        "Please,[wait:5]\ndon't give up!"
    }
    
    -- Character flags (saved to the save file)
    self.flags = {
        ["guts"] = 0,
    }
end

function character:getTitle()
    if Game.chapter == 1 then
        if self:checkWeapon("ragger") then
            return "LV" .. self.level .. " Prickly Prince\nDeals damage with\nhis rugged scarf."
        elseif self:checkWeapon("daintyscarf") then
            return "LV" .. self.level .. " Fluffy Prince\nWeak, but has nice\nhealing powers."
        end
    end
    return super.getTitle(self)
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:onPowerSelect(menu)
    if Utils.random() <= 0.03 then
        menu.ralsei_dog = true
    else
        menu.ralsei_dog = false
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        -- Chapter 1 Ralsei "Kindness" stat (doggable)
        if not menu.ralsei_dog then
            local icon = Assets.getTexture("ui/menu/icon/exclamation")
            love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
            love.graphics.print("Boldness", x, y)
            love.graphics.print("100", x + 130, y)
        else
            local icon = Assets.getTexture("ui/menu/icon/smile_dog")
            love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
            love.graphics.print("Dogness", x, y)
            love.graphics.print("69", x + 130, y)
        end
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/fluff")
        love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
        love.graphics.print("Fluffiness", x, y, 0, 0.8, 1)

        love.graphics.draw(icon, x + 130, y + 6, 0, 2, 2)
        if Game.chapter >= 2 then
            --love.graphics.draw(icon, x + 150, y + 6, 0, 2, 2)
        end
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        if self:getFlag("guts", df) == 0 then
            love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+150, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+170, y+6, 0, 2, 2)
        elseif self:getFlag("guts", df) == 1 then
            love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+150, y+6, 0, 2, 2)
        elseif self:getFlag("guts", df) == 2 then
            love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+150, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+170, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+190, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+210, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+230, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+250, y+6, 0, 2, 2)
        else
            love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+150, y+6, 0, 2, 2)
            love.graphics.draw(icon, x+170, y+6, 0, 2, 2)
        end

        
        return true
    end
end

return character
