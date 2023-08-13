-- Functions to control enemy TP.

---@deprecated
---Adds TP to the enemy's TP bar. Doesn't work outside of battle or if no enemy TP bar exists.
---@param tp integer Amount to give.
function Mod:giveEnemyTension(tp)
    Game.battle:giveEnemyTension(tp)
end

---@deprecated
---Removes TP from the enemy's TP bar. Doesn't work outside of battle or if no enemy TP bar exists.
---@param tp integer Amount to remove.
function Mod:removeEnemyTension(tp)
    Game.battle:removeEnemyTension(tp)
end

---@deprecated
---Returns current enemy TP value. Doesn't work outside of battle or if no enemy TP bar exists.
---@return integer tp
function Mod:getEnemyTension()
    return Game.battle:getEnemyTension()
end

---@deprecated
---Sets enemy TP to the given value. Doesn't work outside of battle or if no enemy TP bar exists.
---@param tp integer Amount to set.
function Mod:setEnemyTension(tp)
    Game.battle:setEnemyTension(tp)
end