---@class Battle
local Battle, super = Class("Battle", true)

function Battle:init()
	super.init(self)

	self.super_timer = 0

	self.superpower = false
end

-- FIXME: \/ copied from libraries/EnemyTension/scripts/hooks/Battle.lua

function Battle:postInit(state, encounter)
    super.postInit(self, state, encounter)

    -- If the enemy has a TP value defined, create a bar for it.
    if self.encounter.enemy_tension then
        self.enemy_tension_bar = EnemyTensionBar(639, 40, true)
        self:addChild(self.enemy_tension_bar)
    end
end

function Battle:showUI()
    super.showUI(self)
    if self.enemy_tension_bar then
        self.enemy_tension_bar:show()
    end
end

function Battle:onStateChange(old,new)
    super.onStateChange(self,old,new)

    if new == "VICTORY" then
        if self.enemy_tension_bar then
            self.enemy_tension_bar.animating_in = false
            self.enemy_tension_bar.shown = false
            self.enemy_tension_bar.physics.speed_x = 10
            self.enemy_tension_bar.physics.friction = -0.4
        end
    end
end

---Adds TP to the enemy's TP bar. Doesn't work if no enemy TP bar exists.
---@param tp integer Amount to give.
function Battle:giveEnemyTension(tp)
    self.encounter.enemy_tension = self.encounter.enemy_tension + tp
end

---Removes TP from the enemy's TP bar. Doesn't work if no enemy TP bar exists.
---@param tp integer Amount to remove.
function Battle:removeEnemyTension(tp)
    if self.encounter.enemy_tension - tp < 0 then
        self.encounter.enemy_tension = 0
    else
        self.encounter.enemy_tension = self.encounter.enemy_tension - tp
    end
end

---Returns current enemy TP value. Doesn't work if no enemy TP bar exists.
---@return integer tp
function Battle:getEnemyTension()
    return self.encounter.enemy_tension
end

---Sets enemy TP to the given value. Doesn't work if no enemy TP bar exists.
---@param tp integer Amount to set.
function Battle:setEnemyTension(tp)
    self.encounter.enemy_tension = tp
end

-- FIXME: /\ copied from libraries/EnemyTension/scripts/hooks/Battle.lua

function Battle:update()
	super.update(self)

	if self.superpower then
		if (self.super_timer - (DT * 30))%10 > self.super_timer%10 then
			Game:removeTension(1)

			if Game.tension <= 0 then
				self.superpower = false
				self.music:play(self.encounter.music)
			end
		end

		self.super_timer = self.super_timer + DT * 30
	end
end

function Battle:processAction(action)
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

    if action.action == "SPARE" then
        local worked = enemy:canSpare()

        battler:setAnimation("battle/spare", function()
            enemy:onMercy(battler)
            if not worked then
                enemy:mercyFlash()
            end
            self:finishAction(action)
        end)

        local text = enemy:getSpareText(battler, worked)
        if text then
            self:battleText(text)
        end

        return false

    elseif action.action == "ATTACK" or action.action == "AUTOATTACK" then
        local src = Assets.stopAndPlaySound(battler.chara:getAttackSound() or "laz_c")
        src:setPitch(battler.chara:getAttackPitch() or 1)

        self.actions_done_timer = 1.2

        local crit = action.points == 150 and action.action ~= "AUTOATTACK"
        if crit then
            Assets.stopAndPlaySound("criticalswing")

            for i = 1, 3 do
                local sx, sy = battler:getRelativePos(battler.width, 0)
                local sparkle = Sprite("effects/criticalswing/sparkle", sx + Utils.random(50), sy + 30 + Utils.random(30))
                sparkle:play(4/30, true)
                sparkle:setScale(2)
                sparkle.layer = BATTLE_LAYERS["above_battlers"]
                sparkle.physics.speed_x = Utils.random(2, 6)
                sparkle.physics.friction = -0.25
                sparkle:fadeOutSpeedAndRemove()
                self:addChild(sparkle)
            end
        end

        battler:setAnimation("battle/attack", function()
            action.icon = nil

            if action.target and action.target.done_state then
                enemy = self:retargetEnemy()
                action.target = enemy
                if not enemy then
                    self.cancel_attack = true
                    self:finishAction(action)
                    return
                end
            end

            local damage = Utils.round(enemy:getAttackDamage(action.damage or 0, battler, action.points or 0))
            if damage < 0 then
                damage = 0
            end

			if enemy.dt then
				local dmg_sprite = Sprite(battler.chara:getAttackSprite() or "effects/attack/cut")
				dmg_sprite:setOrigin(0.5, 0.5)
				if crit then
					dmg_sprite:setScale(2.5, 2.5)
				else
					dmg_sprite:setScale(2, 2)
				end
				dmg_sprite:setPosition(enemy:getRelativePos(enemy.width/2, enemy.height/2))
				dmg_sprite.layer = enemy.layer + 0.01
				dmg_sprite:play(1/15, false, function(s) s:remove() end)
				enemy.parent:addChild(dmg_sprite)

				local sound = enemy:getDamageSound() or "damage"
				if sound and type(sound) == "string" then
					Assets.stopAndPlaySound(sound)
				end
				
				enemy:hurt(damage, battler)
				
				local x, y = self:getRelativePos(enemy.x, enemy.y)
				local message = DTText(enemy.dt_text, -40, -20)
				enemy:addChild(message)
			elseif damage > 0 then
				Game:giveTension(Utils.round(enemy:getAttackTension(action.points or 100)))

				local dmg_sprite = Sprite(battler.chara:getAttackSprite() or "effects/attack/cut")
				dmg_sprite:setOrigin(0.5, 0.5)
				if crit then
					dmg_sprite:setScale(2.5, 2.5)
				else
					dmg_sprite:setScale(2, 2)
				end
				dmg_sprite:setPosition(enemy:getRelativePos(enemy.width/2, enemy.height/2))
				dmg_sprite.layer = enemy.layer + 0.01
				dmg_sprite:play(1/15, false, function(s) s:remove() end)
				enemy.parent:addChild(dmg_sprite)

				local sound = enemy:getDamageSound() or "damage"
				if sound and type(sound) == "string" then
					Assets.stopAndPlaySound(sound)
				end
				enemy:hurt(damage, battler)

				battler.chara:onAttackHit(enemy, damage)
			else
				enemy:statusMessage("msg", "miss", {battler.chara:getDamageColor()})
			end

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
        end)

        return false

    elseif action.action == "ACT" then
        -- fun fact: this would have only been a single function call
        -- if stupid multi-acts didn't exist

        -- Check for other short acts
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
        action.data:onStart(battler, action.target)

        return false

    elseif action.action == "ITEM" then
        local item = action.data
        if item.instant then
            self:finishAction(action)
        else
            local text = item:getBattleText(battler, action.target)
            if text then
                self:battleText(text)
            end
            battler:setAnimation("battle/item", function()
                local result = item:onBattleUse(battler, action.target)
                if result or result == nil then
                    self:finishAction(action)
                end
            end)
        end
        return false

    elseif action.action == "DEFEND" then
        battler:setAnimation("battle/defend")
        battler.defending = true
        return false

    else
        -- we don't know how to handle this...
        Kristal.Console:warn("Unhandled battle action: " .. tostring(action.action))
        return true
    end
end

return Battle