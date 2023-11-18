local character, super = Class(PartyMember, "noel")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Noel"

    -- Actor (handles sprites)
    self:setActor("noel")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Template\nPlaceholder\nPlaceholding."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = -20
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 1, 1}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "Noel-Do"

    -- Spells
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")
    self:addSpell("ice_shock")

    -- Current health (saved to the save file)
    self.health = 90

    -- Base stats (saved to the save file)
    self.stats = {
        health = 90,
        attack = 1,
        defense = 1,
        magic = 1
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 120
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/sword"

    -- Equipment (saved to the save file)

    -- Default light world equipment item IDs (saves current equipment)
    --self.lw_weapon_default = "light/pencil"
    --self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 1, 1}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 1, 1}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 1, 1}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 1, 1}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 1, 1}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/noelle/head"
    -- Path to head icons used in battle
    self.head_icons = "party/noel/icon"
    -- Name sprite (optional)
    --self.name_sprite = "party/noel/name"

    -- Effect shown above enemy after attacking it
    --self.attack_sprite = "effects/attack/slap_n"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1
    -- Battle position offset (optional)
    self.battle_offset = {0, 0}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end



return character