local lib = {}

function lib:init()
    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")

    self.useUT2Buttons = false --need to fix
end

function lib:onActionSelect(battler, button)
    if button.type == "ut2_talk" then
        Game.battle.menu_items = {}
        for i,amount in ipairs{"Slap"} do -- (add more to table for the silly)
            table.insert(Game.battle.menu_items, {
                ["name"] = amount,
                ["description"] = "",
            })
        end
        Game.battle:setState("MENUSELECT", "TALK_UT2")
        return true
    end
end

function lib:onBattleMenuSelect(state, item, can_select)
    if state == "TALK_UT2" and can_select then


        if can_select then

            self.ui_select:stop()
            self.ui_select:play()

            --here add stuff
            
            --Game.battle:setState("ENEMYSELECT", "SPELL")

        end

    end
end

function Mod:getActionButtons(battler, buttons)
    if self.useUT2Buttons then
        if battler.chara.id == "frisk2" then
            Utils.removeFromTable(buttons, "fight")
            Utils.removeFromTable(buttons, "magic")
            Utils.removeFromTable(buttons, "spare")
            Utils.removeFromTable(buttons, "defend")
            Utils.removeFromTable(buttons, "item")
            table.insert(buttons, FightButtonUT2())
            table.insert(buttons, TalkButtonUT2())
            table.insert(buttons, ActButtonUT2())
            table.insert(buttons, "item")
        end
    end
    return buttons
end

return lib