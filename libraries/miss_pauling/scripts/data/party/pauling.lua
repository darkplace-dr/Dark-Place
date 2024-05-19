local character, super = Class(PartyMember, "pauling")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Pauling"

    -- Actor (handles overworld/battle sprites)
    self:setActor("pauling")
    self:setLightActor("pauling")
    self:setDarkTransitionActor("pauling_dark_transition")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Employer\nHires her foes or\nshoots them."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {165/255, 86/255, 33/255}
	self.heart_sprite = "player/heart_pauling"

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = false

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "P-Action"

    -- Current health (saved to the save file)
    self.health = 90

    -- Base stats (saved to the save file)
    self.stats = {
        health = 90,
        attack = 13,
        defense = 3,
        magic = 0
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 120
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/pistol"

    -- Equipment (saved to the save file)
    self:setWeapon("derringer")
    if Game.chapter >= 2 then
        self:setArmor(1, "amber_card")
        self:setArmor(2, "amber_card")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {104/255, 51/255, 85/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {104/255, 51/255, 85/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {104/255, 51/255, 85/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {104/255, 51/255, 85/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {104/255, 51/255, 85/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/pauling/head"
    -- Path to head icons used in battle
    self.head_icons = "party/pauling/icon"
    -- Name sprite
    self.name_sprite = "party/pauling/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/gun"
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
        Draw.draw(frames[frame], x+120, y+5, 0, 2, 2)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        Draw.draw(icon, x+90, y+6, 0, 2, 2)
        if Game.chapter >= 2 then
            Draw.draw(icon, x+110, y+6, 0, 2, 2)
        end
        return true
    end
end

return character