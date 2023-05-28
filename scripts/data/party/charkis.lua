local character, super = Class(PartyMember, "charkis")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Charkis"

    -- Actor (handles overworld/battle sprites)
    self:setActor("charkis")

    -- Display level (saved to the save file)
    self.level = 1
    -- Default title / class (saved to the save file)
    self.title = "Hooded Kid\nSeems like a Dark-World\nbeing."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = -1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = false

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "C-Action"

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
    self.weapon_icon = "ui/menu/equip/scythe"

    -- Equipment (saved to the save file)
    self:setWeapon("ironhook")
    self:setArmor(1, "amber_card")
    self:setArmor(2, "amber_card")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {53/255, 198/255, 148/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {53/255, 198/255, 148/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {53/255, 198/255, 148/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {23/255, 94/255, 91/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {53/255, 198/255, 148/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/charkis/head"
    -- Path to head icons used in battle
    self.head_icons = "party/charkis/icon"
    -- Name sprite
    self.name_sprite = "party/charkis/name"

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

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:onPowerSelect(menu)

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

return character