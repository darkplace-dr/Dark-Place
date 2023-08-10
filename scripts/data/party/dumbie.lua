local character, super = Class(PartyMember, "dumbie")

function character:init()
    super.init(self)

    self.name = "Dumbie"

    self:setActor("dumbie")
    self:setLightActor("dumbie")

    self.level = 2
    self.title = "Just\na\ndumb Dummy."

    self.soul_priority = 1
    self.soul_color = {1, 0, 0}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "U-Action"
	self:addSpell("hyper_slash")

    self.health = 100

    self.stats = {
        health = 100,
        attack = 6,
        defense = 2,
        magic = 6
    }

    self.weapon_icon = "ui/menu/equip/knife"

    self:setWeapon("hyper_knife")
    self:setArmor(1, "hyper_cotton")
    self:setArmor(2, "hyper_cotton")

    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    self.color = {239, 228, 176}
    self.dmg_color = {239, 228, 176}
    self.attack_bar_color = {239, 228, 176}
    self.attack_box_color = {239, 228, 176}
    self.xact_color = {239, 228, 176}

    self.menu_icon = "party/dumbie/head"
    self.head_icons = "party/dumbie/icon"
    self.name_sprite = "party/dumbie/name"

    self.attack_sprite = "effects/attack/bash"
    self.attack_sound = "bigcut"
    self.attack_pitch = 1.5

    self.battle_offset = {3, 9}
    self.head_icon_offset = {-7, -3}
    self.menu_icon_offset = nil

    self.gameover_message = { "Wake up, punk!" }
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 3)
    self:increaseStat("defense", 1)
    self:increaseStat("magic", 1)
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