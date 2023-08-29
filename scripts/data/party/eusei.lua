local character, super = Class(PartyMember, "eusei")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Eusei"

    -- Actor (handles sprites)
    self:setActor("eusei")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
	
    self.title = "The Lean Prince\nHis kingdom has lots \nof tech stuff."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = -1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "E-Action"

    -- Spells
    --self:addSpell("sicker")
    --self:addSpell("healing_potion")

    -- Current health (saved to the save file)
    self.health = 90

    -- Base stats (saved to the save file)
    self.stats = {
        health = 100,
        attack = 2,
        defense = 2,
        magic = 2,
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 120
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/scarf"

    -- Equipment (saved to the save file)
    self:setWeapon("red_scarf")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {0, 1, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {0.5, 1, 0.5}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {181/255, 230/255, 29/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {0, 0.5, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {0.5, 1, 0.5}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/eusei/head"

    -- Path to head icons used in battle
    self.head_icons = "party/eusei/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/eusei/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_r"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.15

    -- Battle position offset (optional)
    self.battle_offset = {2, 6}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = {
        "This is not\nyour fate...!",
        "Please,[wait:5]\ndon't give up!"
    }
end

--[[function character:getTitle()
    if Game.chapter == 1 then
        if self:checkWeapon("ragger") then
            return "LV"..self.level.." Prickly Prince\nDeals damage with\nhis rugged scarf."
        elseif self:checkWeapon("daintyscarf") then
            return "LV"..self.level.." Fluffy Prince\nWeak, but has nice\nhealing powers."
        end
    end
    return super.getTitle(self)
end]]

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/nerd")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Nerd:", x, y)
        love.graphics.print("YES", x+70, y, 0, 1.5, 1)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/uwu")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("UWUness:", x, y, 0, 0.8, 1)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/cool")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Cool:", x, y)
        return true
    end
end

return character