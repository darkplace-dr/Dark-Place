---@class Encounter
---@overload fun(...) : Encounter
local Encounter, super = Class("Encounter", true)

function Encounter:init()
	super.init(self)

	-- Can this be played in MULTIPLAYER?
        self.multiplayer = false

	-- Can the player flee the battle?
	self.flee = true
	-- Chance out of 100 that the player can flee this battle (x/100)
	self.flee_chance = 40
	if BadgesLib:getBadgeEquipped("refund") >= 1 then
		self.flee_chance = 80
	end
end

function Encounter:createSoul(x, y, color)
    local player = Game.party[1]
    local player_name = Game.save_name:upper()
    if player_name == "BLUE" then
        return BlueSoul(x, y, color)
    else
        return Soul(x, y, color)
    end
end

function Encounter:getNextWaves()
    local waves = {}
    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
        local wave = enemy:selectWave()
		if Mod.back_attack and enemy.back_attack then
			wave = enemy.back_attack
		end
        if wave then
            table.insert(waves, wave)
        end
    end
	Mod.back_attack = false
    return waves
end

return Encounter
