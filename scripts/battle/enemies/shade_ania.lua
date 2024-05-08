local Shadynn, super = Class(EnemyBattler)

function Shadynn:init()
    super.init(self)

    -- Enemy name
    self.name = "Shade Ania"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("shade_ania")

    -- Enemy health
    self.max_health = 2300
    self.health = 2300
    -- Enemy attack (determines bullet damage)
    self.attack = 8
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = Game.battle.boss_rush and 0 or 100
    self.experience = 0
	self.service_mercy = 0
	
	self.boss = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "darkfire_down",
		"sing"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 8 DF 0\n* A deep memory from within Jamm's heart."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* A dark energy surrounds you, whispering around you.",
        "* The power of shadows spreads through the air.",
        "* Smells like strawberries.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Shade Ania's darkness fades."

    self:registerAct("Dispel")
    self:registerAct("Barrier", "Protect\nAll", {}, 70)
	
	self.siner = 0
	self.shadow = false
	
	self.tired_percentage = 0
    self.low_health_percentage = 0.1
	
	self.auto_spare = true
	
	self.cutscened = Game:getFlag("jamm_closure")
end

function Shadynn:getXAction(battler)
    return "Dispel"
end

function Shadynn:onAct(battler, name)
    if name == "Barrier" then
		Game.battle:startActCutscene(function(cutscene)
			cutscene:text("* " .. battler.chara:getName() .. " formed a strong barrier around the party!")
			for _,battler in ipairs(Game.battle.party) do
				battler:addShield(math.huge)
			end
		end)
		return
    elseif name == "Dispel" then
        -- Loop through all enemies
        self:addMercy(Game:getFlag("jamm_closure") and 2 or 5)
        return "* " .. battler.chara:getName() .. " dispels a bit of Shade Ania's magic."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Shadynn:update()
	super.update(self)
	if self.shadow then
		self.siner = self.siner + DT
		self.alpha = 0.7 + 0.1 * math.sin(self.siner * 2)
	else
		self.alpha = 1
	end
end

function Shadynn:onTurnStart()
	super.onTurnStart(self)
	if self.shadow then
		self.shadow = false
		self.siner = 0
		self:removeFX("shadow")
	end
end

function Shadynn:onHurt(damage, battler)
	super.onHurt(self, damage, battler)
	self.shadow = true
	self:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 90 end,
        ["wave_mag"] = 2,
        ["wave_height"] = 2,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }), "shadow")
end

function Shadynn:hurt(amount, battler, on_defeat, color)
	if not self.shadow then
		super.hurt(self, amount, battler, on_defeat, color)
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
	return super.selectWave(self)
end

function Shadynn:onSpared()
	super.onSpared(self)
	
	if not Game:getFlag("jamm_closure") then
		Game:setFlag("dungeonkiller", false)
	end
end

return Shadynn
