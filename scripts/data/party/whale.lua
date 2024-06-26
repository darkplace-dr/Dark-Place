local character, super = Class(PartyMember, "whale")

function character:init()
    super.init(self)

    self.name = "Whale"

    self:setActor("whale")
    self:setLightActor("whale")
    self:setDarkTransitionActor("whale")

    self.level = 1
    self.title = "Whale\nIt's a freaking\nwhale"

    self.soul_priority = 0

    self.has_act = false
    self.has_spells = false

    self.has_xact = false
    self.xact_name = "W-Action"

    self.lw_portrait = "face/whale/main"

    self.health = 140

    self.stats = {
        health = 140,
        attack = 8,
        defense = 2,
        magic = 2
    }
	
	self.lw_stats = {
        health = 20,
        attack = 4,
        defense = 1,
        magic = 4,
    }

    self.weapon_icon = "ui/menu/equip/sword"

    self.color = {28/255, 32/255, 43/255}
    self.dmg_color = nil
    self.attack_bar_color = {28/255, 32/255, 43/255}
    self.attack_box_color = {28/255, 32/255, 43/255}
    self.xact_color = nil

    self.menu_icon = "party/whale/head"
    self.head_icons = "party/whale/icon"
    self.name_sprite = nil

    self.attack_sprite = "effects/attack/bash"

    self.battle_offset = {-80, -160}
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
    self:increaseStat("magic", 1)
end

function character:drawPowerStat(index, x, y, menu)
    love.graphics.print("Whale", x, y, 0, 1, 1)
    return true
end

return character
