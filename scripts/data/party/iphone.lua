local character, super = Class(PartyMember, "iphone")

function character:init()
    super.init(self)

    -- Display name
    self.name = "iPhone7P"

    -- Actor (handles sprites)
    self:setActor("iphone")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "iPhone 7 Plus\nMight be able to\nuse some cool apps."

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
    self.xact_name = "iAction"

    -- Spells
    self:addSpell("heal_prayer")
    self:addSpell("sleep_mist")
    self:addSpell("ice_shock")

    -- Current health (saved to the save file)
    self.health = 85

    -- Base stats (saved to the save file)
    self.stats = {
        health = 76,
        attack = 5,
        defense = 2,
        magic = 14
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 187
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/microwave"

    -- Equipment (saved to the save file)
    self:setWeapon("microwave")
    self:setArmor(1, "netflix")
    self:setArmor(2, "netflix")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {198/255, 136/255, 132/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {229/255, 157/255, 153/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {229/255, 157/255, 153/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {150/255, 90/255, 87/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {229/255, 157/255, 153/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/iphone/head"
    -- Path to head icons used in battle
    self.head_icons = "party/iphone/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/iphone/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_n"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
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
        ["electrofucks_used"] = 0,
    }
end

function character:getTitle()
    if self:checkWeapon("microwave") then
        return "LV"..self.level.." Jailbroken\nUses custom Bootloaders\nto become stronger."
    elseif self:getFlag("electrofucks_used", 0) > 0 then
        return "LV"..self.level.." Electrofucker\nElectrocutes the enemy."
    else
        return "LV"..self.level.." "..self.title
    end
end

function character:onLevelUp(level)
    self:increaseStat("health", 4)
    if level % 4 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        return true
    end
end

return character