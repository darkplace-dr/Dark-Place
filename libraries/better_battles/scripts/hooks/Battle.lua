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
                battler.chara:setHealth(1)
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
		
		for _,battler in pairs(Game.battle.party) do
			for _,text in pairs(battler.chara.flee_text) do
				table.insert(flee_list, text)
			end
		end
		
		flee_text = flee_text .. Utils.pick(flee_list)
		
        self:battleText(flee_text, function()
			for _,battler in ipairs(self.party) do
				battler:getActiveSprite().run_away_2 = false
				battler.x = battler.x - 240
			end
            self:setState("TRANSITIONOUT")
            self.encounter:onBattleEnd()
            return true
        end)
	end
end

function Battle:pierce(amount, exact, target)
    target = target or "ANY"


    if type(target) == "number" then
        target = self.party[target]
    end

    if isClass(target) and target:includes(PartyBattler) then
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

        -- They got hit, so un-darken them
        target.should_darken = false
        target.targeted = true
    end

    -- Now it's time to actually damage them!
    if isClass(target) and target:includes(PartyBattler) then
        target:pierce(amount, exact)
        return {target}
    end

    if target == "ALL" then
        Assets.playSound("hurt")
        for _,battler in ipairs(self.party) do
            if not battler.is_down then
                battler:pierce(amount, exact, nil, {all = true})
            end
        end
        -- Return the battlers who aren't down, aka the ones we hit.
        return Utils.filter(self.party, function(item) return not item.is_down end)
    end
end

return Battle