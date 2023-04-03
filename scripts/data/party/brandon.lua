local character, super = Class(PartyMember, "brandon")

function character:init()
    super.init(self)

    self.name = "Brandon"

    self:setActor("brandon")
    self:setLightActor("kris_lw")

    self.level = 1
    self.title = "Marksman\nTakes aim with\na rifle."

    self.soul_priority = 1
    self.soul_color = {1, 0, 0}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "B-Action"

    self.health = 100

    self.stats = {
        health = 100,
        attack = 15,
        defense = 1,
        magic = 2
    }

    self.weapon_icon = "ui/menu/equip/gun"

    self:setWeapon("basic_rifle")
    self:setArmor(1, "bshot_glasses")
    self:setArmor(2, "syrup_jar")

    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    self.color = {0, 0, 1}
    self.dmg_color = nil
    self.attack_bar_color = {0, 0, 232/255}
    self.attack_box_color = {0, 0, 0.5}
    self.xact_color = nil

    self.menu_icon = "party/brandon/head"
    self.head_icons = "party/brandon/icon"
    self.name_sprite = "party/brandon/name"

    self.attack_sprite = "effects/attack/shoot"
    self.attack_sound = "bigcut"
    self.attack_pitch = 1.5

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil

    self.gameover_message = nil
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:levelUp()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 3)
    self:increaseStat("defense", 1)
    self:increaseStat("magic", 1)
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

function character:drawPowerStat(index, x, y, menu)
    if index == 1  then
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Gaming Skills:", x, y, 0, 0.7, 1)
        love.graphics.print("Yes", x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Bisexual:", x, y)
        love.graphics.print("Yes", x+130, y, 0)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        return true
    end
end

return character