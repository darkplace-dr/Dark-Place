local LightBattle, super = Class(Object)

-- nyako, if you ever read this, i'm sorry i basically turned this into a hodgepodge of
-- kristal code and literal shit

function LightBattle:init()
    super.init(self)

    self.light = true
    self.forced_victory = false

    self.party = {}

    -- states: BATTLETEXT, TRANSITION, ACTIONSELECT, MENUSELECT, ENEMYSELECT, PARTYSELECT, TURNDONE
    -- ENEMYDIALOGUE, DEFENDING, DEFENDINGEND, VICTORY, TRANSITIONOUT, ATTACKING, FLEEING, FLEEFAIL

    self.state = "NONE"
    self.substate = "NONE"

    self.post_battletext_state = "ACTIONSELECT"

    self.tension = Kristal.getLibConfig("magical-glass", "light_battle_tp")

    self.fader = Fader()
    self.fader.layer = 1000
    self.fader.alpha = 1
    self:addChild(self.fader)

    self.enemy_world_characters = {}

    self.money = 0
    self.xp = 0

    self.used_violence = false

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.spare_sound = Assets.newSound("vaporized")

    self.encounter_context = nil

    self.offset = 0

    self.textbox_timer = 0
    self.use_textbox_timer = true

    self:createPartyBattlers()

    self.camera = Camera(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.cutscene = nil

    self.current_selecting = 0

    self.turn_count = 0

    self.arena = nil
    self.soul = nil

    self.music = Music()

    self.resume_world_music = false

    self.transitioned = false

    self.mask = ArenaMask()
    self:addChild(self.mask)

    self.timer = Timer()
    self:addChild(self.timer)

    self.character_actions = {}

    self.selected_character_stack = {}
    self.selected_action_stack = {}

    self.current_actions = {}
    self.short_actions = {}
    self.current_action_index = 1
    self.processed_action = {}
    self.processing_action = false

    self.attackers = {}
    self.normal_attackers = {}
    self.auto_attackers = {}

    self.attack_done = false
    self.cancel_attack = false
    self.auto_attack_timer = 0

    self.post_battletext_func = nil
    self.post_battletext_state = "ACTIONSELECT"

    self.battletext_table = nil
    self.battletext_index = 1

    self.current_menu_x = 1
    self.current_menu_y = 1
    self.current_menu_columns = nil
    self.current_menu_rows = nil

    self.menuselect_cursor_memory = {}
    self.enemyselect_cursor_memory = {}
    self.partyselect_cursor_memory = {}

    self.enemies = {}
    self.enemy_dialogue = {}
    self.defeated_enemies = {}

    self.seen_encounter_text = false

    self.waves = {}
    self.menu_waves = {}
    self.finished_waves = false
    self.finished_menu_waves = false
    self.story_wave = nil

    self.state_reason = nil
    self.substate_reason = nil

    self.menu_items = {}
    self.pager_menus = {"ITEM"}

    self.actions_done_timer = 0

    self.xactions = {}

    self.selected_enemy = 1
    self.selected_spell = nil
    self.selected_xaction = nil
    self.selected_item = nil

    self.should_finish_action = false
    self.on_finish_keep_animation = nil
    self.on_finish_action = nil

    self.background_fade_alpha = 0

    self.wave_length = 0
    self.wave_timer = 0
    self.menu_wave_length = 0
    self.menu_wave_timer = 0

    self.darkify_fader = Fader()
    self.darkify_fader.layer = BATTLE_LAYERS["below_arena"]
    self:addChild(self.darkify_fader)
end

function LightBattle:isPagerMenu()
    for _,menu in ipairs(self.pager_menus) do
        if menu == self.state_reason then
            return true
        end
    end
    return false
end

function LightBattle:playSelectSound()
    if not self.ui_select:isPlaying() then
        self.ui_select:stop()
        self.ui_select:play()
    end
end

function LightBattle:playMoveSound()
    self.ui_move:play()
end

function LightBattle:playVaporizedSound()
    self.vaporized:stop()
    self.vaporized:play()
end

function LightBattle:toggleSoul(soul)
    if soul then
        self.soul.collidable = true
        self.soul.visible = true
    else
        self.soul.collidable = false
        self.soul.visible = false
    end
end

function LightBattle:createPartyBattlers()
    for i = 1, 1 do
        local party_member = Game.party[i]

        local battler = LightPartyBattler(party_member)
        battler.visible = false
        self:addChild(battler)
        table.insert(self.party, battler)
    end
end

function LightBattle:postInit(state, encounter)
    self.state = state

    if type(encounter) == "string" then
        self.encounter = MagicalGlassLib:createLightEncounter(encounter)
    else
        self.encounter = encounter
    end

    if self.encounter.includes(Encounter) then
        error("Attempted to use Encounter in a LightBattle. Convert the encounter file to a LightEncounter.")
    end

    if Game.world.music:isPlaying() and self.encounter.music then
        self.resume_world_music = true
        Game.world.music:pause()
    end

    if self.encounter.queued_enemy_spawns then
        for _,enemy in ipairs(self.encounter.queued_enemy_spawns) do
            table.insert(self.enemies, enemy)
            self:addChild(enemy)
        end
    end

    if state == "TRANSITION" then
        self.encounter:onSoulTransition()
    else
        self.encounter:onNoTransition()
    end

    if self.encounter.story then
        self.story_wave = self.encounter:storyWave()
    end

    self.arena = LightArena(SCREEN_WIDTH/2, 385)
    self.arena.layer = BATTLE_LAYERS["ui"] - 1
    self:addChild(self.arena)

    self.battle_ui = LightBattleUI()
    self:addChild(self.battle_ui)

    self.tension_bar = LightTensionBar(29, 53, true)
    if self.tension then
        self.tension_bar.visible = false
    end
    self:addChild(self.tension_bar)

    if Game.encounter_enemies then
        for _,enemy in ipairs(Game.encounter_enemies) do
            if not isClass(enemy) then
                local battler = self:parseEnemyIdentifier(enemy[1])
                enemy[2].battler = battler
                self.enemy_world_characters[battler] = enemy[2]
                if state == "TRANSITION" then
                    battler:setPosition(enemy[2]:getScreenPos())
                end
            end
        end
    end

    if self.encounter_context and self.encounter_context:includes(ChaserEnemy) then
        for _,enemy in ipairs(self.encounter_context:getGroupedEnemies(true)) do
            enemy:onEncounterStart(enemy == self.encounter_context, self.encounter)
        end
    end

    if not self.encounter:onBattleInit() then
        self:setState(state)
    end   
end

function LightBattle:onRemove(parent)
    super.onRemove(self, parent)

    self.music:remove()
end

function LightBattle:isWorldHidden()
    return true
end

function LightBattle:spawnSoul(x, y)
    local bx, by = self:getSoulLocation()
    x = x or bx
    y = y or by
    local color = {Game:getSoulColor()}
    if not self.soul then
        self.soul = self.encounter:createSoul(x, y, color)
        self.soul.alpha = 1
        self.soul.sprite:set("player/heart_light")
        self:addChild(self.soul)
    end
end

function LightBattle:swapSoul(object)
    local prev_soul_speed = self.soul.speed
    if self.soul then
        self.soul:remove()
    end
    object:setPosition(self.soul:getPosition())
    object.layer = self.soul.layer
    self.soul = object
    self.soul.speed = prev_soul_speed
    self:addChild(object)
end

function LightBattle:getSoulLocation(always_player)
    if self.soul and (not always_player) then
        return self.soul:getPosition()
    else
        return -9, -9
    end
end

function LightBattle:setState(state, reason)
    local old = self.state
    self.state = state
    self.state_reason = reason
    self:onStateChange(old, self.state)
end

function LightBattle:setSubState(state, reason)
    local old = self.substate
    self.substate = state
    self.substate_reason = reason
    self:onSubStateChange(old, self.substate)
end

function LightBattle:getState()
    return self.state
end

function LightBattle:onSubStateChange(old, new) end

function LightBattle:registerXAction(party, name, description, tp)
    local act = {
        ["name"] = name,
        ["description"] = description,
        ["party"] = party,
        ["color"] = {self.party[self:getPartyIndex(party)].chara:getXActColor()},
        ["tp"] = tp or 0,
        ["short"] = false
    }

    table.insert(self.xactions, act)
end

function LightBattle:getEncounterText()
    return self.encounter:getEncounterText()
end

function LightBattle:processCharacterActions()
    if self.state ~= "ACTIONS" then
        self:setState("ACTIONS", "DONTPROCESS")
    end

    self.current_action_index = 1

    local order = {"ACT", {"SPELL", "ITEM", "SPARE"}}

    for lib_id,_ in pairs(Mod.libs) do
        order = Kristal.libCall(lib_id, "getActionOrder", order, self.encounter) or order
    end
    order = Kristal.modCall("getActionOrder", order, self.encounter) or order

    table.insert(order, "SKIP")

    for _,action_group in ipairs(order) do
        if self:processActionGroup(action_group) then
            self:tryProcessNextAction()
            return
        end
    end

    self:setSubState("NONE")
    self:setState("ATTACKING")
end

function LightBattle:processActionGroup(group)
    if type(group) == "string" then
        local found = false
        for i,battler in ipairs(self.party) do
            local action = self.character_actions[i]
            if action and action.action == group then
                found = true
                self:beginAction(action)
            end
        end
        for _,action in ipairs(self.current_actions) do
            self.character_actions[action.character_id] = nil
        end
        return found
    else
        for i,battler in ipairs(self.party) do
            local action = self.character_actions[i]
            if action and Utils.containsValue(group, action.action) then
                self.character_actions[i] = nil
                self:beginAction(action)
                return true
            end
        end
    end
end

function LightBattle:tryProcessNextAction(force)
    if self.state == "ACTIONS" and not self.processing_action then
        if #self.current_actions == 0 then
            self:processCharacterActions()
        else
            while self.current_action_index <= #self.current_actions do
                local action = self.current_actions[self.current_action_index]
                if not self.processed_action[action] then
                    self.processing_action = action
                    if self:processAction(action) then
                        self:finishAction(action)
                    end
                    return
                end
                self.current_action_index = self.current_action_index + 1
            end
        end
    end
end

function LightBattle:getCurrentActing()
    local result = {}
    for _,action in ipairs(self.current_actions) do
        if action.action == "ACT" then
            table.insert(result, action)
        end
    end
    return result
end

function LightBattle:beginAction(action)
    local battler = self.party[action.character_id]
    local enemy = action.target

    -- Add the action to the actions table, for group processing
    table.insert(self.current_actions, action)

    -- Set the state
    if self.state == "ACTIONS" then
        self:setSubState(action.action)
    end

    -- Call mod callbacks for adding new beginAction behaviour
    if Kristal.callEvent("onBattleActionBegin", action, action.action, battler, enemy) then
        return
    end

    if action.action == "ACT" then
        -- Play the ACT animation by default
        --battler:setAnimation("battle/act")
        -- Enemies might change the ACT animation, so run onActStart here
        enemy:onActStart(battler, action.name)
    end
end

function LightBattle:retargetEnemy()
    for _,other in ipairs(self.enemies) do
        if not other.done_state then
            return other
        end
    end
end

function LightBattle:endAttack()
    self:finishAction(action)

    Utils.removeFromTable(self.normal_attackers, battler)
    Utils.removeFromTable(self.auto_attackers, battler)

    if not self:retargetEnemy() then
        self.cancel_attack = true
    elseif #self.normal_attackers == 0 and #self.auto_attackers > 0 then
        local next_attacker = self.auto_attackers[1]

        local next_action = self:getActionBy(next_attacker)
        if next_action then
            self:beginAction(next_action)
            self:processAction(next_action)
        end
    end
end

function LightBattle:processAction(action)
    local battler = self.party[action.character_id]
    local party_member = battler.chara
    local enemy = action.target

    self.current_processing_action = action

    if enemy and enemy.done_state then
        enemy = self:retargetEnemy()
        action.target = enemy
        if not enemy then
            return true
        end
    end

    -- Call mod callbacks for onBattleAction to either add new behaviour for an action or override existing behaviour
    -- Note: non-immediate actions require explicit "return false"!
    local callback_result = Kristal.modCall("onBattleAction", action, action.action, battler, enemy)
    if callback_result ~= nil then
        return callback_result
    end
    for lib_id,_ in pairs(Mod.libs) do
        callback_result = Kristal.libCall(lib_id, "onBattleAction", action, action.action, battler, enemy)
        if callback_result ~= nil then
            return callback_result
        end
    end

    self.current_selecting = 0

    if action.action == "SPARE" then

        self:toggleSoul(false)

        for _,act_enemy in ipairs(self:getActiveEnemies()) do
            local worked = act_enemy:canSpare()
            act_enemy:onMercy(battler)
        end

        self:finishAction(action)

    elseif action.action == "ATTACK" or action.action == "AUTOATTACK" then

        self.actions_done_timer = 1.2

        local lane
        for _,ilane in ipairs(self.battle_ui.attack_box.lanes) do
            if ilane.battler == battler then
                lane = ilane
                break
            end
        end

        if lane.attacked then

            if action.target and action.target.done_state then
                enemy = self:retargetEnemy()
                action.target = enemy
                if not enemy then
                    self.cancel_attack = true
                    self:finishAction(action)
                    return
                end
            end

            local weapon = battler.chara:getWeapon()
            local damage = 0
            local crit

            if not action.force_miss and action.points > 0 then
                damage, crit = enemy:getAttackDamage(action.damage or 0, lane, action.points or 0, action.stretch)
                damage = Utils.round(damage)

                if damage < 0 then
                    damage = 0
                end

                weapon:onLightAttack(battler, enemy, damage, action.stretch, crit)
            else
                weapon:onLightMiss(battler, enemy, true, false)
            end

        end

        return false

    elseif action.action == "ACT" then
        local self_short = false
        self.short_actions = {}
        for _,iaction in ipairs(self.current_actions) do
            if iaction.action == "ACT" then
                local ibattler = self.party[iaction.character_id]
                local ienemy = iaction.target

                if ienemy then
                    local act = ienemy and ienemy:getAct(iaction.name)

                    if (act and act.short) or (ienemy:getXAction(ibattler) == iaction.name and ienemy:isXActionShort(ibattler)) then
                        table.insert(self.short_actions, iaction)
                        if ibattler == battler then
                            self_short = true
                        end
                    end
                end
            end
        end

        if self_short and #self.short_actions > 1 then
            local short_text = {}
            for _,iaction in ipairs(self.short_actions) do
                local ibattler = self.party[iaction.character_id]
                local ienemy = iaction.target

                local act_text = ienemy:onShortAct(ibattler, iaction.name)
                if act_text then
                    table.insert(short_text, act_text)
                end
            end

            self:shortActText(short_text)
        else
            local text = enemy:onAct(battler, action.name)
            if text then
                self:setActText(text)
            end
        end

        return false

    elseif action.action == "SKIP" then
        return true

    elseif action.action == "SPELL" then
        self.battle_ui:clearEncounterText()

        -- The spell itself handles the animation and finishing
        action.data:onLightStart(battler, action.target)

        return false
    elseif action.action == "ITEM" then
        local item = action.data
        if item.instant then
            self:finishAction(action)
        else
            local result = item:onLightBattleUse(battler, action.target)
            if result or result == nil then
                self:finishAction(action)
            end
        end
        return false

    elseif action.action == "DEFEND" then
        battler.defending = true
        return false
    else
        -- we don't know how to handle this...
        Kristal.Console:warn("Unhandled battle action: " .. tostring(action.action))
        return true
    end
end

function LightBattle:getCurrentAction()
    return self.current_actions[self.current_action_index]
end

function LightBattle:getActionBy(battler)
    for i,party in ipairs(self.party) do
        if party == battler then
            return self.character_actions[i]
        end
    end
end

function LightBattle:finishActionBy(battler)
    for _,action in ipairs(self.current_actions) do
        local ibattler = self.party[action.character_id]
        if ibattler == battler then
            self:finishAction(action)
        end
    end
end

function LightBattle:finishAllActions()
    for _,action in ipairs(self.current_actions) do
        self:finishAction(action)
    end
end

function LightBattle:allActionsDone()
    for _,action in ipairs(self.current_actions) do
        if not self.processed_action[action] then
            return false
        end
    end
    return true
end

function LightBattle:markAsFinished(action, keep_animation)
    if self:getState() ~= "BATTLETEXT" then
        self:finishAction(action, keep_animation)
    else
        self.on_finish_keep_animation = keep_animation
        self.on_finish_action = action
        self.should_finish_action = true
    end
end

function LightBattle:finishAction(action, keep_animation)
    action = action or self.current_actions[self.current_action_index]

    local battler = self.party[action.character_id]

    self.processed_action[action] = true

    if self.processing_action == action then
        self.processing_action = nil
    end

    local all_processed = self:allActionsDone()

    if all_processed then
        for _,iaction in ipairs(Utils.copy(self.current_actions)) do
            local ibattler = self.party[iaction.character_id]

            local party_num = 1
            local callback = function()
                party_num = party_num - 1
                if party_num == 0 then
                    Utils.removeFromTable(self.current_actions, iaction)
                    self:tryProcessNextAction()
                end
            end

            if iaction.party then
                for _,party in ipairs(iaction.party) do
                    local jbattler = self.party[self:getPartyIndex(party)]

                    if jbattler ~= ibattler then
                        party_num = party_num + 1

                        local dont_end = false
                        if (keep_animation) then
                            if Utils.containsValue(keep_animation, party) then
                                dont_end = true
                            end
                        end

                        if not dont_end then
                            self:endActionAnimation(jbattler, iaction, callback)
                        else
                            callback()
                        end
                    end
                end
            end


            local dont_end = false
            if (keep_animation) then
                if Utils.containsValue(keep_animation, ibattler.chara.id) then
                    dont_end = true
                end
            end

            if not dont_end then
                self:endActionAnimation(ibattler, iaction, callback)
            else
                callback()
            end

            if iaction.action == "DEFEND" then
                ibattler.defending = false
            end

            Kristal.callEvent("onBattleActionEnd", iaction, iaction.action, ibattler, iaction.target, dont_end)
        end
    else
        -- Process actions if we can
        self:tryProcessNextAction()
    end
end

function LightBattle:onStateChange(old,new)
    if self.encounter.beforeStateChange then
        local result = self.encounter:beforeStateChange(old,new)
        if result or self.state ~= new then
            return
        end
    end

    if new == "ACTIONSELECT" then
        self.arena.layer = BATTLE_LAYERS["ui"] - 1

        if not self.soul then
            self:spawnSoul()
        end

        self.soul.can_move = false

        if self.current_selecting < 1 or self.current_selecting > #self.party then
            self:nextTurn()
            if self.state ~= "ACTIONSELECT" then
                return
            end
        end
        
        self.fader:fadeIn(function()
            self.soul.layer = BATTLE_LAYERS["soul"]        
        end, {speed=5/30})

        self.battle_ui.encounter_text.text.line_offset = 5
        self.battle_ui:clearEncounterText()
        self.battle_ui.encounter_text:setText("[noskip][wait:1][noskip:false]" ..self.battle_ui.current_encounter_text)

        self.battle_ui.encounter_text.debug_rect = { -30, -12, SCREEN_WIDTH + 1, 124 }

        local had_started = self.started
        if not self.started then
            self.started = true

            if self.encounter.music then
                self.music:play(self.encounter.music)
            end
        end

        if not had_started then
            for _,party in ipairs(self.party) do
                party.chara:onTurnStart()
            end
            local party = self.party[self.current_selecting]
            party.chara:onActionSelect(party, false)
            self.encounter:onCharacterTurn(party, false)
        end

        if self.battle_ui.help_window then
            self.battle_ui.help_window:toggleVisibility(true)
        end
    elseif new == "BUTNOBODYCAME" then
        if not self.soul then
            self:spawnSoul()
        end

        self.soul.can_move = false
        
        self.fader:fadeIn(nil, {speed=5/30})

        self.battle_ui.encounter_text.text.line_offset = 5
        self.battle_ui:clearEncounterText()
        self.battle_ui.encounter_text:setText("[noskip][wait:1][noskip:false]"..self.battle_ui.current_encounter_text)

        self.battle_ui.encounter_text.debug_rect = { -30, -12, SCREEN_WIDTH + 1, 124 }

        local had_started = self.started
        if not self.started then
            self.started = true

            if self.encounter.music then
                self.music:play(self.encounter.music)
            end
        end

    elseif new == "ACTIONS" then
        self.battle_ui:clearEncounterText()
        if self.state_reason ~= "DONTPROCESS" then
            self:tryProcessNextAction()
        end
    elseif new == "MENUSELECT" then
        if self.battle_ui.help_window then
            self.battle_ui.help_window:setTension(0)
        end
        self.battle_ui:clearEncounterText()

        if self.state_reason == "ACT" then
            self.current_menu_columns = 2
            self.current_menu_rows = 3
        end

        if self.menuselect_cursor_memory[self.state_reason] then
            self.current_menu_x = self.menuselect_cursor_memory[self.state_reason].x
            self.current_menu_y = self.menuselect_cursor_memory[self.state_reason].y
        else
            self.current_menu_x = 1
            self.current_menu_y = 1
        end

        if not self:isValidMenuLocation() then
            self.current_menu_x = 1
            self.current_menu_y = 1
        end
    elseif new == "ENEMYSELECT" then
        self.battle_ui:clearEncounterText()

        if self.enemyselect_cursor_memory[self.state_reason] then
            self.current_menu_x = 1
            self.current_menu_y = self.enemyselect_cursor_memory[self.state_reason] or 1
        else
            self.current_menu_x = 1
            self.current_menu_y = 1
        end

        if not self:isValidMenuLocation() then
            repeat
                if not self.enemies[self.current_menu_y] then
                    self.current_menu_y = 1
                    break
                end
                self.current_menu_y = self.current_menu_y + 1
            until(self:isValidMenuLocation())
        end

    elseif new == "PARTYSELECT" then
        self.battle_ui:clearEncounterText()

        if self.partyselect_cursor_memory[self.state_reason] then
            self.current_menu_x = 1
            self.current_menu_y = self.partyselect_cursor_memory[self.state_reason]
        else
            self.current_menu_x = 1
            self.current_menu_y = 1
        end

    elseif new == "ATTACKING" then
        self.battle_ui:clearEncounterText()

        local enemies_left = self:getActiveEnemies()

        if #enemies_left > 0 then
            for i,battler in ipairs(self.party) do
                local action = self.character_actions[i]
                if action and action.action == "ATTACK" then
                    self:beginAction(action)
                    table.insert(self.attackers, battler)
                    table.insert(self.normal_attackers, battler)
                elseif action and action.action == "AUTOATTACK" then
                    table.insert(self.attackers, battler)
                    table.insert(self.auto_attackers, battler)
                end
            end
        end

        self.auto_attack_timer = 0

        if #self.attackers == 0 then
            self.attack_done = true
            self:setState("ACTIONSDONE")
        else
            self.attack_done = false
        end

    elseif new == "ENEMYDIALOGUE" then
        if self.battle_ui.help_window then
            self.battle_ui.help_window:toggleVisibility(false)
        end

        self.current_selecting = 0
        self.battle_ui:clearEncounterText()
        self.textbox_timer = 3 * 30
        self.use_textbox_timer = true
        local active_enemies = self:getActiveEnemies()
        if #active_enemies == 0 then
            self:setState("VICTORY")
        else

            if self.state_reason then
                self:setWaves(self.state_reason)
                local enemy_found = false
                for i,enemy in ipairs(self.enemies) do
                    if Utils.containsValue(enemy.waves, self.state_reason[1]) then
                        enemy.selected_wave = self.state_reason[1]
                        enemy_found = true
                    end
                end
                if not enemy_found then
                    self.enemies[love.math.random(1, #self.enemies)].selected_wave = self.state_reason[1]
                end
            else
                self:setWaves(self.encounter:getNextWaves(), true)
            end

            local soul_x, soul_y, soul_offset_x, soul_offset_y
            local arena_x, arena_y, arena_w, arena_h, arena_shape
            local has_arena = false
            local has_soul = false
            for _,wave in ipairs(self.waves) do
                soul_x = wave.soul_start_x or soul_x
                soul_y = wave.soul_start_y or soul_y
                soul_offset_x = wave.soul_offset_x or soul_offset_x
                soul_offset_y = wave.soul_offset_y or soul_offset_y
                arena_x = wave.arena_x or arena_x or self.arena.home_x
                arena_y = wave.arena_y or arena_y or self.arena.home_y
                arena_w = wave.arena_width and math.max(wave.arena_width, arena_w or 0) or arena_w
                arena_h = wave.arena_height and math.max(wave.arena_height, arena_h or 0) or arena_h
                if wave.arena_shape then
                    arena_shape = wave.arena_shape
                end
                if wave.has_arena then
                    has_arena = true
                end
                if wave.has_soul then
                    has_soul = true
                end
            end
    
            local center_x, center_y
    
            if has_arena then
                
                if not arena_shape then
                    arena_w, arena_h = arena_w or 160, arena_h or 130
                    arena_x, arena_y = self.arena.home_x, self.arena.home_y
                    arena_shape = {{0, 0}, {arena_w, 0}, {arena_w, arena_h}, {0, arena_h}}
                end

                if self.encounter.story then
                    self.arena:setSize(arena_w, arena_h)
                else
                    self.arena:changeShape({arena_w, self.arena.height})
                end

                center_x, center_y = self.arena:getCenter()
            else
                center_x, center_y = SCREEN_WIDTH/2, (SCREEN_HEIGHT - 155)/2 --+ 10
            end
    
            if has_soul then
                self.timer:after(2/30, function() -- ut has a 5 frame window where the soul isn't in the arena
                    soul_x = soul_x or (soul_offset_x and center_x + soul_offset_x)
                    soul_y = soul_y or (soul_offset_y and center_y + soul_offset_y)
                    self.soul:setPosition(soul_x or center_x, soul_y or center_y)
                    self:toggleSoul(true)
                    self.soul.can_move = false
                end)
            end

            for _,enemy in ipairs(active_enemies) do
                enemy.current_target = enemy:getTarget()
            end
            local cutscene_args = {self.encounter:getDialogueCutscene()}
            if #cutscene_args > 0 then
                self:startCutscene(unpack(cutscene_args)):after(function()
                    self:setState("DIALOGUEEND")
                end)
            else
                local any_dialogue = false
                for _,enemy in ipairs(active_enemies) do
                    local dialogue = enemy:getEnemyDialogue()
                    if dialogue then
                        any_dialogue = true
                        local bubble = enemy:spawnSpeechBubble(dialogue, {no_sound_overlap = true})
                        bubble:setSkippable(false)
                        bubble:setAdvance(false)
                        table.insert(self.enemy_dialogue, bubble)
                    end
                end
                if not any_dialogue then
                    self:setState("DIALOGUEEND")
                end
            end
        end
    elseif new == "DIALOGUEEND" then
        self.battle_ui:clearEncounterText()

        for i,battler in ipairs(self.party) do
            local action = self.character_actions[i]
            if action and action.action == "DEFEND" then
                self:beginAction(action)
                self:processAction(action)
            end
        end

        self.encounter:onDialogueEnd()
    elseif new == "DEFENDING" then
        self.arena.layer = BATTLE_LAYERS["arena"]

        self.wave_length = 0
        self.wave_timer = 0

        for _,wave in ipairs(self.waves) do
            wave.encounter = self.encounter

            self.wave_length = math.max(self.wave_length, wave.time)

            wave:onStart()

            wave.active = true
        end

        self.soul:onWaveStart()
    elseif new == "VICTORY" then
        self.music:stop()
        self.current_selecting = 0

        for _,battler in ipairs(self.party) do
            battler:setSleeping(false)
            battler.defending = false
            battler.action = nil

            battler.chara:resetBuffs()

            if battler.chara:getHealth() <= 0 then
                battler:revive()
                battler.chara:setHealth(battler.chara:autoHealAmount())
            end

        end

        self.money = self.encounter:getVictoryMoney(self.money) or self.money

        if self.tension_bar.visible then
            self.money = self.money + (math.floor((Game:getTension() * 2.5) / 20))
        end

        for _,battler in ipairs(self.party) do
            for _,equipment in ipairs(battler.chara:getEquipment()) do
                self.money = math.floor(equipment:applyMoneyBonus(self.money) or self.money)
            end
        end

        self.money = math.floor(self.money)

        self.xp = self.encounter:getVictoryXP(self.xp) or self.xp

        local win_text = "[noskip]* YOU WON!\n* You earned " .. self.xp .. " EXP and " .. self.money .. " " .. Game:getConfig("lightCurrency"):lower() .. "."

        Game.lw_money = Game.lw_money + self.money

        if (Game.lw_money < 0) then
            Game.lw_money = 0
        end

        for _,member in ipairs(self.party) do
            local lv = member.chara:getLightLV()
            member.chara:gainLightEXP(self.xp, true)

            if lv ~= member.chara:getLightLV() then
                win_text = "[noskip]* YOU WON!\n* You earned " .. self.xp .. " EXP and " .. self.money .. " " .. Game:getConfig("lightCurrency") .. ".\n* Your LOVE increased."
            end
        end

        win_text = self.encounter:getVictoryText(win_text, self.money, self.xp) or win_text

        if self.encounter.no_end_message then
            self:setState("TRANSITIONOUT")
            self.encounter:onBattleEnd()
        else
            self:battleText(win_text, function()
                self:setState("TRANSITIONOUT")
                self.encounter:onBattleEnd()
                return true
            end)
        end

    elseif new == "TRANSITIONOUT" then
        self.current_selecting = 0

        Game.fader:transition(function() self:returnToWorld() end, nil, {speed = 10/30})

    elseif new == "DEFENDINGBEGIN" then
        self.battle_ui:clearEncounterText()
    elseif new == "FLEEING" then
        self.current_selecting = 0

        for _,battler in ipairs(self.party) do
            battler:setSleeping(false)
            battler.defending = false
            battler.action = nil

            if battler.chara:getHealth() <= 0 then
                battler:revive()
                battler.chara:setHealth(battler.chara:autoHealAmount())
            end

            local box = self.battle_ui.action_boxes[self:getPartyIndex(battler.chara.id)]
        end

        self.encounter:onFlee()

    elseif new == "FLEEFAIL" then
        self:toggleSoul(false)
        self.current_selecting = 0

        local any_hurt = false
        for _,enemy in ipairs(self.enemies) do
            if enemy.hurt_timer > 0 then
                any_hurt = true
                break
            end
        end

        if not any_hurt then
            self.attackers = {}
            self.normal_attackers = {}
            self.auto_attackers = {}
            if self.battle_ui.attacking then
                self.battle_ui:endAttack()
            end

            self.encounter:onFleeFail()

            if not self.encounter:onActionsEnd() then
                self:setState("ACTIONSDONE")
            end
        end
        
    elseif new == "DEFENDINGEND" then
        if self.arena.height >= self.arena.init_height then
            self.arena:changePosition({self.arena.home_x, self.arena.home_y}, true,
            function()
                self.arena:changeShape({self.arena.width, self.arena.init_height},
                function()
                    self.arena:changeShape({self.arena.init_width, self.arena.height})
                end)
            end)
        else
            self.arena:changePosition({self.arena.home_x, self.arena.home_y}, true,
            function()
                self.arena:changeShape({self.arena.init_width, self.arena.height},
                function()
                    self.arena:changeShape({self.arena.width, self.arena.init_height})
                end)
            end)
        end
    end

    local should_end = true
    for _,wave in ipairs(self.waves) do
        if wave:beforeEnd() then
            should_end = false
        end
    end
    if should_end then
        for _,battler in ipairs(self.party) do
            battler.targeted = false
        end
    end

    if old == "DEFENDING" and new ~= "ENEMYDIALOGUE" and should_end then
        for _,wave in ipairs(self.waves) do
            if not wave:onEnd(false) then
                wave:clear()
                wave:remove()
            end
        end

        if self:hasCutscene() then
            self.cutscene:after(function()
                self:setState("TURNDONE", "WAVEENDED")
            end)
        else
            self.timer:after(15/30, function()
                self:setState("TURNDONE", "WAVEENDED")
            end)
        end
    end

    self.encounter:onStateChange(old,new)
end

function LightBattle:nextTurn()
  
    self.turn_count = self.turn_count + 1
    if self.turn_count > 1 then
        if self.encounter:onTurnEnd() then
            return
        end
        for _,party in ipairs(self.party) do
            if party.chara:onTurnEnd() then
                return
            end
        end
        for _,enemy in ipairs(self:getActiveEnemies()) do
            if enemy:onTurnEnd() then
                return
            end
        end
    end

    for _,action in ipairs(self.current_actions) do
        if action.action == "DEFEND" then
            self:finishAction(action)
        end
    end

    for _,enemy in ipairs(self.enemies) do
        enemy.selected_wave = nil
        enemy.hit_count = 0
    end

    for _,battler in ipairs(self.party) do
        battler.hit_count = 0
        if (battler.chara:getHealth() <= 0) and battler.chara:canAutoHeal() then
            battler:heal(battler.chara:autoHealAmount(), nil, true)
        end
        battler.action = nil
    end

    self.attackers = {}
    self.normal_attackers = {}
    self.auto_attackers = {}

    if self.state ~= "BUTNOBODYCAME" then
        self.current_selecting = 1
    end

    while not (self.party[self.current_selecting]:isActive()) do
        self.current_selecting = self.current_selecting + 1
        if self.current_selecting > #self.party then
            print("WARNING: nobody up! this shouldn't happen...")
            self.current_selecting = 1
            break
        end
    end

    self.current_button = 1

    self.character_actions = {}
    self.current_actions = {}
    self.processed_action = {}

    if self.battle_ui then
        for _,box in ipairs(self.battle_ui.action_boxes) do
            box.selected_button = box.last_button or 1
        end
        if not self.seen_encounter_text then
            self.seen_encounter_text = true
            self.battle_ui.current_encounter_text = self.encounter.text
        else
            self.battle_ui.current_encounter_text = self:getEncounterText()
        end
        self.battle_ui.encounter_text:setText(self.battle_ui.current_encounter_text)
    end

    self.encounter:onTurnStart()
    for _,enemy in ipairs(self:getActiveEnemies()) do
        enemy:onTurnStart()
    end

    if self.battle_ui then
        for _,party in ipairs(self.party) do
            party.chara:onTurnStart(party)
        end
    end

    if self.current_selecting ~= 0 then
        self:setState("ACTIONSELECT")
    end

    if self.encounter.getNextMenuWaves and #self.encounter:getNextMenuWaves() > 0 then
        self:setMenuWaves(self.encounter:getNextMenuWaves())

        for _,enemy in ipairs(self:getActiveEnemies()) do
            enemy.menu_wave_override = nil
        end
        self.menu_wave_length = 0
        self.menu_wave_timer = 0

        for _,wave in ipairs(self.menu_waves) do
            wave.encounter = self.encounter

            self.menu_wave_length = math.max(self.menu_wave_length, wave.time)

            wave:onStart()

            wave.active = true
        end

        self.soul:onMenuWaveStart()
    end

end

function LightBattle:canSelectMenuItem(menu_item)
    if menu_item.unusable then
        return false
    end
    if menu_item.tp and (menu_item.tp > Game:getTension()) then
        return false
    end
    if menu_item.party then
        for _,party_id in ipairs(menu_item.party) do
            local party_index = self:getPartyIndex(party_id)
            local battler = self.party[party_index]
            local action = self.character_actions[party_index]
            if (not battler) or (not battler:isActive()) or (action and action.cancellable == false) then
                -- They're either down, asleep, or don't exist. Either way, they're not here to do the action.
                return false
            end
        end
    end
    return true
end

function LightBattle:returnToWorld()
    if not Game:getConfig("keepTensionAfterBattle") then
        Game:setTension(0)
    end

    self.encounter:setFlag("done", true)
    local all_enemies = {}
    Utils.merge(all_enemies, self.defeated_enemies)
    Utils.merge(all_enemies, self.enemies)

    self.music:stop()
    if self.resume_world_music then
        Game.world.music:resume()
    end
    self:remove()
    self.encounter.defeated_enemies = self.defeated_enemies
    Game.battle = nil
    Game.state = "OVERWORLD"

    Game:setFlag("current_battle_system#", nil)

    if Game:getFlag("temporary_world_value#") == "dark" then
        Game:setLight(false)
        MagicalGlassLib:loadStorageAndEquips()
        Game:setFlag("temporary_world_value#", nil)
    end
end

function LightBattle:setActText(text, dont_finish)
    self:battleText(text, function()
        if not dont_finish then
            self:finishAction()
        end
        if self.should_finish_action then
            self:finishAction(self.on_finish_action, self.on_finish_keep_animation)
            self.on_finish_action = nil
            self.on_finish_keep_animation = nil
            self.should_finish_action = false
        end
        self:setState("ACTIONS", "BATTLETEXT")
        return true
    end)
end

function LightBattle:shortActText(text)
    self:toggleSoul(false)
    local advances = 3 --initial override so we can run it
    local function recurseiveSHAT()
        advances = advances + 1
        if(advances >= 3) then
            self.battle_ui:clearEncounterText()
            advances = 0
        
            local t1, t2, t3 = table.remove(text,1), table.remove(text,1), table.remove(text,1)
            local text_exhausted = not (t1 and t2 and t3) or #text == 0
            local opt_shat = (not text_exhausted) and recurseiveSHAT
            self.battle_ui.short_act_text_1:setText(t1 or "",  opt_shat)
            self.battle_ui.short_act_text_2:setText(t2 or "",  opt_shat)
            self.battle_ui.short_act_text_3:setText(t3 or "",  opt_shat)

            if(text_exhausted) then
                --this controls wheter or not we can advance to the next line?
                self:setState("SHORTACTTEXT")
            end
        end
    end
    
    recurseiveSHAT()
end

function LightBattle:hurt(amount, exact)
    if self.player then
        self.player.health = self.player.health - amount
    end
    self:checkGameOver()
end

function LightBattle:checkGameOver()
    for _,battler in ipairs(self.party) do
        if not battler.is_down then
            return
        end
    end
    self.music:stop()
    if self:getState() == "DEFENDING" then
        for _,wave in ipairs(self.waves) do
            wave:onEnd(true)
        end
    end
    if self.encounter:onGameOver() then
        return
    end
    Game:gameOver(self:getSoulLocation())
end

function LightBattle:battleText(text,post_func)
    local target_state = self:getState()
    self.battle_ui.encounter_text.text.line_offset = 4 -- toby jesus christ

    self.battle_ui.encounter_text:setText(text, function()
        self.battle_ui:clearEncounterText()
        if type(post_func) == "string" then
            target_state = post_func
        elseif type(post_func) == "function" and post_func() then
            return
        end
        self:setState(target_state)
    end)

    if self.state ~= "FLEEING" and self.soul then
        self:toggleSoul(false)
    end

    self.battle_ui.encounter_text:setAdvance(true)
    self:setState("BATTLETEXT")
end

function LightBattle:infoText(text)
    self.battle_ui.encounter_text:setText(text or "")
end

function LightBattle:hasCutscene()
    return self.cutscene and not self.cutscene.ended
end

function LightBattle:startCutscene(group, id, ...)
    if not self.encounter.story then
        self:toggleSoul(false)
    end

    if self.cutscene then
        local cutscene_name = ""
        if type(group) == "string" then
            cutscene_name = group
            if type(id) == "string" then
                cutscene_name = group.."."..id
            end
        elseif type(group) == "function" then
            cutscene_name = "<function>"
        end
        error("Attempt to start a cutscene "..cutscene_name.." while already in cutscene "..self.cutscene.id)
    end
    self.cutscene = BattleCutscene(group, id, ...)
    return self.cutscene
end

function LightBattle:startActCutscene(group, id, dont_finish)
    local action = self:getCurrentAction()
    local cutscene
    if type(id) ~= "string" then
        dont_finish = id
        cutscene = self:startCutscene(group, self.party[action.character_id], action.target)
    else
        cutscene = self:startCutscene(group, id, self.party[action.character_id], action.target)
    end
    return cutscene:after(function()
        if not dont_finish then
            self:finishAction(action)
        end
        self:setState("ACTIONS", "CUTSCENE")
    end)
end

function LightBattle:sortChildren()
    -- Sort battlers by Y position
    table.stable_sort(self.children, function(a, b)
        return a.layer < b.layer or (a.layer == b.layer and (a:includes(Battler) and b:includes(Battler)) and a.y < b.y)
    end)
end

function LightBattle:update()
    self.tension_bar.visible = self.tension

    if self.cutscene then
        if not self.cutscene.ended then
            self.cutscene:update()
        else
            self.cutscene = nil
        end
    end
    if Game.battle == nil then return end -- cutscene ended the battle

    if self.state == "ATTACKING" then
        self:updateAttacking()
    elseif self.state == "ACTIONSDONE" then
        self.actions_done_timer = Utils.approach(self.actions_done_timer, 0, DT)
        local any_hurt = false
        for _,enemy in ipairs(self.enemies) do
            if enemy.hurt_timer > 0 then
                any_hurt = true
                break
            end
        end
        if not any_hurt then
            self.attackers = {}
            self.normal_attackers = {}
            self.auto_attackers = {}
            if self.battle_ui.attacking then
                self.battle_ui:endAttack()
            end
            if not self.encounter:onActionsEnd() then
                self:setState("ENEMYDIALOGUE")
            end
        elseif self.actions_done_timer == 0 and not any_hurt then
            self.attackers = {}
            self.normal_attackers = {}
            self.auto_attackers = {}
            if self.battle_ui.attacking then
                self.battle_ui:endAttack()
            end
            if not self.encounter:onActionsEnd() then
                self:setState("ENEMYDIALOGUE")
            end
        end
    elseif self.state == "ENEMYDIALOGUE" then
        self.textbox_timer = self.textbox_timer - DTMULT
        if (self.textbox_timer <= 0) and self.use_textbox_timer then
            self:advanceBoxes()
        else
            local all_done = true
            local boxes_done = true

            for _,textbox in ipairs(self.enemy_dialogue) do
                if textbox:isTyping() then
                    boxes_done = false
                end
            end

            for _,textbox in ipairs(self.enemy_dialogue) do
                if boxes_done then
                    textbox:setAdvance(true)
                end
            end

            for _,textbox in ipairs(self.enemy_dialogue) do
                if not textbox:isDone() then
                    all_done = false
                    break
                end
            end

            if all_done then
                self:setState("DIALOGUEEND")
            end
        end
    elseif self.state == "DEFENDINGBEGIN" then
        if self.arena:isNotTransitioning() then

            local soul_x, soul_y, soul_offset_x, soul_offset_y
            local arena_x, arena_y, arena_h, arena_shape
            local has_arena = true
            for _,wave in ipairs(self.waves) do
                soul_x = wave.soul_start_x or soul_x
                soul_y = wave.soul_start_y or soul_y
                soul_offset_x = wave.soul_offset_x or soul_offset_x
                soul_offset_y = wave.soul_offset_y or soul_offset_y
                arena_x = wave.arena_x or arena_x
                arena_y = wave.arena_y or arena_y
                arena_h = wave.arena_height and math.max(wave.arena_height, arena_h or 0) or arena_h
                if wave.arena_shape then
                    arena_shape = wave.arena_shape
                end
                if not wave.has_arena then
                    has_arena = false
                end
            end

            if not arena_shape then
                arena_w, arena_h = arena_w or 160, arena_h or 130
            end
            local center_x, center_y = self.arena:getCenter()

            if has_arena and self.arena.height ~= arena_h then
                self.arena:changeShape({self.arena.width, arena_h})
            end

            if has_arena and not (self.arena.x == arena_x and self.arena.y == arena_y) then
                self.arena:changePosition({arena_x, arena_y})
            end

        end

        if self.arena:isNotTransitioning() then
            self.soul.can_move = true
            self:setState("DEFENDING") 
        end
    elseif self.state == "DEFENDING" then
        local darken = false
        local time
        for _,wave in ipairs(self.waves) do
            if wave.darken then
                darken = true
                time = wave.time
            end
        end

        if darken and self.wave_timer <= time - 9/30 then
            self.darkify_fader.alpha = Utils.approach(self.darkify_fader.alpha, 0.5, DTMULT * 0.05)
        else
            self.darkify_fader.alpha = Utils.approach(self.darkify_fader.alpha, 0, DTMULT * 0.05)
        end

        self:updateWaves()
    elseif self.state == "ACTIONSELECT" then
        local actbox = self.battle_ui.action_boxes[self.current_selecting]
        if actbox then
            actbox:snapSoulToButton()
        end
    elseif self.state == "TURNDONE" then
        for _,wave in ipairs(self.waves) do
            wave:onArenaExit()
        end
        self.waves = {}

        if self.state_reason == "WAVEENDED" and #self.arena.target_position == 0 and #self.arena.target_shape == 0 and not self.forced_victory then
            self:nextTurn()
        end
    end

    if self.state ~= "TRANSITIONOUT" then
        self.encounter:update()
    end

    local update_menu_waves = {"ACTIONSELECT", "MENUSELECT", "ENEMYSELECT", "PARTYSELECT", "FLEEING", "FLEEFAIL"}

    if Utils.containsValue(update_menu_waves, self.state) then
        self:updateMenuWaves()
    end
    
    if Utils.containsValue({"DEFENDINGEND", "ACTIONSELECT", "ACTIONS", "VICTORY", "TRANSITIONOUT", "BATTLETEXT"}, self.state) then
        self.darkify_fader.alpha = Utils.approach(self.darkify_fader.alpha, 0, DTMULT * 0.05)
    end
    
    self.update_child_list = true
    super.update(self)

end

function LightBattle:updateChildren()
    if self.update_child_list then
        self:updateChildList()
        self.update_child_list = false
    end
    for _,v in ipairs(self.draw_fx) do
        v:update()
    end
    for _,v in ipairs(self.children) do
        if v.active and v.parent == self and Game.battle == self then
            v:fullUpdate()
        end
    end
end

function LightBattle:updateAttacking()
    if self.cancel_attack then
        self:finishAllActions()
        self:setState("ACTIONSDONE")
    end

    if not self.attack_done then
        if not self.battle_ui.attacking then
            self:toggleSoul(false)
            self.battle_ui:beginAttack()
        end

        if #self.attackers == #self.auto_attackers and self.auto_attack_timer < 4 then
            self.auto_attack_timer = self.auto_attack_timer + DTMULT

            if self.auto_attack_timer >= 4 then
                local next_attacker = self.auto_attackers[1]

                local next_action = self:getActionBy(next_attacker)
                if next_action then
                    self:beginAction(next_action)
                    self:processAction(next_action)
                end
            end
        end
        
        local all_done = true

        for _,attacker in ipairs(self.battle_ui.attack_box.lanes) do
            if not attacker.attacked then
                local box = self.battle_ui.attack_box
                if box:checkMiss(attacker) and #attacker.bolts > 1 then

                    all_done = false
                    box:miss(attacker)

                elseif box:checkMiss(attacker) then
                    local points = box:miss(attacker)
                    local stretch = 2

                    local action = self:getActionBy(attacker.battler)
                    if attacker.attack_type == "slice" then
                        action.force_miss = true
                        action.points = points or 0
                        action.stretch = 0
                    else
                        action.points = points
                    end

                    if self:processAction(action) then
                        self:finishAction(action)
                    end
                else
                    all_done = false
                end
            end
        end

        if #self.battle_ui.attack_box.lanes ~= 0 and all_done then
            self.attack_done = true
        end
    else
        if self:allActionsDone() then
            self:setState("ACTIONSDONE")
        end
    end
end

function LightBattle:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)

    if self.encounter.background then
        self.encounter:drawBackground()
    end

    super:draw(self)

    self.encounter:draw()

    if DEBUG_RENDER then
        self:drawDebug()
    end
end

function LightBattle:getItemIndex()
    local page = math.ceil(self.current_menu_x / self.current_menu_columns) - 1
    return (self.current_menu_columns * (self.current_menu_y - 1) + (self.current_menu_x + (page * 2)))
end

function LightBattle:isValidMenuLocation()
    if self.state == "MENUSELECT" then
        if self:getItemIndex() > #self.menu_items then
            return false
        end
        if (self.current_menu_y > self.current_menu_rows) or (self.current_menu_y < 1) then
            return false
        end
        if not self:isPagerMenu() and (self.current_menu_x > self.current_menu_columns) then
            return false
        end
    elseif self.state == "ENEMYSELECT" then
        if self.current_menu_y > #self.enemies then
            return false
        elseif self.enemies[self.current_menu_y].done_state then
            return false
        end
    end
    return true
end

function LightBattle:advanceBoxes()
    local all_done = true
    local to_remove = {}

    for _,dialogue in ipairs(self.enemy_dialogue) do
        if dialogue:isTyping() then
            all_done = false
            break
        end
    end

    if all_done then
        self.textbox_timer = 3 * 30
        self.use_textbox_timer = true
        for _,dialogue in ipairs(self.enemy_dialogue) do
            dialogue:advance()
            if not dialogue:isDone() then
                all_done = false
            else
                table.insert(to_remove, dialogue)
            end
        end
    end

    for _,dialogue in ipairs(to_remove) do
        if #self.arena.target_shape == 0 then
            Utils.removeFromTable(self.enemy_dialogue, dialogue)
        end
    end

    if all_done then
        self:setState("DIALOGUEEND")
    end
end

function LightBattle:endActionAnimation(battler, action, callback)
local _callback = callback
    callback = function()
        if battler.action then
            battler.action.icon = nil
        end
        local box = self.battle_ui.action_boxes[self:getPartyIndex(battler.chara.id)]
        if _callback then
            _callback()
        end
    end
    if Kristal.callEvent("onBattleActionEndAnimation", action, action.action, battler, action.target, callback, _callback) then
        return
    end
    callback()
end

function LightBattle:pushForcedAction(battler, action, target, data, extra)
    data = data or {}

    data.cancellable = false

    self:pushAction(action, target, data, self:getPartyIndex(battler.chara.id), extra)
end

function LightBattle:pushAction(action_type, target, data, character_id, extra)
    character_id = character_id or self.current_selecting

    local battler = self.party[character_id]

    local current_state = self:getState()

    self:commitAction(battler, action_type, target, data, extra)

    if self.current_selecting == character_id then
        if current_state == self:getState() then
            self:nextParty()
        elseif self.cutscene then
            self.cutscene:after(function()
                self:nextParty()
            end)
        end
    end
end

function LightBattle:commitAction(battler, action_type, target, data, extra)
    data = data or {}
    extra = extra or {}

    local is_xact = action_type:upper() == "XACT"
    if is_xact then
        action_type = "ACT"
    end

    local tp_diff = 0
    if data.tp then
        tp_diff = Utils.clamp(-data.tp, -Game:getTension(), Game:getMaxTension() - Game:getTension())
    end

    local party_id = self:getPartyIndex(battler.chara.id)

    if not battler:isActive() then return end

    if data.party then
        for _,v in ipairs(data.party) do
            local index = self:getPartyIndex(v)

            if index ~= party_id then
                local action = self.character_actions[index]
                if action then
                    if action.cancellable == false then
                        return
                    end
                    if action.act_parent then
                        local parent_action = self.character_actions[action.act_parent]
                        if parent_action.cancellable == false then
                            return
                        end
                    end
                end
            end
        end
    end

    self:commitSingleAction(Utils.merge({
        ["character_id"] = party_id,
        ["action"] = action_type:upper(),
        ["party"] = data.party,
        ["name"] = data.name,
        ["target"] = target,
        ["data"] = data.data,
        ["tp"] = tp_diff,
        ["cancellable"] = data.cancellable,
    }, extra))

    if data.party then
        for _,v in ipairs(data.party) do
            local index = self:getPartyIndex(v)

            if index ~= party_id then
                local action = self.character_actions[index]
                if action then
                    if action.act_parent then
                        self:removeAction(action.act_parent)
                    else
                        self:removeAction(index)
                    end
                end

                self:commitSingleAction(Utils.merge({
                    ["character_id"] = index,
                    ["action"] = "SKIP",
                    ["reason"] = action_type:upper(),
                    ["name"] = data.name,
                    ["target"] = target,
                    ["data"] = data.data,
                    ["act_parent"] = party_id,
                    ["cancellable"] = data.cancellable,
                }, extra))
            end
        end
    end
end

function LightBattle:commitSingleAction(action)
    local battler = self.party[action.character_id]

    battler.action = action
    self.character_actions[action.character_id] = action

    if Kristal.callEvent("onBattleActionCommit", action, action.action, battler, action.target) then
        return
    end

    if action.action == "ITEM" and action.data then
        local result = action.data:onBattleSelect(battler, action.target)
        if result ~= false then
            local storage, index = Game.inventory:getItemIndex(action.data)

            action.item_storage = storage
            action.item_index = index
            if action.data:hasResultItem() then
                local result_item = action.data:createResultItem()
                Game.inventory:setItem(storage, index, result_item)
                action.result_item = result_item
            else
                Game.inventory:removeItem(action.data)
            end
            action.consumed = true
        else
            action.consumed = false
        end
    end

    local anim = action.action:lower()
    if action.action == "SPELL" and action.data then
        local result = action.data:onSelect(battler, action.target)
        if result ~= false then
            if action.tp then
                if action.tp > 0 then
                    Game:giveTension(action.tp)
                elseif action.tp < 0 then
                    Game:removeTension(-action.tp)
                end
            end
            action.icon = anim
        end
    else
        if action.tp then
            if action.tp > 0 then
                Game:giveTension(action.tp)
            elseif action.tp < 0 then
                Game:removeTension(-action.tp)
            end
        end

        if action.action == "SKIP" and action.reason then
            anim = action.reason:lower()
        end

        if (action.action == "ITEM" and action.data and (not action.data.instant)) or (action.action ~= "ITEM") then
            action.icon = anim
        end
    end
end

function LightBattle:removeAction(character_id)
    local action = self.character_actions[character_id]

    if action then
        self:removeSingleAction(action)

        if action.party then
            for _,v in ipairs(action.party) do
                if v ~= character_id then
                    local iaction = self.character_actions[self:getPartyIndex(v)]
                    if iaction then
                        self:removeSingleAction(iaction)
                    end
                end
            end
        end
    end
end

function LightBattle:removeSingleAction(action)
    local battler = self.party[action.character_id]

    if Kristal.callEvent("onBattleActionUndo", action, action.action, battler, action.target) then
        battler.action = nil
        self.character_actions[action.character_id] = nil
        return
    end

    battler:resetSprite()

    if action.tp then
        if action.tp < 0 then
            Game:giveTension(-action.tp)
        elseif action.tp > 0 then
            Game:removeTension(action.tp)
        end
    end

    if action.action == "ITEM" and action.data and action.item_index then
        if action.consumed then
            if action.result_item then
                Game.inventory:setItem(action.item_storage, action.item_index, action.data)
            else
                Game.inventory:addItemTo(action.item_storage, action.item_index, action.data)
            end
        end
        action.data:onBattleDeselect(battler, action.target)
    elseif action.action == "SPELL" and action.data then
        action.data:onDeselect(battler, action.target)
    end

    battler.action = nil
    self.character_actions[action.character_id] = nil
end

function LightBattle:isHighlighted(battler)
    return false
end

function LightBattle:getPartyIndex(string_id)
    for index, battler in ipairs(self.party) do
        if battler.chara.id == string_id then
            return index
        end
    end
    return nil
end

function LightBattle:getPartyBattler(string_id)
    for _, battler in ipairs(self.party) do
        if battler.chara.id == string_id then
            return battler
        end
    end
    return nil
end

function LightBattle:getEnemyBattler(string_id)
    for _, enemy in ipairs(self.enemies) do
        if enemy.id == string_id then
            return enemy
        end
    end
end

function LightBattle:getEnemyFromCharacter(chara)
    for _, enemy in ipairs(self.enemies) do
        if self.enemy_world_characters[enemy] == chara then
            return enemy
        end
    end
    for _, enemy in ipairs(self.defeated_enemies) do
        if self.enemy_world_characters[enemy] == chara then
            return enemy
        end
    end
end

function LightBattle:hasAction(character_id)
    return self.character_actions[character_id] ~= nil
end

function LightBattle:getActiveParty()
    return Utils.filter(self.party, function(party) return not party.is_down end)
end

function LightBattle:getActiveEnemies()
    return Utils.filter(self.enemies, function(enemy) return not enemy.done_state end)
end

function LightBattle:shakeCamera(x, y, friction)
    self.camera:shake(x, y, friction)
end

function LightBattle:randomTargetOld()
    local none_targetable = true
    for _,battler in ipairs(self.party) do
        if battler:canTarget() then
            none_targetable = false
            break
        end
    end

    if none_targetable then
        return "ALL"
    end

    local target = nil
    while not target do
        local party = Utils.pick(self.party)
        if party:canTarget() then
            target = party
        end
    end

    target.should_darken = false
    target.darken_timer = 0
    target.targeted = true
    return target
end

function LightBattle:randomTarget()
    local target = self:randomTargetOld()

    if (not Game:getConfig("targetSystem")) and (target ~= "ALL") then
        for _,battler in ipairs(self.party) do
            if battler:canTarget() then
                battler.targeted = true
            end
        end
        return "ANY"
    end

    return target
end

function LightBattle:targetAll()
    for _,battler in ipairs(self.party) do
        if battler:canTarget() then
            battler.targeted = true
        end
    end
    return "ALL"
end

function LightBattle:targetAny()
    for _,battler in ipairs(self.party) do
        if battler:canTarget() then
            battler.targeted = true
        end
    end
    return "ANY"
end

function LightBattle:target(target)
    -- only used in dt mode
    if type(target) == "number" then
        target = self.party[target]
    end

    if target and target:canTarget() then
        target.targeted = true
        return target
    end

    return self:targetAny()
end

function LightBattle:getPartyFromTarget(target)
    if type(target) == "number" then
        return {self.party[target]}
    elseif isClass(target) then
        return {target}
    elseif type(target) == "string" then
        if target == "ANY" then
            return {Utils.pick(self.party)}
        elseif target == "ALL" then
            return Utils.copy(self.party)
        else
            for _,battler in ipairs(self.party) do
                if battler.chara.id == string.lower(target) then
                    return {battler}
                end
            end
        end
    end
end

function LightBattle:hurt(amount, exact, target)
    -- Note: 0, 1 and 2 are to target a specific party member.
    -- In Kristal, we'll allow them to be objects as well.
    -- Also in Kristal, they're 1, 2 and 3.
    -- 3 is "ALL" in Kristal,
    -- while 4 is "ANY".
    target = target or "ANY"

    -- Alright, first let's try to adjust targets.

    if type(target) == "number" then
        target = self.party[target]
    end

    if isClass(target) and (target:includes(PartyBattler) or target:includes(LightPartyBattler)) then
        if (not target) or (target.chara:getHealth() <= 0) then -- Why doesn't this look at :canTarget()? Weird.
            target = self:randomTargetOld()
        end
    end

    if target == "ANY" then
        target = self:randomTargetOld()

        local party_average_hp = 1

        for _,battler in ipairs(self.party) do
            if battler.chara:getHealth() ~= battler.chara:getStat("health") then
                party_average_hp = 0
                break
            end
        end

        if target.chara:getHealth() / target.chara:getStat("health") < (party_average_hp / 2) then
            target = self:randomTargetOld()
        end
        if target.chara:getHealth() / target.chara:getStat("health") < (party_average_hp / 2) then
            target = self:randomTargetOld()
        end

        if (target == self.party[1]) and ((target.chara:getHealth() / target.chara:getStat("health")) < 0.35) then
            target = self:randomTargetOld()
        end

        target.should_darken = false
        target.targeted = true
    end

    if isClass(target) and target:includes(LightPartyBattler) then
        target:hurt(amount, exact)
        return {target}
    end

    if target == "ALL" then
        Assets.playSound("hurt")
        for _,battler in ipairs(self.party) do
            if not battler.is_down then
                battler:hurt(amount, exact, nil, {all = true})
            end
        end

        return Utils.filter(self.party, function(item) return not item.is_down end)
    end
end

function LightBattle:clearWaves()
    for _,wave in ipairs(self.waves) do
        if wave.auto_clear then
            wave:onEnd(false)
            wave:clear()
            wave:remove()
        end
    end
    self.waves = {}
end

function LightBattle:clearMenuWaves()
    for _,wave in ipairs(self.menu_waves) do
        if wave.auto_clear then
            wave:onEnd(false)
            wave:clear()
            wave:remove()
        end
    end
    self.menu_waves = {}
end

function LightBattle:setWaves(waves, allow_duplicates)
    self:clearWaves()
    self:clearMenuWaves()
    self.finished_waves = false
    local added_wave = {}
    for _,wave in ipairs(waves) do
        local exists = (type(wave) == "string" and added_wave[wave]) or (isClass(wave) and added_wave[wave.id])
        if allow_duplicates or not exists then
            if type(wave) == "string" then
                wave = Registry.createWave(wave)
            end
            wave.encounter = self.encounter
            self:addChild(wave)
            table.insert(self.waves, wave)
            added_wave[wave.id] = true

            wave.active = false
        end
    end
    return self.waves
end

function LightBattle:setMenuWaves(waves, allow_duplicates)
    self:clearWaves()
    self:clearMenuWaves()
    self.finished_menu_waves = false
    local added_wave = {}
    for _,wave in ipairs(waves) do
        local exists = (type(wave) == "string" and added_wave[wave]) or (isClass(wave) and added_wave[wave.id])
        if allow_duplicates or not exists then
            if type(wave) == "string" then
                wave = Registry.createWave(wave)
            end
            wave.encounter = self.encounter
            self:addChild(wave)
            table.insert(self.menu_waves, wave)
            added_wave[wave.id] = true

            wave.active = false
        end
    end
    return self.menu_waves
end

function LightBattle:startProcessing()
    self.has_acted = false
    if not self.encounter:onActionsStart() then
        self:setState("ACTIONS")
    end
end

function LightBattle:setSelectedParty(index)
    self.current_selecting = index or 0
end

function LightBattle:nextParty()
    table.insert(self.selected_character_stack, self.current_selecting)
    table.insert(self.selected_action_stack, Utils.copy(self.character_actions))

    local all_done = true
    local last_selected = self.current_selecting
    self.current_selecting = (self.current_selecting % #self.party) + 1
    while self.current_selecting ~= last_selected do
        if not self:hasAction(self.current_selecting) and self.party[self.current_selecting]:isActive() then
            all_done = false
            break
        end
        self.current_selecting = (self.current_selecting % #self.party) + 1
    end

    if all_done then
        self.selected_character_stack = {}
        self.selected_action_stack = {}
        self.current_action_processing = 1
        self.current_selecting = 0
        self:startProcessing()
    else
        if self:getState() ~= "ACTIONSELECT" then
            self:setState("ACTIONSELECT")
            self.battle_ui.encounter_text:setText(self.battle_ui.current_encounter_text)
        else
            local party = self.party[self.current_selecting]
            party.chara:onActionSelect(party, false)
            self.encounter:onCharacterTurn(party, false)
        end
    end
end

function LightBattle:previousParty()
    if #self.selected_character_stack == 0 then
        return
    end

    self.current_selecting = self.selected_character_stack[#self.selected_character_stack] or 1
    local new_actions = self.selected_action_stack[#self.selected_action_stack-1] or {}

    for i,battler in ipairs(self.party) do
        local old_action = self.character_actions[i]
        local new_action = new_actions[i]
        if new_action ~= old_action then
            if old_action.cancellable == false then
                new_actions[i] = old_action
            else
                if old_action then
                    self:removeSingleAction(old_action)
                end
                if new_action then
                    self:commitSingleAction(new_action)
                end
            end
        end
    end

    self.selected_action_stack[#self.selected_action_stack-1] = new_actions

    table.remove(self.selected_character_stack, #self.selected_character_stack)
    table.remove(self.selected_action_stack, #self.selected_action_stack)

    local party = self.party[self.current_selecting]
    party.chara:onActionSelect(party, true)
    self.encounter:onCharacterTurn(party, true)
end

function LightBattle:checkSolidCollision(collider)
    if NOCLIP then return false end
    Object.startCache()
    if self.arena then
        if self.arena:collidesWith(collider) then
            Object.endCache()
            return true, self.arena
        end
    end
    for _,solid in ipairs(Game.stage:getObjects(Solid)) do
        if solid:collidesWith(collider) then
            Object.endCache()
            return true, solid
        end
    end
    Object.endCache()
    return false
end

function LightBattle:removeEnemy(enemy, defeated)
    enemy.selectable = false
    if defeated then
        table.insert(self.defeated_enemies, enemy)
    end
end

function LightBattle:parseEnemyIdentifier(id)
    local args = Utils.split(id, ":")
    local enemies = Utils.filter(self.enemies, function(enemy) return enemy.id == args[1] end)
    return enemies[args[2] and tonumber(args[2]) or 1]
end

function LightBattle:getTargetForItem(item, default_ally, default_enemy)
    -- deltatraveler etc
    if not item.target or item.target == "none" then
        return nil
    elseif item.target == "ally" then
        return default_ally or self.party[1]
    elseif item.target == "enemy" then
        return default_enemy or self:getActiveEnemies()[1]
    elseif item.target == "party" then
        return self.party
    elseif item.target == "enemies" then
        return self:getActiveEnemies()
    end
end

function LightBattle:clearMenuItems()
    self.menu_items = {}
end

function LightBattle:addMenuItem(tbl)
    tbl = {
        ["name"] = tbl.name or "",
        ["shortname"] = tbl.shortname or nil,
        ["seriousname"] = tbl.seriousname or nil,
        ["tp"] = tbl.tp or 0,
        ["unusable"] = tbl.unusable or false,
        ["description"] = tbl.description or "",
        ["party"] = tbl.party or {},
        ["color"] = tbl.color or {1, 1, 1, 1},
        ["data"] = tbl.data or nil,
        ["callback"] = tbl.callback or function() end,
        ["highlight"] = tbl.highlight or nil,
        ["icons"] = tbl.icons or nil,
        ["special"] = tbl.special or nil
    }
    table.insert(self.menu_items, tbl)
end

function LightBattle:onKeyPressed(key)
    if Kristal.Config["debug"] and Input.ctrl() then
        if key == "h" then
            Assets.playSound("power")
            for _,party in ipairs(self.party) do
                party:heal(math.huge)
            end
        end
        if key == "y" then
            Input.clear(nil, true)
            self.forced_victory = true
            if self.state == "DEFENDING" then
                self.encounter:onWavesDone()
            end
            self:setState("VICTORY")
        end
        if key == "m" then
            if self.music then
                if self.music:isPlaying() then
                    self.music:pause()
                else
                    self.music:resume()
                end
            end
        end
        if self.state == "DEFENDING" and key == "f" then
            self.encounter:onWavesDone()
        end
        if self.soul and key == "j" then
            self.soul:shatter(6)
            self:getPartyBattler(Game:getSoulPartyMember().id):hurt(math.huge)
        end
        if key == "b" then
            for _,battler in ipairs(self.party) do
                battler:hurt(math.huge)
            end
        end
        if key == "k" then
            Game:setTension(Game:getMaxTension() * 2, true)
        end
        if key == "n" then
            NOCLIP = not NOCLIP
        end
        if key == "delete" then
            for _,party in ipairs(self.party) do
                party.chara:setHealth(999)
            end
        end
    end

    if self.state == "MENUSELECT" then
        if Input.isConfirm(key) then

            if self.battle_ui.help_window then
                self.battle_ui.help_window:setTension(0)
            end

            local menu_item = self.menu_items[self:getItemIndex()]
            local can_select = self:canSelectMenuItem(menu_item)
            if Game.battle.encounter:onMenuSelect(self.state_reason, menu_item, can_select) then return end
            if Kristal.callEvent("onBattleMenuSelect", self.state_reason, menu_item, can_select) then return end

            if not self:isPagerMenu() then
                self.menuselect_cursor_memory[self.state_reason] = {x = self.current_menu_x, y = self.current_menu_y}
            end

            if can_select then
                if menu_item.special ~= "flee" then
                    self:playSelectSound()
                end
                menu_item["callback"](menu_item)
                return
            end
        elseif Input.isCancel(key) then
            Game:setTensionPreview(0)

            if not self:isPagerMenu() then
                self.menuselect_cursor_memory[self.state_reason] = {x = self.current_menu_x, y = self.current_menu_y}
            end

            if self.state_reason == "ACT" then
                self:setState("ENEMYSELECT", "ACT")
            elseif self.state_reason == "MERCY" then
                self:setState("ACTIONSELECT", "CANCEL")
            else
                self:setState("ACTIONSELECT", "CANCEL")
            end
            return
        elseif Input.is("left", key) then
            local page = math.ceil(self.current_menu_x / self.current_menu_columns) - 1
            local max_page = math.ceil(#self.menu_items / (self.current_menu_columns * self.current_menu_rows))
            local old = self.current_menu_x

            self.current_menu_x = self.current_menu_x - 1

            if self.current_menu_x < 1 then -- vomit
                self.current_menu_x = self.current_menu_columns * (max_page - self.current_menu_x)
                while not self:isValidMenuLocation() do
                    self.current_menu_x = self.current_menu_x - 1
                end

                if not self:isPagerMenu() and self.current_menu_columns > 1 and self.current_menu_x % 2 ~= 0 then
                    self.current_menu_y = self.current_menu_y - 1
                    self.current_menu_x = self.current_menu_columns

                    if not self:isValidMenuLocation() then
                        self.current_menu_y = 1
                    end
                end
            end

            if self.current_menu_x ~= old then
                self:playMoveSound()
            end

        elseif Input.is("right", key) then
            if self.current_menu_columns > 1 then
                self:playMoveSound()
            end
            self.current_menu_x = self.current_menu_x + 1
            if not self:isPagerMenu() and not self:isValidMenuLocation() and self.current_menu_columns > 1 then
                if self.current_menu_x % 2 == 0 then
                    self.current_menu_y = self.current_menu_y - 1
                    if not self:isValidMenuLocation() then
                        self.current_menu_y = 1
                        self.current_menu_x = 2
                        if not self:isValidMenuLocation() then
                            self.current_menu_x = 1
                        end
                    end
                elseif not self:isValidMenuLocation() then
                    self.current_menu_x = 1
                end
            elseif not self:isValidMenuLocation() then
                self.current_menu_x = 1  
            end
            
        end
        if Input.is("up", key) then
            local old_position = self.current_menu_y
            self.current_menu_y = self.current_menu_y - 1
            if (self.current_menu_y < 1) or (not self:isValidMenuLocation()) then
                self.current_menu_y = self.current_menu_rows
                if not self:isValidMenuLocation() then
                    self.current_menu_y = self.current_menu_rows - 1
                    if not self:isValidMenuLocation() then
                        self.current_menu_y = self.current_menu_rows - 2
                    end
                end
            end
            if self:isPagerMenu() or self.current_menu_y ~= old_position then
                self:playMoveSound()
            end
        elseif Input.is("down", key) then
            local old_position = self.current_menu_y
            self.current_menu_y = self.current_menu_y + 1
            if (self.current_menu_y > self.current_menu_rows) or (not self:isValidMenuLocation()) then
                self.current_menu_y = 1
            end
            if self:isPagerMenu() or self.current_menu_y ~= old_position then
                self:playMoveSound()
            end
        end

    elseif self.state == "BUTNOBODYCAME" then
        if Input.isConfirm(key) then
            self.music:stop()
            self.current_selecting = 0

            for _, battler in ipairs(self.party) do
                battler:setSleeping(false)
                battler.defending = false
                battler.action = nil

                if battler.chara:getHealth() <= 0 then
                    battler:revive()
                    battler.chara:setHealth(battler.chara:autoHealAmount())
                end
            end

            self:setState("TRANSITIONOUT")
            self.encounter:onBattleEnd()
        end

    elseif self.state == "ENEMYSELECT" or self.state == "XACTENEMYSELECT" then

        if Input.isConfirm(key) then
            self.enemyselect_cursor_memory[self.state_reason] = self.current_menu_y

            self:playSelectSound()
            if #self.enemies == 0 then return end
            self.selected_enemy = self.current_menu_y
            if self.state == "XACTENEMYSELECT" then
                local xaction = Utils.copy(self.selected_xaction)
                if xaction.default then
                    xaction.name = self.enemies[self.selected_enemy]:getXAction(self.party[self.current_selecting])
                end
                self:pushAction("XACT", self.enemies[self.selected_enemy], xaction)
            elseif self.state_reason == "ACT" then
                self:clearMenuItems()
                local enemy = self.enemies[self.selected_enemy]
                for _,v in ipairs(enemy.acts) do
                    local insert = not v.hidden
                    if v.character and self.party[self.current_selecting].chara.id ~= v.character then
                        insert = false
                    end
                    if v.party and (#v.party > 0) then
                        for _,party_id in ipairs(v.party) do
                            if not self:getPartyIndex(party_id) then
                                insert = false
                                break
                            end
                        end
                    end
                    if insert then
                        self:addMenuItem({
                            ["name"] = v.name,
                            ["tp"] = v.tp or 0,
                            ["description"] = v.description,
                            ["party"] = v.party,
                            ["color"] = v.color or {1, 1, 1, 1},
                            ["highlight"] = v.highlight or enemy,
                            ["icons"] = v.icons,
                            ["callback"] = function(menu_item)
                                self:pushAction("ACT", enemy, menu_item)
                            end
                        })
                    end
                end
                self:setState("MENUSELECT", "ACT")
            elseif self.state_reason == "ATTACK" then
                self:pushAction("ATTACK", self.enemies[self.selected_enemy])
            elseif self.state_reason == "SPELL" then
                self:pushAction("SPELL", self.enemies[self.selected_enemy], self.selected_spell)
            elseif self.state_reason == "ITEM" then
                self:pushAction("ITEM", self.enemies[self.selected_enemy], self.selected_item)
            else
                self:nextParty()
            end
            return
        end
        if Input.isCancel(key) then
            self.enemyselect_cursor_memory[self.state_reason] = self.current_menu_y

            if self.state_reason == "SPELL" then
                self:setState("MENUSELECT", "SPELL")
            elseif self.state_reason == "ITEM" then
                self:setState("MENUSELECT", "ITEM")
            else
                self:setState("ACTIONSELECT", "CANCEL")
            end
            return
        end
        if Input.is("up", key) then
            if #self.enemies == 0 then return end
            local old_location = self.current_menu_y
            local give_up = 0
            repeat
                give_up = give_up + 1
                if give_up > 100 then return end
                self.current_menu_y = self.current_menu_y - 1
                if self.current_menu_y < 1 then
                    self.current_menu_y = #self.enemies
                end
            until (self.enemies[self.current_menu_y].selectable)

            if self.current_menu_y ~= old_location then
                self:playMoveSound()
            end
        elseif Input.is("down", key) then
            local old_location = self.current_menu_y
            if #self.enemies == 0 then return end
            local give_up = 0
            repeat
                give_up = give_up + 1
                if give_up > 100 then return end
                self.current_menu_y = self.current_menu_y + 1
                if self.current_menu_y > #self.enemies then
                    self.current_menu_y = 1
                end
            until (self.enemies[self.current_menu_y].selectable)

            if self.current_menu_y ~= old_location then
                self:playMoveSound()
            end
        end
    elseif self.state == "PARTYSELECT" then
        if Input.isConfirm(key) then
            self.partyselect_cursor_memory[self.state_reason] = self.current_menu_y

            self:playSelectSound()
            if self.state_reason == "SPELL" then
                self:pushAction("SPELL", self.party[self.current_menu_y], self.selected_spell)
            elseif self.state_reason == "ITEM" then
                self:pushAction("ITEM", self.party[self.current_menu_y], self.selected_item)
            else
                self:nextParty()
            end
            return
        end
        if Input.isCancel(key) then
            self.partyselect_cursor_memory[self.state_reason] = self.current_menu_y
            
            if self.state_reason == "SPELL" then
                self:setState("MENUSELECT", "SPELL")
            elseif self.state_reason == "ITEM" then
                self:setState("MENUSELECT", "ITEM")
            else
                self:setState("ACTIONSELECT", "CANCEL")
            end
            return
        end
        if Input.is("up", key) then
            self:playMoveSound()
            self.current_menu_y = self.current_menu_y - 1
            if self.current_menu_y < 1 then
                self.current_menu_y = #self.party
            end
        elseif Input.is("down", key) then
            self:playMoveSound()
            self.current_menu_y = self.current_menu_y + 1
            if self.current_menu_y > #self.party then
                self.current_menu_y = 1
            end
        end
    elseif self.state == "BATTLETEXT" then
        -- Nothing here
    elseif self.state == "SHORTACTTEXT" then
        if Input.isConfirm(key) then
            if (not self.battle_ui.short_act_text_1:isTyping()) and
               (not self.battle_ui.short_act_text_2:isTyping()) and
               (not self.battle_ui.short_act_text_3:isTyping()) then
                self.battle_ui.short_act_text_1:setText("")
                self.battle_ui.short_act_text_2:setText("")
                self.battle_ui.short_act_text_3:setText("")
                for _,iaction in ipairs(self.short_actions) do
                    self:finishAction(iaction)
                end
                self.short_actions = {}
                self:setState("ACTIONS", "SHORTACTTEXT")
            end
        end
    elseif self.state == "ENEMYDIALOGUE" then
        -- Nothing here
    elseif self.state == "ACTIONSELECT" then
        self:handleActionSelectInput(key)
    elseif self.state == "ATTACKING" then
        self:handleAttackingInput(key)
    end
end

function LightBattle:handleActionSelectInput(key)
    if not self.encounter.story then
        local actbox = self.battle_ui.action_boxes[self.current_selecting]

        if Input.isConfirm(key) then
            actbox:select()
            self:playSelectSound()
            return
        elseif Input.isCancel(key) then
            local old_selecting = self.current_selecting

            --self:previousParty()

            if self.current_selecting ~= old_selecting then
                self:playMoveSound()
            end
            return
        elseif Input.is("left", key) then
            actbox.selected_button = actbox.selected_button - 1
            self:playMoveSound()
            if actbox then
                actbox:snapSoulToButton()
            end
        elseif Input.is("right", key) then
            actbox.selected_button = actbox.selected_button + 1
            self:playMoveSound()
            if actbox then
                actbox:snapSoulToButton()
            end
        end
    end
end

function LightBattle:handleAttackingInput(key)
    if Input.isConfirm(key) then

        if not self.attack_done and not self.cancel_attack and self.battle_ui.attack_box then
            local closest
            local closest_attacks = {}
            local close

            for _,attack in ipairs(self.battle_ui.attack_box.lanes) do
                if not attack.attacked then
                    close = self.battle_ui.attack_box:getClose(attack)
                    if not closest then
                        closest = close
                        table.insert(closest_attacks, attack)
                    elseif close == closest then
                        table.insert(closest_attacks, attack)
                    elseif close < closest then
                        closest = close
                        closest_attacks = {attack}
                    end
                end
            end

            if closest then
                for _,attack in ipairs(closest_attacks) do
                    local points, stretch = self.battle_ui.attack_box:hit(attack)

                    local action = self:getActionBy(attack.battler)
                    action.points = points
                    action.stretch = stretch

                    if self:processAction(action) then
                        self:finishAction(action)
                    end
                end
            end
        end
    end
end

function LightBattle:updateWaves()
    self.wave_timer = self.wave_timer + DT

    local all_done = true
    for _,wave in ipairs(self.waves) do
        if not wave.finished then
            if wave.time >= 0 and self.wave_timer >= wave.time then
                wave.finished = true
            else
                all_done = false
            end
        end
        if not wave:canEnd() then
            all_done = false
        end
    end

    if all_done and not self.finished_waves then
        self.finished_waves = true
        self.encounter:onWavesDone()
    end
end

function LightBattle:updateMenuWaves()
    self.menu_wave_timer = self.menu_wave_timer + DT

    local all_done = true
    for _,wave in ipairs(self.menu_waves) do
        if not wave.finished then
            if wave.time >= 0 and self.menu_wave_timer >= wave.time then
                wave.finished = true
            else
                all_done = false
            end
        end
        if not wave:canEnd() then
            all_done = false
        end
    end

    if all_done and not self.finished_menu_waves then
        self.finished_menu_waves = true
        self.encounter:onMenuWavesDone()
    end
end

function LightBattle:debugPrintOutline(string, x, y, color)
    color = color or {love.graphics.getColor()}
    Draw.setColor(0, 0, 0, 1)
    love.graphics.print(string, x - 1, y)
    love.graphics.print(string, x + 1, y)
    love.graphics.print(string, x, y - 1)
    love.graphics.print(string, x, y + 1)

    Draw.setColor(color)
    love.graphics.print(string, x, y)
end

function LightBattle:drawDebug()
    local font = Assets.getFont("main", 16)
    love.graphics.setFont(font)

    Draw.setColor(1, 1, 1, 1)
    self:debugPrintOutline("State: "    .. self.state   , 4, 0)
    self:debugPrintOutline("Substate: " .. self.substate, 4, 0 + 16)
    self:debugPrintOutline("current actions: " .. #self.current_actions, 4, 32)
end

function LightBattle:canDeepCopy() -- what
    return false
end

return LightBattle