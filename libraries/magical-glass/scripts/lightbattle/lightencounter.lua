local LightEncounter = Class()

function LightEncounter:init()
    -- Text that will be displayed when the battle starts
    self.text = "* A skirmish breaks out!"

    -- Is a "But Nobody Came"/"Genocide" Encounter
    self.nobody_came = false

    -- Is a "story" encounter (can't attack, only hp and lv are shown. a wave is started as soon as the battle starts)
    self.story = false

    -- Speeds up the soul transition
    self.fast_transition = false

    -- Whether the default grid background is drawn
    self.background = true
    self.background_image = Game:isLight() and "ui/lightbattle/backgrounds/battle" or "ui/lightbattle/backgrounds/battle_dark"

    -- The music used for this encounter
    self.music = "battleut"

    -- Whether characters have the X-Action option in their spell menu
    self.default_xactions = Game:getConfig("partyActions")

    -- Should the battle skip the YOU WON! text?
    self.no_end_message = false

    -- Table used to spawn enemies when the battle exists, if this encounter is created before
    self.queued_enemy_spawns = {}

    -- A copy of battle.defeated_enemies, used to determine how an enemy has been defeated.
    self.defeated_enemies = nil
    
    -- Whether Karma (KR) UI changes will appear.
    self.karma_mode = false

    self.can_flee = true

    self.flee_chance = 0
    self.flee_messages = {
        "* I'm outta here.", -- 1/20
        "* I've got better to do.", --1/20
        "* Escaped...", --17/20
        "* Don't slow me down." --1/20
    }

    self.used_flee_message = nil
end

function LightEncounter:onSoulTransition()
    local soul_char = Game.world:getPartyCharacterInParty(Game:getSoulPartyMember())
    Game.battle.fake_player = Game.battle:addChild(FakeClone(soul_char, soul_char:getScreenPos()))
    Game.battle.fake_player.layer = Game.battle.fader.layer + 1

    Game.battle.timer:script(function(wait)
        -- Black bg
        wait(1/30)
        -- Show heart
        Assets.playSound("noise")
        local player = Game.battle.fake_player.ref
        local x, y = Game.world.soul:localToScreenPos()
        Game.battle:spawnSoul(x, y)
        Game.battle.soul.sprite:set("player/heart_menu")
        Game.battle.soul.sprite:setScale(2)
        Game.battle.soul.sprite:setOrigin(0.5)
        Game.battle.soul.layer = Game.battle.fader.layer + 2
        Game.battle.soul.can_move = false
        wait(2/30)
        -- Hide heart
        Game.battle.soul.visible = false
        wait(2/30)
        -- Show heart
        Game.battle.soul.visible = true
        Assets.playSound("noise")
        wait(2/30)
        -- Hide heart
        Game.battle.soul.visible = false
        wait(2/30)
        -- Show heart
        Game.battle.soul.visible = true
        Assets.playSound("noise")
        wait(2/30)
        -- Do transition
        Game.battle.fake_player:remove()
        Assets.playSound("battlefall")

        if self.story then
            local center_x, center_y = Game.battle.arena:getCenter()
            local soul_offset_x = self:storyWave().soul_offset_x
            local soul_offset_y = self:storyWave().soul_offset_y
            local soul_x = self:storyWave().soul_start_x or (soul_offset_x and center_x + soul_offset_x)
            local soul_y = self:storyWave().soul_start_y or (soul_offset_y and center_y + soul_offset_y)
            Game.battle.soul:slideTo(soul_x or center_x, soul_y or center_y, 17/30)
        else
            Game.battle.soul:slideTo(49, 455, 17/30)
        end

        wait(17/30)
        -- Wait
        wait(5/30)
        Game.battle.soul.sprite:set("player/heart_light")
        Game.battle.soul.sprite:setScale(1)
        Game.battle.soul.x = Game.battle.soul.x - 1
        Game.battle.soul.y = Game.battle.soul.y - 1

        Game.battle.fader:fadeIn(nil, {speed=5/30})
        Game.battle.transitioned = true
        self:setBattleState()
    end)
end

function LightEncounter:onNoTransition()
    Game.battle.timer:after(1/30, function()
        Game.battle.fader:fadeIn(nil, {speed=5/30})
        Game.battle.transitioned = true
        self:setBattleState()
    end)
end

function LightEncounter:onBattleInit() end

function LightEncounter:storyWave()
    return "_story"
end

function LightEncounter:setBattleState()
    if self.nobody_came then
        Game.battle:setState("BUTNOBODYCAME")
    elseif self.story then
        Game.battle:setState("ENEMYDIALOGUE")
        Game.battle.soul.can_move = true
    else
        Game.battle:setState("ACTIONSELECT")
    end
    self:onBattleStart()
end

function LightEncounter:onBattleStart() end

function LightEncounter:onBattleEnd() end

function LightEncounter:onTurnStart() end
function LightEncounter:onTurnEnd()
    self.flee_chance = Utils.random(100) + (10 * (Game.battle.turn_count - 1))
end

function LightEncounter:onActionsStart() end
function LightEncounter:onActionsEnd() end

function LightEncounter:onCharacterTurn(battler, undo) end

function LightEncounter:onFlee()

    Assets.playSound("escaped")
    
    for _,battler in ipairs(Game.battle.party) do
        battler.chara:setHealth(battler.chara:getHealth() - battler.karma)
        battler.karma = 0
    end
    
    local money = self:getVictoryMoney(Game.battle.money) or Game.battle.money
    local xp = self:getVictoryXP(Game.battle.xp) or Game.battle.xp

    if money ~= 0 or xp ~= 0 or Game.battle.used_violence and Game:getConfig("growStronger") and not Game:isLight() then
        if Game:isLight() then
            for _,battler in ipairs(Game.battle.party) do
                for _,equipment in ipairs(battler.chara:getEquipment()) do
                    money = math.floor(equipment:applyMoneyBonus(money) or money)
                end
            end

            Game.lw_money = Game.lw_money + math.floor(money)

            if (Game.lw_money < 0) then
                Game.lw_money = 0
            end

            self.used_flee_message = "* Ran away with " .. xp .. " EXP\n  and " .. money .. " " .. Game:getConfig("lightCurrency"):upper() .. "."

            for _,member in ipairs(Game.battle.party) do
                local lv = member.chara:getLightLV()
                member.chara:gainLightEXP(xp, true)
            end
        else
            for _,battler in ipairs(Game.battle.party) do
                for _,equipment in ipairs(battler.chara:getEquipment()) do
                    money = math.floor(equipment:applyMoneyBonus(money) or money)
                end
            end

            Game.money = Game.money + math.floor(money)
            Game.xp = Game.xp + xp

            if (Game.money < 0) then
                Game.money = 0
            end
            
            if Game.battle.used_violence and Game:getConfig("growStronger") then
                local stronger = "You"

                for _,battler in ipairs(Game.battle.party) do
                    Game.level_up_count = Game.level_up_count + 1
                    battler.chara:onLevelUp(Game.level_up_count)

                    if battler.chara.id == Game:getConfig("growStrongerChara") then
                        stronger = battler.chara:getName()
                    end
                end

                self.used_flee_message = "* Ran away with " .. money .. " " .. Game:getConfig("darkCurrencyShort") .. ".\n* "..stronger.." became stronger."

                Assets.playSound("dtrans_lw", 0.7, 2)
                --scr_levelup()
            else
                self.used_flee_message = "* Ran away with " .. xp .. " EXP\n  and " .. money .. " " .. Game:getConfig("darkCurrencyShort") .. "."
            end
        end
    else
        self.used_flee_message = self:getFleeMessage()
    end

    Game.battle.soul.collidable = false
    Game.battle.soul.y = Game.battle.soul.y + 4
    Game.battle.soul.sprite:setAnimation({"player/heartgtfo", 1/15, true})
    Game.battle.soul.physics.speed_x = -3

    Game.battle.timer:after(1, function()
        Game.battle:setState("TRANSITIONOUT")
        self:onBattleEnd()
    end)

end

function LightEncounter:onFleeFail() end

function LightEncounter:beforeStateChange(old, new) end
function LightEncounter:onStateChange(old, new) end

function LightEncounter:onActionSelect(battler, button) end

function LightEncounter:onMenuSelect(state_reason, item, can_select) end
function LightEncounter:onMenuCancel(state_reason, item) end

function LightEncounter:onEnemySelect(state_reason, enemy_index) end
function LightEncounter:onEnemyCancel(state_reason, enemy_index) end

function LightEncounter:onPartySelect(state_reason, party_index) end
function LightEncounter:onPartyCancel(state_reason, party_index) end

function LightEncounter:onGameOver() end
function LightEncounter:onReturnToWorld(events) end

function LightEncounter:getDialogueCutscene() end

function LightEncounter:getVictoryMoney(money) end
function LightEncounter:getVictoryXP(xp) end
function LightEncounter:getVictoryText(text, money, xp) end

function LightEncounter:update() end

function LightEncounter:draw() end
function LightEncounter:drawBackground()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(Assets.getTexture(self.background_image) or Assets.getTexture("ui/lightbattle/backgrounds/battle"), 15, 9)
end

-- Functions

function LightEncounter:addEnemy(enemy, x, y, ...)
    local enemy_obj
    if type(enemy) == "string" then
        enemy_obj = MagicalGlassLib:createLightEnemy(enemy, ...)
    else
        enemy_obj = enemy
    end

    local enemies = self.queued_enemy_spawns
    local enemies_index = enemies
    if Game.battle and Game.state == "BATTLE" then
        enemies = Game.battle.enemies
        enemies_index = Game.battle.enemies_index
    end

    if x and y then
        enemy_obj:setPosition(x, y)
    else
        local x, y = SCREEN_WIDTH/2 + math.floor((#enemies + 1) / 2) * 120 * ((#enemies % 2 == 0) and -1 or 1), 240
        enemy_obj:setPosition(x, y)
    end

    enemy_obj.encounter = self
    table.insert(enemies, enemy_obj)
    table.insert(enemies_index, enemy_obj)
    if Game.battle and Game.state == "BATTLE" then
        Game.battle:addChild(enemy_obj)
    end
    return enemy_obj
end

function LightEncounter:getFleeMessage()
    local message = Utils.random(0, 20, 1)

    if message == 0 or message == 1 then
        return self.flee_messages[1]
    elseif message == 2 then
        return self.flee_messages[2]
    elseif message > 3 then
        return self.flee_messages[3]
    elseif message == 3 then
        return self.flee_messages[4]
    end
end

function LightEncounter:getUsedFleeMessage()
    return self.used_flee_message
end

function LightEncounter:getEncounterText()
    local enemies = Game.battle:getActiveEnemies()
    local enemy = Utils.pick(enemies, function(v)
        if not v.text then
            return true
        else
            return #v.text > 0
        end
    end)
    if enemy then
        return enemy:getEncounterText()
    else
        return self.text
    end
end

function LightEncounter:getNextWaves()
    local waves = {}
    if self.story then
        local wave = self:storyWave()
        table.insert(waves, wave)
    else
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            local wave = enemy:selectWave()
            if wave then
                table.insert(waves, wave)
            end
        end
    end
    return waves
end

function LightEncounter:getNextMenuWaves()
    local waves = {}
    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
        local wave = enemy:selectMenuWave()
        if wave then
            table.insert(waves, wave)
        end
    end
    return waves
end

function LightEncounter:getSoulColor()
    return Game:getSoulColor()
end

function LightEncounter:onDialogueEnd()
    Game.battle:setState("DEFENDINGBEGIN")
end

function LightEncounter:onWavesDone()

    local chance = self.flee_chance

    if Game.battle.turn_count > 2 then
        if chance == 0 or chance == nil then
            self.flee_chance = Utils.random(0, 100, 1)
        else
            self.flee_chance = self.flee_chance + 10
        end
    end

    Game.battle:toggleSoul(false)

    Game.battle:setState("DEFENDINGEND", "WAVEENDED")
end

function LightEncounter:onMenuWavesDone() end

function LightEncounter:getDefeatedEnemies()
    return self.defeated_enemies or Game.battle.defeated_enemies
end

function LightEncounter:createSoul(x, y, color)
    return LightSoul(x, y, color)
end

function LightEncounter:setFlag(flag, value)
    Game:setFlag("lw_encounter#"..self.id..":"..flag, value)
end

function LightEncounter:getFlag(flag, default)
    return Game:getFlag("lw_encounter#"..self.id..":"..flag, default)
end

function LightEncounter:addFlag(flag, amount)
    return Game:addFlag("lw_encounter#"..self.id..":"..flag, amount)
end

function LightEncounter:canDeepCopy()
    return false
end

return LightEncounter