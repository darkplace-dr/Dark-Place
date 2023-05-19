-- Functions to control enemy TP.

---Adds TP to the enemy's TP bar. Doesn't work outside of battle or if no enemy TP bar exists.
---@param TP integer Amount to give.
function Mod:giveEnemyTension(TP)
    Game.battle.encounter.enemy_tension = Game.battle.encounter.enemy_tension + TP
end


---Removes TP from the enemy's TP bar. Doesn't work outside of battle or if no enemy TP bar exists.
---@param TP integer Amount to remove.
function Mod:removeEnemyTension(TP)
    if Game.battle.encounter.enemy_tension - TP < 0 then
        Game.battle.encounter.enemy_tension = 0
    else
        Game.battle.encounter.enemy_tension = Game.battle.encounter.enemy_tension - TP
    end
end

---Returns current enemy TP value. Doesn't work outside of battle or if no enemy TP bar exists.
function Mod:getEnemyTension()
    return Game.battle.enemy_tension
end

---Sets enemy TP to the given value. Doesn't work outside of battle or if no enemy TP bar exists.
---@param TP integer Amount to set.
function Mod:setEnemyTension(TP)
    Game.battle.encounter.enemy_tension = TP
end
