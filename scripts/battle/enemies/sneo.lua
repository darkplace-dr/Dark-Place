local SpamtonNEO, super = Class(EnemyBattler)

function SpamtonNEO:init()
    super.init(self)

    self.name = "Spamton NEO"
    self:setActor("spamtonneo")

    self.max_health = 9618
    self.health = 9618
    self.attack = 13
    self.defense = 1
    self.gold = 0

    self.waves = {
        "sneo/flyingheads",
        "sneo/firework_pipis",
        "sneo/phoneshooter",
        "sneo/pendulum",
        "sneo/pipis_test",
    }

	self.boss = true
    self.difficulty = 0

    self.dialogue_offset = {-45, -24}
    self.spare_points = 0
    self.service_mercy = 5
    self.check_count = 0

    self.text = {
        "* Spamton turns to the audience and laughs.",
        "* Spamton appeals to the audience with a festive jig!",
        "* Spamton begs to the audience,\nSpamton prays to the audience.",
        "* There is no audience.",
        "* Spamton begs the audience to stop taking the furniture out of his room.",
        "* The air crackles with freedom.",
        "* It pulls the strings and makes them ring.",
        "* The stage lights are shattered.",
        "* Smells like rotten glass."
    }

    self.text_override = nil

    self:registerAct("Snap")
    self:registerAct("SnapAll", "", "all")

    self.sneo_attack = 0
    self.sneo_turn = 0
	
    self.timer = 0
    self.mode = "normal"
    self.old_x = self.x
    self.old_y = self.y
    self.ease = false
    self.ease_timer = 0
	
    self.fake_x = 460
    self.fake_y = 80
	
    self.hurttimer = 0
    self.smoketimer = 0
	
    self.funnycheattimer = 0
    self.funnycheattimer2 = 0
    self.funnycheattimer3 = 0
    self.honk = false
	
    self.hellmode = false
end

function SpamtonNEO:setMode(mode)
    self.mode = mode
    self.old_x = self.x
    self.old_y = self.y
    self.ease = true
    self.ease_timer = 0
end

function SpamtonNEO:update()
    super.update(self)

    -- movements
    if not self.done_state and (Game.battle:getState() ~= "TRANSITION") then
        self.timer = self.timer + (1 * DTMULT)

        local wanted_x = self.old_x
        local wanted_y = self.old_y

        if self.mode == "normal" then
            wanted_x = 518
            wanted_y = 250
        elseif self.mode == "move_back" then
            wanted_x = 518 + 300
            wanted_y = 250
        elseif self.mode == "move_up" then
            wanted_x = 518
            wanted_y = 250 - 300
        elseif self.mode == "shoot" then
            wanted_x = 518 + (math.cos(self.timer * 0.04) * 40)
            wanted_y = 250 + (math.cos(self.timer * 0.2) * 10)
        end

        if not self.ease then
            self.x = wanted_x
            self.y = wanted_y
        else
            self.ease_timer = self.ease_timer + (0.05 * DTMULT)
            self.x = Ease.inQuad(self.ease_timer, self.old_x, wanted_x - self.old_x, 1)
            self.y = Ease.inQuad(self.ease_timer, self.old_y, wanted_y - self.old_y, 1)
            if self.ease_timer >= 1 then
                self.ease = false
            end
        end
    end

    if Game.battle.encounter.funnycheat > 5 then
        if self.funnycheattimer < 28 then
            self.funnycheattimer = self.funnycheattimer + 0.125 * DTMULT
            self.sprite.head.color = Utils.mergeColor(COLORS["white"], COLORS["red"], self.funnycheattimer / 30)
        end
		
        if self.funnycheattimer >= 24 then
            if self.honk == false then
                Assets.playSound("carhonk")
                self.honk = true
            end
            self.funnycheattimer3 = self.funnycheattimer3 + DTMULT
        end
		
        if self.funnycheattimer3 > 0 and self.funnycheattimer3 < 6 then
            self.sprite.head.sprite:setScale(Utils.lerp(1, 2, self.funnycheattimer3 / 6))
        end
        if self.funnycheattimer3 > 8 and self.funnycheattimer3 < 16 then
            self.sprite.head.sprite:setScale(Utils.lerp(2, 1, (self.funnycheattimer3 - 8) / 8))
        end
        if self.funnycheattimer3 > 16 and self.funnycheattimer3 < 24 then
            self.sprite.head.sprite:setScale(Utils.lerp(1, 2, (self.funnycheattimer3 - 16) / 6))
        end
        if self.funnycheattimer3 > 24 and self.funnycheattimer3 < 32 then
            self.sprite.head.sprite:setScale(Utils.lerp(2, 0.9339, (self.funnycheattimer3 - 24) / 8))
        end
		
        if self.funnycheattimer3 >= 4 and self.funnycheattimer3 <= 10 or self.funnycheattimer3 >= 20 and self.funnycheattimer3 <= 26 then
            self.sprite:setPartShaking("head", -12 + Utils.random(24))
        else
            self.sprite:setPartShaking("head", 0)
        end
    end

    for _,enemy in pairs(Game.battle.enemy_world_characters) do
        enemy:remove()
    end
end

function SpamtonNEO:onAct(battler, name)
	if name == "Check" then
	    if battler.chara.id == "YOU" then
            Assets.playSound("check")
        end
	    if self.check_count == 0 then
		    self.check_count = self.check_count + 1
		    return {
		    "* SPAMTON NEO - BEST UPGRADED ATTACK AND DEFENSE IN TOWN!!!\nFIT FOR A [[Big Shot]]!",
		    '* (DISCLAIMER: STILL A LITTLE\nBIT "[color:yellow]SHAKY[color:reset]").'
		    }
		else
		    return {
		    "* Spamton Neo - Just as desparate,[wait:5] as he was before...",
		    }
		end
	elseif name == "Snap" then
        local upcount = 0
        for i,battler in ipairs(Game.battle.party) do
            if not battler.is_down then
                upcount = upcount + 1
            end
        end

        if upcount == 1 then 
            self:addMercy(4)
        else
            self:addMercy(2)
        end
		
		self.sprite:snapString()
		Assets.playSound("damage")

		if battler.chara.id == "kris" then
            Game.battle:startActCutscene(function(cutscene)
                if upcount == 1 then 
                    cutscene:text("* Kris snapped desperately!")
                else
                    cutscene:text("* Kris snapped a wire!")
                end
            end)
            return
		elseif battler.chara.id == "susie" then
            Game.battle:startActCutscene(function(cutscene)
                if upcount == 1 then 
                    cutscene:text("* Susie snapped desperately!")
                else
                    cutscene:text("* Susie snapped a wire!")
                end
            end)
            return
        elseif battler.chara.id == "ralsei" then
            Game.battle:startActCutscene(function(cutscene)
                if upcount == 1 then 
                    cutscene:text("* Ralsei snapped desperately!")
                else
                    cutscene:text("* Ralsei snapped a wire!")
                end
            end)
            return
		else
            Game.battle:startActCutscene(function(cutscene)
                if upcount == 1 then 
                    cutscene:text("* "..battler.chara:getName().." snapped desperately!")
                else
                    cutscene:text("* "..battler.chara:getName().." snapped a wire!")
                end
            end)
            return
		end
	elseif name == "SnapAll" then
		self:addMercy(5)
		Assets.playSound("damage")
		self.sprite:snapStrings(4)
		return {
		"* Everyone snapped wires!"
		}
	end
	return super.onAct(self, battler, name)
end

function SpamtonNEO:getXAction(battler)
	return "Snap"
end

function SpamtonNEO:isXActionShort(battler)
    return false
end

return SpamtonNEO