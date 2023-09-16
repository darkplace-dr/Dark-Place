---@class Battle : Battle
---@overload fun(...) : Battle
local Battle, super = Class(Battle)

function Battle:updateIntro()
    self.intro_timer = self.intro_timer + 1 * DTMULT
    if self.intro_timer >= 15 then -- TODO: find out why this is 15 instead of 13
        for _,v in ipairs(self.party) do
            v:setAnimation("battle/idle")
        end
		self.seen_encounter_text = false
		if Mod.back_attack then
			self:setState("ENEMYDIALOGUE", "INTRO")
		else
			self:setState("ACTIONSELECT", "INTRO")
			self:nextTurn()
		end
    end
end

function Battle:onStateChange(old,new)
	super:onStateChange(self, old, new)
	
	if new == "ENEMYDIALOGUE" then
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
	elseif new == "FLEE" then
        self.current_selecting = 0
		local flee_complete = false

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

			battler:setAnimation("battle/hurt")

            Assets.playSound("defeatrun")

			local sweat = Sprite("effects/defeat/sweat")
			sweat:setOrigin(0.5, 0.5)
			sweat:setScale(0.5, 0.5)
			sweat:play(5/30, true)
			sweat.layer = 100
			battler:addChild(sweat)

			Game.battle.timer:after(15/30, function()
				sweat:remove()
				battler:getActiveSprite().run_away_2 = true
				flee_complete = true
			end)

            local box = self.battle_ui.action_boxes[self:getPartyIndex(battler.chara.id)]
            box:resetHeadIcon()
        end

        local flee_text = "* "
		
		local flee_list = {
			"I'm outta here.",
			"I've got better to do.",
			"Escaped...",
			"Don't slow me down."
		}
		
		flee_text = flee_text .. Utils.pick(flee_list)

        win_text = self.encounter:getVictoryText(win_text, self.money, self.xp) or win_text
		
        self:battleText(flee_text, function()
			while not flee_complete do end
			for _,battler in ipairs(self.party) do
				battler:getActiveSprite().run_away_2 = false
				battler.x = battler.x - 160
			end
            self:setState("TRANSITIONOUT")
            self.encounter:onBattleEnd()
            return true
        end)
	end
end

return Battle