local character, super = Class(PartyMember, "mario")

function character:init()
    super.init(self)

    self.name = "Mario"

    self:setActor("mario")
    self:setLightActor("mario")

    self.level = 1
    self.title = "Fat Italian\nHe's only 25972305824983 kg"

    self.soul_priority = 0

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "M-Action"

    self.lw_portrait = "face/mario/main"
	
    self:addSpell("fireball")

    self.health = 140

    self.stats = {
        health = 140,
        attack = 8,
        defense = 2,
        magic = 2
    }

    self.weapon_icon = "ui/menu/equip/hammer"

    self:setWeapon("basic_hammer")

    self.color = {1, 0, 0}
    self.dmg_color = nil
    self.attack_bar_color = {1, 0, 0}
    self.attack_box_color = {1, 0, 0}
    self.xact_color = nil

    self.menu_icon = "party/mario/head"
    self.head_icons = "party/mario/icon"
    self.name_sprite = "party/mario/name"

    self.attack_sprite = "effects/attack/bash"

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
    self:increaseStat("health", 9)
    self:increaseStat("attack", 2)
    self:increaseStat("defense", 1)
    self:increaseStat("magic", 1)
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1  then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Skills", x, y, 0, 0.7, 1)
        love.graphics.print("Fire", x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Brain", x, y)
        love.graphics.print("No", x+130, y, 0)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        
        return true
    end
end

return character
