local character, super = Class(PartyMember, "brenda")

function character:init()
    super.init(self)

    self.name = "Brenda"

    self:setActor("brenda")
    self:setLightActor("brenda_lw")
    self:setDarkTransitionActor("kris_dark_transition") -- placeholder

    self.level = 1
    self.title = "Marksman\nTakes aim with\na rifle."

    self.soul_priority = 1
    self.soul_color = {0.26, 1, 1}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "B-Action"

    self.lw_portrait = "face/brenda/neutral"

    self:addSpell("gammabeam")

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

    self.lw_weapon_default = "light/foam_dart_rifle"
    self.lw_armor_default = "light/bandage"

    self.color = {0, 0, 1}
    self.dmg_color = nil
    self.attack_bar_color = {0, 0, 232/255}
    self.attack_box_color = {0, 0, 0.5}
    self.xact_color = nil

    self.menu_icon = "party/brenda/head"
    self.head_icons = "party/brenda/icon"
    self.name_sprite = "party/brenda/name"

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

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 10)
    self:increaseStat("attack", 3)
    self:increaseStat("defense", 1)
    self:increaseStat("magic", 1)
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1  then
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Gaming Skills", x, y, 0, 0.7, 1)
        love.graphics.print("Yes", x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Bisexual", x, y)
        love.graphics.print("Yes", x+130, y, 0, 0.8, 1)
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

function character:getStarmanTheme() return "brenda" end

return character