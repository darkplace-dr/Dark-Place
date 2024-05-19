local character, super = Class(PartyMember, "mario")

function character:init()
    super.init(self)

    self.name = "Mario"

    self:setActor("mario")
    self:setLightActor("mario")
    self:setDarkTransitionActor("mario_dark_transition")

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
	
	self.lw_stats = {
        health = 10,
        attack = 4,
        defense = 1,
        magic = 4,
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
	
	self.lw_exp_needed = {	-- M&L max level is 100, but being realistic, the games bring you to level 50 on their own.
        [ 1] = 0,
        [ 2] = 4,
        [ 3] = 16,
        [ 4] = 34,
        [ 5] = 74,
        [ 6] = 118,
        [ 7] = 236,
        [ 8] = 370,
        [ 9] = 544,
        [10] = 792,
        [11] = 1254,
        [12] = 1578,
        [13] = 1924,
        [14] = 2306,
        [15] = 2756,
        [16] = 3256,
        [17] = 3830,
        [18] = 4480,
        [19] = 5195,
        [20] = 5975,
        [21] = 7805,
        [22] = 8805,
        [23] = 9845,
        [24] = 10925,
        [25] = 12025,
        [26] = 13225,
        [27] = 14575,
        [28] = 16085,
        [29] = 17765,
        [30] = 19625,
        [31] = 21685,
        [32] = 23965,
        [33] = 26485,
        [34] = 29265,
        [35] = 32325,
        [36] = 35685,
        [37] = 39365,
        [38] = 43385,
        [39] = 47805,
        [40] = 52805,
        [41] = 58305,
        [42] = 64405,
        [43] = 71905,
        [44] = 79705,
        [45] = 87805,
        [46] = 96205,
        [47] = 104905,
        [48] = 113905,
        [49] = 123205,
        [50] = 132805,
    }
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

function character:lightLVStats()
	levelstats = {
		{
			health = 10,
			attack = 12,
			defense = 9,
			magic = 1
		},
		{
			health = 12,
			attack = 13,
			defense = 11,
			magic = 1
		},
		{
			health = 13,
			attack = 15,
			defense = 12,
			magic = 1
		},
		{
			health = 14,
			attack = 18,
			defense = 14,
			magic = 2
		},
		{
			health = 15,
			attack = 20,
			defense = 16,
			magic = 2
		},
		{
			health = 16,
			attack = 22,
			defense = 17,
			magic = 2
		},
		{
			health = 18,
			attack = 25,
			defense = 19,
			magic = 3
		},
		{
			health = 18,
			attack = 26,
			defense = 20,
			magic = 3
		},
		{
			health = 19,
			attack = 28,
			defense = 22,
			magic = 3
		},
		{
			health = 20,
			attack = 29,
			defense = 24,
			magic = 4
		},
		{
			health = 22,
			attack = 33,
			defense = 26,
			magic = 4
		},
		{
			health = 23,
			attack = 34,
			defense = 28,
			magic = 4
		},
		{
			health = 24,
			attack = 36,
			defense = 30,
			magic = 5
		},
		{
			health = 26,
			attack = 38,
			defense = 33,
			magic = 5
		},
		{
			health = 27,
			attack = 41,
			defense = 35,
			magic = 5
		},
		{
			health = 28,
			attack = 44,
			defense = 38,
			magic = 6
		},
		{
			health = 30,
			attack = 46,
			defense = 40,
			magic = 6
		},
		{
			health = 31,
			attack = 49,
			defense = 41,
			magic = 6
		},
		{
			health = 32,
			attack = 51,
			defense = 43,
			magic = 7
		},
		{
			health = 34,
			attack = 54,
			defense = 46,
			magic = 7
		},
		{
			health = 35,
			attack = 57,
			defense = 48,
			magic = 7
		},
		{
			health = 36,
			attack = 59,
			defense = 50,
			magic = 7
		},
		{
			health = 38,
			attack = 61,
			defense = 53,
			magic = 7
		},
		{
			health = 39,
			attack = 64,
			defense = 56,
			magic = 7
		},
		{
			health = 41,
			attack = 66,
			defense = 58,
			magic = 7
		},
		{
			health = 41,
			attack = 67,
			defense = 59,
			magic = 7
		},
		{
			health = 42,
			attack = 69,
			defense = 61,
			magic = 7
		},
		{
			health = 44,
			attack = 72,
			defense = 64,
			magic = 7
		},
		{
			health = 44,
			attack = 74,
			defense = 65,
			magic = 7
		},
		{
			health = 46,
			attack = 77,
			defense = 67,
			magic = 7
		},
		{
			health = 47,
			attack = 78,
			defense = 69,
			magic = 7
		},
		{
			health = 47,
			attack = 80,
			defense = 72,
			magic = 7
		},
		{
			health = 49,
			attack = 83,
			defense = 74,
			magic = 7
		},
		{
			health = 50,
			attack = 85,
			defense = 76,
			magic = 7
		},
		{
			health = 52,
			attack = 88,
			defense = 79,
			magic = 7
		},
		{
			health = 52,
			attack = 90,
			defense = 80,
			magic = 7
		},
		{
			health = 53,
			attack = 92,
			defense = 84,
			magic = 7
		},
		{
			health = 53,
			attack = 93,
			defense = 86,
			magic = 7
		},
		{
			health = 55,
			attack = 95,
			defense = 88,
			magic = 7
		},
		{
			health = 56,
			attack = 96,
			defense = 89,
			magic = 7
		},
		{
			health = 58,
			attack = 97,
			defense = 91,
			magic = 7
		},
		{
			health = 58,
			attack = 99,
			defense = 94,
			magic = 7
		},
		{
			health = 59,
			attack = 102,
			defense = 95,
			magic = 7
		},
		{
			health = 60,
			attack = 104,
			defense = 97,
			magic = 7
		},
		{
			health = 60,
			attack = 107,
			defense = 98,
			magic = 7
		},
		{
			health = 60,
			attack = 109,
			defense = 99,
			magic = 7
		},
		{
			health = 61,
			attack = 111,
			defense = 102,
			magic = 7
		},
		{
			health = 62,
			attack = 112,
			defense = 103,
			magic = 7
		},
		{
			health = 63,
			attack = 114,
			defense = 105,
			magic = 7
		},
		{
			health = 63,
			attack = 115,
			defense = 106,
			magic = 7
		}
	}
    self.lw_stats = levelstats[self:getLightLV()]
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
