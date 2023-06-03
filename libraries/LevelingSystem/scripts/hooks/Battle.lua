---@class _Battle : Battle
---@overload fun(...) : Battle
local Battle, super = Class("Battle", true)

function Battle:init()
    super.init(self)

    self.freeze_xp = 0

    self.killed = false
end

function Battle:onStateChange(old,new)
    -- Unfortunately this can't be changed in a simpler way
    if new ~= "VICTORY" then
        super.onStateChange(self, old, new)
    end

    local result = self.encounter:beforeStateChange(old,new)
    if result or self.state ~= new then
        return
    end

    if new == "VICTORY" then
        self.current_selecting = 0

        if self.tension_bar then
            self.tension_bar.animating_in = false
            self.tension_bar.shown = false
            self.tension_bar.physics.speed_x = -10
            self.tension_bar.physics.friction = -0.4
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
        if self.used_violence then
            if self.killed then
                local leveled_up

                if Kristal.getLibConfig("leveling", "global_love") then
                    Game:addFlag("library_experience", self.xp)
                    if Game:getFlag("library_experience", 0) > 99999 then
                        Game:setFlag("library_experience", 99999)
                    end
                    local req_table = Kristal.callEvent("getGlobalLevelupRequirementsTable")
                    while
                        Game:getFlag("library_experience") >= Game:getFlag("library_reqexp")
                        and Game:getFlag("library_love", 1) < Game:getFlag("library_maxlove")
                    do
                        leveled_up = true
                        Game:addFlag("library_love", 1)
                        local love = Game:getFlag("library_love")
                        Game:setFlag("library_reqexp", req_table[love + 1] or 0)
                        for _,battler in ipairs(self.party) do
                            battler:levelUp()
                        end
                    end
                    Game:setFlag("library_nextlv", Utils.clamp(Game:getFlag("library_reqexp") - Game:getFlag("library_experience"), 0, 99999))

                    if leveled_up then
                        Assets.playSound("levelup")
                        win_text = "* You won!\n* Got " .. self.xp .. " EXP and " .. self.money .. " "..Game:getConfig("darkCurrencyShort")..".\n* Your LOVE increased."
                    end
                else
                    local function levelUpAlly(battler, xp)
                        battler.chara:addExp(xp)
                        while battler.chara.exp >= battler.chara.req_exp do
                            leveled_up = true
                            battler.chara:levelUp()
                        end
                        battler.chara.next_lv = Utils.clamp(battler.chara.req_exp - battler.chara.exp, 0, 99999)
                    end

                    for _,battler in ipairs(self.party) do
                        levelUpAlly(battler, self.xp)
                        local grant_fxp = not Kristal.getLibConfig("leveling", "local_freezing")
                        if Kristal.getLibConfig("leveling", "local_freezing") then
                            for _,spell in ipairs(battler.chara.spells) do
                                if spell:hasTag("ice") then
                                    grant_fxp = true
                                    break
                                end
                            end
                        end
                        if grant_fxp then
                            levelUpAlly(battler, self.freeze_xp)
                        end
                    end

                    if leveled_up then
                        Assets.playSound("levelup")
                        win_text = "* You won!\n* Got " .. self.xp + self.freeze_xp .. " EXP and " .. self.money .. " "..Game:getConfig("darkCurrencyShort")..".\n* Your LOVE increased."
                    else
                        win_text = "* You won!\n* Got " .. self.xp + self.freeze_xp .. " EXP and " .. self.money .. " "..Game:getConfig("darkCurrencyShort").."."
                    end
                end
            elseif Game:getConfig("growStronger") then
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
        end

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