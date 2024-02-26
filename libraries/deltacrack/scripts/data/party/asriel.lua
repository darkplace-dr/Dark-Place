local character, super = Class(PartyMember, "asriel")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Asriel"

    -- Actor (handles sprites)
    self:setActor("asriel")
    self:setLightActor("asriel_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "G.O.A.T.\nBoom! Pow! Fire\npower, go!"

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = false
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "An-Action"

    -- Spells
    self:addSpell("heal_prayer")
    self:addSpell("fireshock")

    -- Current health (saved to the save file)
    self.health = 100

    -- Base stats (saved to the save file)
    self.stats = {
        health = 100,
        attack = 12,
        defense = 2,
        magic = 15
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 100
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/fire"

    -- Equipment (saved to the save file)
    self:setWeapon("heatcollar")
    self:setArmor(1, "darkcloak")
    self:setArmor(2, "silver_watch")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/wristwatch"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 147/255, 82/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 162/255, 109/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 147/255, 82/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {204/255, 65/255, 30/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 147/255, 82/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/asriel/head"
    -- Path to head icons used in battle
    self.head_icons = "party/asriel/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/asriel/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/fire"
    -- Sound played when this character attacks
    self.attack_sound = "rumble"
    -- Pitch of the attack sound
    self.attack_pitch = 1.5

    -- Battle position offset (optional)
    self.battle_offset = {0, 0}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil

    -- Character flags (saved to the save file)
    self.flags = {
        ["fireshocks_used"] = 0
    }
    
	self:setFlag("has_mercy", true)
end

function character:getTitle()
    if self:checkWeapon("arcticflame") then
        return "LV"..self.level.." Pyromancer\nInflicts fatal damage\nusing fire magic."
    elseif self:getFlag("fireshocks_used", 0) > 0 then
        return "LV"..self.level.." Flamecaster\nVaporizes the enemy."
    else
        return "LV"..self.level.. " " ..self.title
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/smile")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Coolness", x, y, 0, 0.8, 1)
        love.graphics.print("100", x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        Draw.draw(icon, x+90, y+6, 0, 2, 2)
        Draw.draw(icon, x+110, y+6, 0, 2, 2)
        Draw.draw(icon, x+130, y+6, 0, 2, 2)
        return true
    end
end

return character