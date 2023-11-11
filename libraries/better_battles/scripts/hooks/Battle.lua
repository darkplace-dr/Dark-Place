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
        
        -- self.money = self.money + (math.floor(((Game:getTension() * 2.5) / 10)) * Game.chapter)

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
        
        local earn_text = ""
        if self.money ~= 0 or self.xp ~= 0 then
            earn_text = "* Ran away with " .. self.xp .. " EXP and " .. self.money .. " "..Game:getConfig("darkCurrencyShort").."."
        end
            
        if self.used_violence and Game:getConfig("growStronger") then
            local stronger = "You"

            for _,battler in ipairs(self.party) do
                Game.level_up_count = Game.level_up_count + 1
                battler.chara:onLevelUp(Game.level_up_count)

                if battler.chara.id == Game:getConfig("growStrongerChara") then
                    stronger = battler.chara:getName()
                end
            end

            earn_text = "* Ran away with " .. self.money .. " "..Game:getConfig("darkCurrencyShort")..".\n* "..stronger.." became stronger."

            Assets.playSound("dtrans_lw", 0.7, 2)
            --scr_levelup()
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
		
        if earn_text == "" then
            flee_text = flee_text .. Utils.pick(flee_list)
        else
            flee_text = earn_text
        end
		
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