local Shadynn, super = Class(EnemyBattler)

function Shadynn:init()
    super.init(self)

    -- Enemy name
    self.name = "Shade Ania"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("shade_ania")

    -- Enemy health
    self.max_health = 1700
    self.health = 1700
    -- Enemy attack (determines bullet damage)
    self.attack = 8
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100
    self.experience = 5

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 8 DF 0\n* A deep memory from within Jamm's heart."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Shade Ania's darkness fades."

    self:registerAct("Dispell")
    self:registerAct("Barrier", "Protect\nAll", {"jamm"}, 70)
	
	self.siner = 0
	self.shadow = false
	
	self.tired_percentage = 0
    self.low_health_percentage = 0.1
end

function Shadynn:getXAction(battler)
    return "Dispell"
end

function Shadynn:onAct(battler, name)
    if name == "Barrier" then
		Game.battle:startActCutscene(function(cutscene)
			cutscene:text("* Jamm formed a strong barrier around the party!")
			for _,battler in ipairs(Game.battle.party) do
				battler:addShield(1000)
			end
		end)
		return
    elseif name == "Dispell" then
        -- Loop through all enemies
        self:addMercy(5)
        return "* " .. battler.chara:getName() .. " dispells a bit of Shade Ania's magic."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Shadynn:update()
	super:update(self)
	if self.shadow then
		self.siner = self.siner + DT
		self.alpha = 0.7 + 0.1 * math.sin(self.siner * 2)
	else
		self.alpha = 1
	end
end

function Shadynn:onTurnStart()
	super:onTurnStart(self)
	if self.shadow then
		self.shadow = false
		self.siner = 0
		self:removeFX("shadow")
	end
end

function Shadynn:onHurt(damage, battler)
	super:onHurt(self, damage, battler)
	self.shadow = true
	self:addFX(ShaderFX(Mod.wave_shader, {
        ["wave_sine"] = function() return Kristal.getTime() * 90 end,
        ["wave_mag"] = 2,
        ["wave_height"] = 2,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }), "shadow")
end

function Shadynn:hurt(amount, battler, on_defeat, color)
	if not self.shadow then
		super:hurt(self, amount, battler, on_defeat, color)
		self.shadow = true
	else
		self:statusMessage("msg", "miss")
	end
end

function Shadynn:selectWave()
	if Game.battle.turn_count%5 == 3 then
		if self.cutscened then
			self.selected_wave = "unavoidable_ania"
		else
			self.selected_wave = "unavoidable_first_ania"
			self.cutscened = true
		end
		return self.selected_wave
	end
	return super:selectWave(self)
end

return Shadynn