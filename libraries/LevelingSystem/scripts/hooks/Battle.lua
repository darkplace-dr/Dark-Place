---@class _Battle : Battle
---@overload fun(...) : Battle
local Battle, super = Class("Battle", true)

function Battle:init()
    super.init(self)

    self.freeze_xp = 0

    self.killed = false
end

function Battle:onStateChange(old,new)
    if new == "INTRO" then
        for _,enemy in ipairs(self.enemies) do
            if enemy.id=="robo_susie" then
                enemy:setAnimation("battle/intro")
                enemy.sprite.flip_x = true
            elseif enemy.id=="noyno" then
                enemy:setAnimation("battle/intro")
                enemy.sprite.flip_x = true
            end
        end
    elseif new == "ACTIONSELECT" then
        for _,enemy in ipairs(self.enemies) do
            if enemy.id=="robo_susie" then
                enemy:setAnimation("battle/idle")
            elseif enemy.id=="noyno" then
                enemy:setAnimation("battle/idle")
            end
        end
    elseif new == "VICTORY" then
        for _,enemy in ipairs(self.enemies) do
            if enemy.id=="robo_susie" then
                enemy:setAnimation("battle/victory")
            elseif enemy.id=="noyno" then
                enemy:setAnimation("battle/victory")
            end
        end
    end
    -- Unfortunately this can't be changed in a simpler way
    if new ~= "VICTORY" then
        return super.onStateChange(self, old, new)
    end

    local result = self.encounter:beforeStateChange(old,new)
    if result or self.state ~= new then
        return
    end

    if new == "VICTORY" then
        self.current_selecting = 0

        if self.tension_bar then
            self.tension_bar:hide()
        end

        for _,battler in ipairs(self.party) do
            battler:setSleeping(false)
            battler.defending = false
            battler.action = nil

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

        if self.xp > 0 or self.freeze_xp > 0 then
            local leveled_up
            local xp_gain = self.xp

            if not Kristal.getLibConfig("leveling", "global_love") then
                xp_gain = self.xp + self.freeze_xp

                local function addExpTo(battler, xp)
                    if battler.chara:addExp(xp) then
                        leveled_up = true
                    end
                end

                for _,battler in ipairs(self.party) do
                    addExpTo(battler, self.xp)

                    local local_freezing = Kristal.getLibConfig("leveling", "local_freezing")
                    local grant_fxp = not local_freezing
                    if local_freezing then
                        for _,spell in ipairs(battler.chara.spells) do
                            if spell:hasTag("ice") then
                                grant_fxp = true
                                break
                            end
                        end
                    end
                    if grant_fxp then
                        addExpTo(battler, self.freeze_xp)
                    end
                end
            else
                leveled_up = Kristal.callEvent("addGlobalEXP", self.xp)
            end

            win_text = "* You won!\n* Got " .. xp_gain .. " EXP and " .. self.money .. " "..Game:getConfig("darkCurrencyShort").."."
            if leveled_up then
                Assets.playSound("levelup")
                win_text = win_text.."\n* Your LOVE increased."
            end
        elseif self.used_violence and Game:getConfig("growStronger") then
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
            self:returnSoul()
            if self.arena then
                self.arena:remove()
                self.arena = nil
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
end

return Battle