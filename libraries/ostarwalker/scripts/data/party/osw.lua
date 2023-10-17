local character, super = Class(PartyMember, "ostarwalker")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Starwalker"

    -- Actor (handles overworld/battle sprites)
    self:setActor("ostarwalker")
    -- Light World Actor (handles overworld/battle sprites in light world maps) (optional)
    -- No need for it here

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Star\nThe original."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {248/255, 248/255, 250/255}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "O-Action"

    -- Spells

    self:addSpell("heal_prayer")
    self:addSpell("shooting_star")

    -- Current health (saved to the save file)
    self.health = 140

    -- Base stats (saved to the save file)
    self.stats = {
        health = 140,
        attack = 7,
        defense = 2,
        magic = 13
    }
	
    -- Max stats from level-ups
    self.max_stats = {
        health = 180
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/star"

    -- Equipment (saved to the save file)
    self:setWeapon("gold_bell")
    self:setArmor(1, nil)
    self:setArmor(2, nil)

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {248/255, 248/255, 250/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = nil
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = nil
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = nil
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = nil

    -- Head icon in the equip / power menu
    self.menu_icon = "party/ostarwalker/head"
    -- Path to head icons used in battle
    self.head_icons = "party/ostarwalker/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/ostarwalker/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_n"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = nil
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
	   self:increaseStat("magic", 1)
   end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 3 then
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

-- Function overrides go here

return character