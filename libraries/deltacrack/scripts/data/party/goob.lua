local character, super = Class(PartyMember, "goob")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Goob"

    --self.lw_portrait = "face/frisk/neutral"
    
    -- Actor (handles overworld/battle sprites)
    self:setActor("goob")
    self:setLightActor("goob_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    if Game.chapter == 1 then
        self.title = "Grimace Shaker\n   Fuckin'\n   nerd."
        --self.title = "Fucker\n   Fuckin'\n   nerd"
    else 
        self.title = "War Criminal\nSaga of Goob\nthe evil"
    end

    -- Light world LV (saved to the save file)
    self.lw_lv = 1
    -- Light world EXP (saved to the save file)
    self.lw_exp = 0

    -- Current health (saved to the save file)
    self.health = 90
    -- Current light world health (saved to the save file)
    self.lw_health = 20
    -- Light world stats (saved to the save file)
    self.lw_stats = {
        health = 20,
        attack = 10,
        defense = 10,
        magic = 0
    }

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
    self.xact_name = "G-Fuel"

    -- Current health (saved to the save file)
    if Game.chapter == 1 then
        self.health = 90
    else
        self.health = 120
    end

    -- Base stats (saved to the save file)
    if Game.chapter == 1 then
        self.stats = {
            health = 90,
            attack = 10,
            defense = 2,
            magic = 0
        }
    else
        self.stats = {
            health = 120,
            attack = 12,
            defense = 2,
            magic = 0
        }
    end
    -- Max stats from level-ups
    if Game.chapter == 1 then
        self.max_stats = {
            health = 120
        }
    else
        self.max_stats = {
            health = 160
        }
    end

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/sword"

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "ut_weapons/stick"
    self.lw_armor_default = "ut_armors/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {155/255, 43/255, 216/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {187/255, 71/255, 1}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {155/255, 43/255, 216/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {109/255, 26/255, 158/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {187/255, 71/255, 1}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/goob/head"
    -- Path to head icons used in battle
    self.head_icons = "party/goob/icon"
    -- Name sprite
    self.name_sprite = "party/goob/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slash"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = {-2, -1}
    -- Head icon position offset (optional)
    self.head_icon_offset = {-1, -5}
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil

    self:setFlag("has_skills", true)
	self:setFlag("has_mercy", true)
end

function character:drawPowerStat(index, x, y, menu)
    if index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
        return true
    end
end

function character:getTitle()

    --[[
    if Game:getFlag("##totalkills", 0) < 12 then
        self.title = "Sage\nFallen with a\nlost purpose."
    else
        self.title = "Vessel\nNo more than\nan empty shell."
    end
    ]]

    return "LV"..self:getLevel().." "..self.title
end

return character