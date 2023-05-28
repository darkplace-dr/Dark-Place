local character, super = Class(PartyMember, "bor")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Bor"

    -- Actor (handles overworld/battle sprites)
    self:setActor("bor")
    self:setLightActor("bor")

    -- Display level (saved to the save file)
    self.level = 69
    -- Default title / class (saved to the save file)
    self.title = "Ball\nIs this... a\nkirby reference?"

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
    self.xact_name = "B-Action"
    
    -- Spells
    self:addSpell("ultimate_shoot")

    -- Current health (saved to the save file)
    self.health = 420

    -- Base stats (saved to the save file)
    self.stats = {
        health = 420,
        attack = 12,
        defense = 8,
        magic = 15
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 500,
        attack = 69,
        magic = 69
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/borgun"

    -- Equipment (saved to the save file)
    self:setWeapon("borgun")
    self:setArmor(1, "jevilstail")
    self:setArmor(2, "dealmaker")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {70/255, 91/255, 231/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {81/255, 104/255, 255/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {81/255, 104/255, 255/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {44, 66/255, 204/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {81/255, 104/255, 255/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/bor/head"
    -- Path to head icons used in battle
    self.head_icons = "party/bor/icon"
    -- Name sprite
    self.name_sprite = "party/bor/name"

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

function character:getGameOverMessage(main)
    return {
        "damn bitch you ded",
        "get up hoe"
    }
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

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)

        love.graphics.print("Cool", x, y, 0, 0.8, 1)
        love.graphics.print("Yeah", x+130, y)

        return true

    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+150, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+170, y+6, 0, 2, 2)
        return true
    end
end

return character