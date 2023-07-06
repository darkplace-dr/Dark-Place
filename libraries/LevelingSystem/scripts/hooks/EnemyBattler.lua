---@class EnemyBattler
local EnemyBattler, super = Class("EnemyBattler", true)

function EnemyBattler:defeat(reason, violent)
    self.done_state = reason or "DEFEATED"

    if violent then
        Game.battle.used_violence = true
    end

    Game.battle.money = Game.battle.money + self.money

    if self.done_state == "KILLED" or self.done_state == "FROZEN" then
        Game.battle.killed = true
        Game:addFlag("library_kills", 1)
        if self.done_state == "FROZEN" and Kristal.getLibConfig("leveling", "local_freezing") then
            Game.battle.freeze_xp = Game.battle.freeze_xp + self.experience
        else
            Game.battle.xp = Game.battle.xp + self.experience
        end
    end

    Game.battle:removeEnemy(self, true)
end

return EnemyBattler