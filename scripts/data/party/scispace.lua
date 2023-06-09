local character, super = Class(PartyMember, "scispace")

function character:init()
    super.init(self)

    self.name = "SciSpace"

    self:setActor("scispace")
    self:setLightActor("scispace") --Temp

    self.level = 1
    self.title = "Programmer,\nChef,\nall around\nguy!"

    self.soul_priority = 1
    self.soul_color = {0.05, 0.5, 0.75}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "S-Action"

    --self:addSpell("not done") maek cool spell real!!??!!??!?! -Sc

    self.health = 110

    self.stats = {
        health = 110,
        attack = 11,
        defense = 2,
        magic = 3
    }

    self.weapon_icon = "ui/menu/equip/gun" --nonononoono dont use this -Sci

    self:setWeapon("basic_rifle")  --same for this... -Sci
    self:setArmor(1, "bshot_glasses")
    self:setArmor(2, "syrup_jar")

    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"
    --add colors later!!! -Sci
    self.color = {0, 0, 1}
    self.dmg_color = nil
    self.attack_bar_color = {0, 0, 232/255}
    self.attack_box_color = {0, 0, 0.5}
    self.xact_color = nil

    self.menu_icon = "party/scispace/head"
    self.head_icons = "party/scispace/icon"
    self.name_sprite = "party/scispace/name"

    self.attack_sprite = "effects/attack/shoot"
    self.attack_sound = "bigcut"
    self.attack_pitch = 0.5

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
--do some cool stuff here!!!!
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