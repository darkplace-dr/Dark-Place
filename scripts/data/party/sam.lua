local character, super = Class(PartyMember, "sam")

function character:init()
    super.init(self)

    self.name = "Sam"

    self:setActor("kris")
    self:setLightActor("kris_lw")

    self.level = 1
    self.title = "Master Healer\nMastered magic\nSucks at attack."

    self.soul_priority = 1
    self.soul_color = {1, 0, 0}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "Sa-Action"

    self.health = 50

    self.stats = {
        health = 50,
        attack = 1,
        defense = 3,
        magic = 6
    }

    self.weapon_icon = "ui/menu/equip/gun"

    --self:setWeapon("basic_rifle")
    --self:setArmor(1, "bshot_glasses")
    --self:setArmor(2, "syrup_jar")

    self:addSpell("kindness_healing")
    self:addSpell("master_sheild")

    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    self.color = Utils.mergeColor({0, 1, 1}, {0, 1, 0}, 0.5)
    self.dmg_color = nil
    self.attack_bar_color = {0, 0, 232/255}
    self.attack_box_color = {0, 0, 0.5}
    self.xact_color = nil

    self.menu_icon = "party/kris/head"
    self.head_icons = "party/kris/icon"
    --self.name_sprite = "party/kris/name"

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
    self:increaseStat("attack", 2)
    self:increaseStat("defense", 1)
    self:increaseStat("magic", 3)
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1  then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Creativity:", x, y, 0, 0.7, 1)

        love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+150, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+170, y+6, 0, 2, 2)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Cringe:", x, y)
        love.graphics.print("OK", x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Nb Projects:", x, y, 0, 0.7, 1)
        love.graphics.print("TOO MUCH", x+130, y, 0, 0.6, 1)

        
        return true
    end
end

return character