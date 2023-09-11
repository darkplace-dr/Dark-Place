---@class Encounter
---@overload fun(...) : Encounter
local Encounter = Class("Encounter", true)

function Encounter:createSoul(x, y, color)
    local player = Game.party[1]
    local player_name = Game.save_name:upper()
    if player:checkArmor("pizza_toque") or player_name == "PEPPINO" then
        return TauntSoul(x, y, color)
    elseif player_name == "BLUE" then
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