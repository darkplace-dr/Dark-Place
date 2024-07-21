local character, super = Class(PartyMember, "dess")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Dess"

    -- Actor (handles overworld/battle sprites)
    self:setActor("dess")
    self:setLightActor("dess")
    self:setDarkTransitionActor("kris_dark_transition") -- placeholder

    -- Display level (saved to the save file)
    self.level = 1
    -- Default title / class (saved to the save file)
    self.title = "The Batter\nfrom OFF"

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
    self.xact_name = "D-Action"

    self.lw_portrait = "face/dess/condescending"
	
	-- Spells
	
	-- man idk
	--self:addSpell("wideangle")
	self:addSpell("starshot")

    -- Current health (saved to the save file)
    self.health = 120

    -- Base stats (saved to the save file)
    self.stats = {
        health = 120,
        attack = 12,
        defense = 2,
        magic = 1
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/bat"

    -- Equipment (saved to the save file)
    self:setWeapon("cracked_bat")

    -- Default light world equipment item IDs (saves current equipment)
    --self.lw_weapon_default = "light/pencil"
    --self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 0, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 0, 0}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 128/255, 128/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 0, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 0, 0}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/dess/head"
    -- Path to head icons used in battle
    self.head_icons = "party/dess/icon"
    -- Name sprite
    self.name_sprite = "party/dess/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/bash"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 0.8

    -- Battle position offset (optional)
    self.battle_offset = {2, 1}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = { "You aren't done,\nbuddy.[wait:10] Give em'\nhell!" }
	
	self.frost_resist = true
end

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 10)
    self:increaseStat("attack", 2)
    self:increaseStat("defense", 1)
	self:increaseStat("magic", 1)

    if level == 2 then
		if not Game:getFlag("acj_dess_pacifist") then
			self:addSpell("starstorm")
		else
			self:addSpell("peacelove")
		end
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/angry")
		love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Angy:", x, y)
        love.graphics.print("Lots", x+130, y)
        return true
	elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/bbgum")
		love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Funny:", x, y)
        love.graphics.print("Not", x+130, y)
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

function character:getStarmanTheme() return "dess" end

return character
