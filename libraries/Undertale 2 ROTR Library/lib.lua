local lib = {}

function lib:init()
    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
end

function lib:onActionSelect(battler, button)
    if button.type == "ut2_fight" then
        Game.battle:setState("ENEMYSELECT", "ATTACK")
        return true
    elseif button.type == "ut2_act" then
        Game.battle.menu_items = {}
        for i,amount in ipairs{"Slap"} do -- (add more to table for the silly)
            table.insert(Game.battle.menu_items, {
                ["name"] = amount,
                ["description"] = "",
            })
        end
        Game.battle:setState("MENUSELECT", "ACT_UT2")
        return true
    end
end

function lib:onBattleMenuSelect(state, item, can_select)
    if state == "ACT_UT2" and can_select then
        if can_select then
            self.ui_select:stop()
            self.ui_select:play()

            --here add stuff

            --Game.battle:setState("ENEMYSELECT", "SPELL")
        end
    end
end

function lib:getActionButtons(battler, buttons)
    if battler.chara.id == "frisk2" then
        return {"ut2_fight", "ut2_talk", "ut2_act", "item", "defend"}
    end
    return buttons
end

return lib