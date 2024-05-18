local Lib = {}

function Lib:init()

    Utils.hook(Wave, "init", function(orig, self)
        orig(self)
        self.screen_arena = false
    end)

    Utils.hook(Arena, "init", function(orig, self, x, y, shape)
        orig(self, x, y, shape)
        self.use_screen_arena = false
        self.screen_arena = nil
    end)

    Utils.hook(Arena, "onAdd", function(orig, self, parent)
        self.sprite:setScale(0, 0)
        self.sprite.alpha = 0.5
        self.sprite.rotation = math.pi
    
        local center_x, center_y = self:getCenter()
    
        local afterimage_timer = 0
        local afterimage_count = 0
        Game.battle.timer:during(15/30, function()
            afterimage_timer = Utils.approach(afterimage_timer, 15, DTMULT)
    
            local real_progress = afterimage_timer / 15
    
            self.sprite:setScale(real_progress, real_progress)
            self.sprite.alpha = 0.5 + (0.5 * real_progress)
            self.sprite.rotation = (math.pi) * (1 - real_progress)
    
            while afterimage_count < math.floor(afterimage_timer) do
                afterimage_count = afterimage_count + 1
    
                local progress = afterimage_count / 15
    
                local afterimg = ArenaSprite(self, center_x, center_y)
                afterimg:setOrigin(0.5, 0.5)
                afterimg:setScale(progress, progress)
                afterimg:fadeOutSpeedAndRemove()
                afterimg.background = false
                afterimg.alpha = 0.6 - (0.5 * progress)
                afterimg.rotation = (math.pi) * (1 - progress)
                parent:addChild(afterimg)
                afterimg:setLayer(self.layer + (1 - progress))
            end
        end, function()
            self.sprite:setScale(1)
            self.sprite.alpha = 1
            self.sprite.rotation = 0

            if self.use_screen_arena then
                self.screen_arena = ScreenArena(self)
                self.screen_arena.layer = BATTLE_LAYERS["ui"] + 1
                self.screen_arena.prev_tensionbar_layer = Game.battle.tension_bar.layer
                Game.battle.tension_bar.layer = BATTLE_LAYERS["above_ui"]
                Game.battle:addChild(self.screen_arena)
            end
        end)
    end)

    Utils.hook(Battle, "onStateChange", function(orig, self, old, new)
        local result = self.encounter:beforeStateChange(old,new)
        if result or self.state ~= new then
            return
        end
        if new == "INTRO" then
            self.seen_encounter_text = false
            self.intro_timer = 0
            Assets.playSound("impact", 0.7)
            Assets.playSound("weaponpull_fast", 0.8)
    
            for _,battler in ipairs(self.party) do
                battler:setAnimation("battle/intro")
            end
    
            self.encounter:onBattleStart()
        elseif new == "ACTIONSELECT" then
            if self.current_selecting < 1 or self.current_selecting > #self.party then
                self:nextTurn()
                if self.state ~= "ACTIONSELECT" then
                    return
                end
            end
    
            if self.state_reason == "CANCEL" then
                self.battle_ui.encounter_text:setText("[instant]" .. self.battle_ui.current_encounter_text)
            end
    
            local had_started = self.started
            if not self.started then
                self.started = true
    
                for _,battler in ipairs(self.party) do
                    battler:resetSprite()
                end
    
                if self.encounter.music then
                    self.music:play(self.encounter.music)
                end
            end
    
            self:showUI()
    
            -- Workaround for autobattlers until BattleUI is created earlier
            -- TODO: BattleUI is now created earlier, do something with this
            if not had_started then
                for _,party in ipairs(self.party) do
                    party.chara:onTurnStart(party)
                end
                local party = self.party[self.current_selecting]
                party.chara:onActionSelect(party, false)
                self.encounter:onCharacterTurn(party, false)
            end
        elseif new == "ACTIONS" then
            self.battle_ui:clearEncounterText()
            if self.state_reason ~= "DONTPROCESS" then
                self:tryProcessNextAction()
            end
        elseif new == "ENEMYSELECT" or new == "XACTENEMYSELECT" then
            self.battle_ui:clearEncounterText()
            self.current_menu_y = 1
            self.selected_enemy = 1
        elseif new == "PARTYSELECT" then
            self.battle_ui:clearEncounterText()
            self.current_menu_y = 1
        elseif new == "MENUSELECT" then
            self.battle_ui:clearEncounterText()
            self.current_menu_x = 1
            self.current_menu_y = 1
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
            self.battle_ui:clearEncounterText()
            self.textbox_timer = 3 * 30
            self.use_textbox_timer = true
            local active_enemies = self:getActiveEnemies()
            if #active_enemies == 0 then
                self:setState("VICTORY")
            else
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
                            local bubble = enemy:spawnSpeechBubble(dialogue)
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
            self.current_selecting = 0
    
            if self.tension_bar then
                self.tension_bar:hide()
            end
    
            for _,battler in ipairs(self.party) do
                battler:setSleeping(false)
                battler.defending = false
                battler.action = nil
    
                battler.chara:resetBuffs()
    
                if battler.chara:getHealth() <= 0 then
                    battler:revive()
                    battler.chara:setHealth(battler.chara:autoHealAmount())
                end
    
                battler:setAnimation("battle/victory")
    
                local box = self.battle_ui.action_boxes[self:getPartyIndex(battler.chara.id)]
                box:resetHeadIcon()
            end
    
            self.money = self.money + (math.floor(((Game:getTension() * 2.5) / 10)) * Game.chapter)
    
            for _,battler in ipairs(self.party) do
                for _,equipment in ipairs(battler.chara:getEquipment()) do
                    self.money = math.floor(equipment:applyMoneyBonus(self.money) or self.money)
                end
            end
    
            self.money = math.floor(self.money)
    
            self.money = self.encounter:getVictoryMoney(self.money) or self.money
            self.xp = self.encounter:getVictoryXP(self.xp) or self.xp
            -- if (in_dojo) then
            --     self.money = 0
            -- end
    
            Game.money = Game.money + self.money
            Game.xp = Game.xp + self.xp
    
            if (Game.money < 0) then
                Game.money = 0
            end
    
            local win_text = "* You won!\n* Got " .. self.xp .. " EXP and " .. self.money .. " "..Game:getConfig("darkCurrencyShort").."."
            -- if (in_dojo) then
            --     win_text == "* You won the battle!"
            -- end
            if self.used_violence and Game:getConfig("growStronger") then
                local stronger = "You"
    
                for _,battler in ipairs(self.party) do
                    Game.level_up_count = Game.level_up_count + 1
                    battler.chara:onLevelUp(Game.level_up_count)
    
                    if battler.chara.id == Game:getConfig("growStrongerChara") then
                        stronger = battler.chara:getName()
                    end
                end
    
                win_text = "* You won!\n* Got " .. self.money .. " "..Game:getConfig("darkCurrencyShort")..".\n* "..stronger.." became stronger."
    
                Assets.playSound("dtrans_lw", 0.7, 2)
                --scr_levelup()
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
    
            if self.tension_bar and self.tension_bar.shown then
                self.tension_bar:hide()
            end
    
            self.battle_ui:transitionOut()
            self.music:fade(0, 20/30)
            for _,battler in ipairs(self.party) do
                local index = self:getPartyIndex(battler.chara.id)
                if index then
                    self.battler_targets[index] = {battler:getPosition()}
                end
            end
            if self.encounter_context and self.encounter_context:includes(ChaserEnemy) then
                for _,enemy in ipairs(self.encounter_context:getGroupedEnemies(true)) do
                    enemy:onEncounterTransitionOut(enemy == self.encounter_context, self.encounter)
                end
            end
        elseif new == "DEFENDINGBEGIN" then
            if self.state_reason == "CUTSCENE" then
                self:setState("DEFENDING")
                return
            end

            self.current_selecting = 0
            self.battle_ui:clearEncounterText()

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
                self:setWaves(self.encounter:getNextWaves())
            end

            if self.arena then
                self.arena:remove()
            end

            local soul_x, soul_y, soul_offset_x, soul_offset_y
            local arena_x, arena_y, arena_w, arena_h, arena_shape
            local has_arena = true
            local screen_arena = false
            for _,wave in ipairs(self.waves) do
                soul_x = wave.soul_start_x or soul_x
                soul_y = wave.soul_start_y or soul_y
                soul_offset_x = wave.soul_offset_x or soul_offset_x
                soul_offset_y = wave.soul_offset_y or soul_offset_y
                arena_x = wave.arena_x or arena_x
                arena_y = wave.arena_y or arena_y
                arena_w = wave.arena_width and math.max(wave.arena_width, arena_w or 0) or arena_w
                arena_h = wave.arena_height and math.max(wave.arena_height, arena_h or 0) or arena_h
                if wave.arena_shape then
                    arena_shape = wave.arena_shape
                end
                if not wave.has_arena then
                    has_arena = false
                end
                if wave.screen_arena then
                    screen_arena = true
                end
            end

            local center_x, center_y
            if has_arena then
                if not arena_shape then
                    arena_w, arena_h = arena_w or 142, arena_h or 142
                    arena_shape = {{0, 0}, {arena_w, 0}, {arena_w, arena_h}, {0, arena_h}}
                end

                local arena = Arena(arena_x or SCREEN_WIDTH/2, arena_y or (SCREEN_HEIGHT - 155)/2 + 10, arena_shape)
                arena.use_screen_arena = screen_arena
                arena.layer = BATTLE_LAYERS["arena"]

                self.arena = arena
                self:addChild(arena)
                center_x, center_y = arena:getCenter()
            else
                center_x, center_y = SCREEN_WIDTH/2, (SCREEN_HEIGHT - 155)/2 + 10
            end

            soul_x = soul_x or (soul_offset_x and center_x + soul_offset_x)
            soul_y = soul_y or (soul_offset_y and center_y + soul_offset_y)
            self:spawnSoul(soul_x or center_x, soul_y or center_y)

            for _,wave in ipairs(Game.battle.waves) do
                if wave:onArenaEnter() then
                    wave.active = true
                end
            end

            self.defending_begin_timer = 0
        end
        -- List of states that should remove the arena.
        -- A whitelist is better than a blacklist in case the modder adds more states.
        -- And in case the modder adds more states and wants the arena to be removed, they can remove the arena themselves.
        local remove_arena = {"DEFENDINGEND", "TRANSITIONOUT", "ACTIONSELECT", "VICTORY", "INTRO", "ACTIONS", "ENEMYSELECT", "XACTENEMYSELECT", "PARTYSELECT", "MENUSELECT", "ATTACKING"}

        local should_end = true
        if Utils.containsValue(remove_arena, new) then
            for _,wave in ipairs(self.waves) do
                if wave:beforeEnd() then
                    should_end = false
                end
            end
            if should_end then
                if self.arena then
                    if self.arena.screen_arena then
                        self.arena.screen_arena:fade()
                        Game.battle.timer:after(1, function()
                            self:returnSoul()
                            if self.arena then
                                self.arena:remove()
                                self.arena = nil
                            end
                        end)
                    else
                        self:returnSoul()
                        if self.arena then
                            self.arena:remove()
                            self.arena = nil
                        end
                    end
                end
                for _,battler in ipairs(self.party) do
                    battler.targeted = false
                end
            end
        end

        local ending_wave = self.state_reason == "WAVEENDED"

        if old == "DEFENDING" and new ~= "DEFENDINGBEGIN" and should_end then
            for _,wave in ipairs(self.waves) do
                if not wave:onEnd(false) then
                    wave:clear()
                    wave:remove()
                end
            end

            local function exitWaves()
                for _,wave in ipairs(self.waves) do
                    wave:onArenaExit()
                end
                self.waves = {}
            end

            if self:hasCutscene() then
                self.cutscene:after(function()
                    exitWaves()
                    if ending_wave then
                        self:nextTurn()
                    end
                end)
            else
                self.timer:after(15/30, function()
                    exitWaves()
                    if ending_wave then
                        self:nextTurn()
                    end
                end)
            end
        end

        self.encounter:onStateChange(old,new)
    end)
end

return Lib