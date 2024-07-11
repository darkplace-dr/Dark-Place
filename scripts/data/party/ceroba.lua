local character, super = Class(PartyMember, "ceroba")

function character:init()
    super.init(self)

    self.name = "Ceroba"

    self:setActor("ceroba_dw")
    self:setLightActor("ceroba")
    self:setDarkTransitionActor("ceroba_dark_transition")

    self.level = 1
    self.title = "Ketsukane\nA legacy not to\nbe forgotten."

    self.soul_priority = 1
    self.soul_color = {1, 1, 1}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "C-Action"

    self.lw_portrait = "face/ceroba/neutral_1"

    self:addSpell("diamond_guard")
    self:addSpell("paralyze")

    self.health = 180

    self.stats = {
        health = 180,
        attack = 12,
        defense = 2,
        magic = 16
    }

    self.max_stats = {
        health = 220
    }

    self.lw_health = 40

    self.lw_stats = {
        health = 40,
        attack = 14,
        defense = 10,
        magic = 5
    }

    self.weapon_icon = "ui/menu/equip/staff"

    self:setWeapon("cerobas_staff")
    self:setArmor(1, "hair_ribbon")

    self.lw_weapon_default = "light/cerobas_staff"
    self.lw_armor_default = "light/big_ribbon"

    self.color = {1, 0, 0.35}
    self.dmg_color = {1, 0, 0.35}
    self.attack_bar_color = {1, 0, 0.35}
    self.attack_box_color = {1, 0, 0.35}
    self.xact_color = {1, 0, 0.35}

    self.menu_icon = "party/ceroba/head"
    self.head_icons = "party/ceroba/icon"
    self.name_sprite = "party/ceroba/name"

    self.attack_sprite = "effects/attack/cut_ceroba"
    self.attack_sound = "laz_c"
    self.attack_pitch = 1

    self.battle_offset = {0, 0}
    self.head_icon_offset = nil
    self.menu_icon_offset = nil

    self.gameover_message = {
        "Hey,[wait:5] get up,[wait:5]\nyou hear me?!",
        "I can't lose\nanother one..."
    }
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:lightLVStats()
    self.lw_stats = {
        health = self:getLightLV() <= 20 and math.min(35 + self:getLightLV() * 5) or 25 + self:getLightLV() * 5,
        attack = 9 + self:getLightLV() + math.floor(self:getLightLV() / 3),
        defense = 9 + math.ceil(self:getLightLV() / 4),
        magic = 4 + self:getLightLV()
    }
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/smile")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Trust", x, y)
        love.graphics.print(79, x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/exclamation")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Observation", x, y, 0, 0.8, 1)
        love.graphics.print(81, x+130, y)
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