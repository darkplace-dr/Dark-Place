---@class Encounter : Encounter
---@overload fun(...) : Encounter
local Encounter, super = Class("Encounter", true)

function Encounter:init()
	super:init(self)
	
	-- Can the player flee the battle?
	self.flee = true
	-- Chance out of 100 that the player can flee this battle (x/100)
	self.flee_chance = 60
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