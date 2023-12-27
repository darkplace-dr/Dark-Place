local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Eggman arrives."

    -- Battle music ("battle" is rude buster)
    self.music = "egg_1"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self.eggman = self:addEnemy("eggman")

    self.old_x = self.eggman.x
    self.old_y = self.eggman.y

    self.timer = 0

    self.mode = "normal"

    self.ease = false

    self.ease_timer = 0
	
    self.death_cine_played = false
    self.death_cine_played_2 = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")

	self.flee = false
end

function Dummy:onBattleInit()
    super.onBattleInit(self)
	if Game.current_rush == "Jamm Rush" then
		local bg = Sprite("battle/rush_bgs/jamm_rush")
		Game.battle:addChild(bg)
		bg.layer = BATTLE_LAYERS["bottom"]
		bg.alpha = 0
		Game.battle.timer:tween(0.4, bg, {alpha = 1}, "linear")
    end
end

function Dummy:onActionsEnd()
    if not self.big_arms and (self.eggman.done_state == "VIOLENCE" or self.eggman.done_state == "KILLED") and not self.death_cine_played then
        self.death_cine_played = true
        local cutscene = Game.battle:startCutscene("eggman.phase1to2", nil, self.eggman)
        cutscene:after(function ()
            Game.battle:setState("ACTIONSELECT")
        end)
        return true
	elseif self.big_arms and (self.big_arms.done_state == "VIOLENCE" or self.big_arms.done_state == "KILLED") and not self.death_cine_played_2 then
        self.death_cine_played_2 = true
        local cutscene = Game.battle:startCutscene("eggman.ending", nil, self.big_arms)
        return true
    end
end

function Dummy:setMode(mode)
	self.mode = mode
	if not self.big_arms then
		self.old_y = self.eggman.y
	else
		self.old_y = self.big_arms.y
	end
	self.ease = true
	self.ease_timer = 0
end

function Dummy:update()
    super.update(self)

	if not self.big_arms then
		if not self.eggman.done_state and (Game.battle:getState() ~= "TRANSITION") then
			self.timer = self.timer + (1 * DTMULT)

			local wanted_y = self.eggman.old_y

			if self.mode == "normal" then
				wanted_y = 238 + (math.sin(self.timer * 0.04) * 10)
			end

			if not self.ease then
				self.eggman.y = wanted_y
			else
				self.ease_timer = self.ease_timer + (0.05 * DTMULT)
				self.eggman.y = Ease.outQuad(self.ease_timer, self.old_y, wanted_y - self.old_y, 1)
				if self.ease_timer >= 1 then
					self.ease = false
				end
			end
		end
	else
		if not self.big_arms.done_state and (Game.battle:getState() ~= "TRANSITION") then
			self.timer = self.timer + (1 * DTMULT)

			local wanted_y = self.big_arms.old_y

			if self.mode == "normal" then
				wanted_y = 238 + (math.sin(self.timer * 0.04) * 10)
			end

			if not self.ease then
				self.big_arms.y = wanted_y
			else
				self.ease_timer = self.ease_timer + (0.05 * DTMULT)
				self.big_arms.y = Ease.outQuad(self.ease_timer, self.old_y, wanted_y - self.old_y, 1)
				if self.ease_timer >= 1 then
					self.ease = false
				end
			end
		end
	end

    for _,enemy in pairs(Game.battle.enemy_world_characters) do
        enemy:remove()
    end
end

function Dummy:createSoul(x, y, color)
	return HomingSoul(x,y)
end

return Dummy
