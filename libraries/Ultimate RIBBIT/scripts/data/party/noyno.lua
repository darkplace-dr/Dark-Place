local character, super = Class(PartyMember, "noyno")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Noyno"

    -- Actor (handles sprites)
    self:setActor("noyno")

    self.level = 1
    self.title = "Pompous Prince\nRaised by a rich,\nsnobby family."

    self.ribbit = true

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = -1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = { 1, 0, 0 }

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = false
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "N-Action"

    -- Spells
    self:addSpell("exorcise")
    self:addSpell("royalight")

    -- Current health (saved to the save file)
    self.health = 70

    -- Base stats (saved to the save file)
    self.stats = {
        health = 70,
        attack = 8,
        defense = 2,
        magic = 7
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/scarf"

    -- Equipment (saved to the save file)
    self:setWeapon("scarfred")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = { 0, 1, 0 }
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = { 0.5, 1, 0.5 }
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = { 181 / 255, 230 / 255, 29 / 255 }
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = { 0, 0.5, 0 }
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = { 0.5, 1, 0.5 }

    -- Head icon in the equip / power menu
    self.menu_icon = "party/noyno/head"
    -- Path to head icons used in battle
    self.head_icons = "party/noyno/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/noyno/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_r"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.15

    -- Battle position offset (optional)
    self.battle_offset = { 2, 6 }
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = {
        "Hey you, YOU.[wait:2]\nGet up, you damn frog.",
    }
end

function character:levelUp()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("magic", 2)
    self:increaseStat("defense", 1)
    self.love = self.love + 1
    if self.love == 1 then
        self.req_exp = 10
    elseif self.love == 2 then
        self.req_exp = 30
    elseif self.love == 3 then
        self.req_exp = 70
    elseif self.love == 4 then
        self.req_exp = 120
    elseif self.love == 5 then
        self.req_exp = 200
    elseif self.love == 6 then
        self.req_exp = 300
    elseif self.love == 7 then
        self.req_exp = 500
    elseif self.love == 8 then
        self.req_exp = 800
    elseif self.love == 9 then
        self.req_exp = 1200
    elseif self.love == 10 then
        self.req_exp = 1700
    elseif self.love == 11 then
        self.req_exp = 2500
    elseif self.love == 12 then
        self.req_exp = 3500
    elseif self.love == 13 then
        self.req_exp = 5000
    elseif self.love == 14 then
        self.req_exp = 7000
    elseif self.love == 15 then
        self.req_exp = 10000
    elseif self.love == 16 then
        self.req_exp = 15000
    elseif self.love == 17 then
        self.req_exp = 25000
    elseif self.love == 18 then
        self.req_exp = 50000
    elseif self.love == 19 then
        self.req_exp = 99999
    elseif self.love == 20 then
        self.req_exp = 0
    end
end

function character:onPowerSelect(menu)
    if Utils.random() <= 0.03 then
        menu.noyno_dog = true
    else
        menu.noyno_dog = false
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        if not menu.noyno_dog then
            local icon = Assets.getTexture("ui/menu/icon/mad")
            love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
            love.graphics.print("Madness", x, y)
            love.graphics.print("65", x + 130, y)
        else
            local icon = Assets.getTexture("ui/menu/icon/69")
            love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
            love.graphics.print("i give up", x, y)
            love.graphics.print("1", x + 130, y)
        end

        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/fluff")
        love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
        love.graphics.print("Fluffiness", x, y, 0, 0.8, 1)

        love.graphics.draw(icon, x + 130, y + 6, 0, 2, 2)

        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x - 26, y + 6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        return true
    end
end



return character
