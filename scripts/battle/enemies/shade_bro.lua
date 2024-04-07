local Shadynn, super = Class(EnemyBattler)

function Shadynn:init()
    super.init(self)

    self.name = "Shade Bro"
    self:setActor("shade_bro")

    self.path = "battle/enemies/shade_bro"
    self.default = "idle"

    self.max_health = 200
    self.health = 200
    self.attack = 6
    self.defense = 0
    self.money = 30

    self.spare_points = 25
	self.service_mercy = 15

    self.waves = {
        "lob_hammer"
    }

    self.check = "AT 6 DEF 0\nIf you can dodge a hammer,\nyou can dodge a ball."

    self.text = {
        "* Shade Bro wonders why it can only lob hammers.",
        "* Shade Bro flips a hammer and lands it on its top.",
        "* Shade Bro asks if it can borrow a fire flower."
    }

    self.low_health_text = "* Shade Bro's darkness fades."

    self:registerAct("Bat Up", nil, {"dess"})
    self:registerAct("Compliment")

    self.text_override = nil
	
	self.siner = 0
	self.shadow = false
end

function Shadynn:isXActionShort(battler)
    return true
end

function Shadynn:onShortAct(battler, name)
    if name == "Lecture" then
		self.setTired(true)
        return "* " .. battler.chara:getName() .. " lectured the enemies on the\nimportance of kindness."
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "dess" then
			self:hurt(1)
            return "* Dess throws a bat."
        end
    end
    return nil
end


function Shadynn:onAct(battler, name)
    if name == "Bat Up" then
        self:addMercy(100)
		Game.battle:startActCutscene(function(cutscene)
			cutscene:text("* Jamm takes Dess's bat and prepares to bat a hammer.")
			cutscene:text("* Batter up!", "smug", "jamm")
			cutscene:text("* Dess takes the bat and hits Jamm with it.")
			battler:hurt(1)
			cutscene:wait(1)
			cutscene:text("* Worth it.", "smirk", "jamm")
		end)
        return
    elseif name == "Compliment" then
		if Game.battle.turn_count > 1 then
			self:addMercy(50)
			self.text_override = "N-nobody ever\nsaid THAT to\nme before!"
			return "* Jamm complimented Shade Bro on its hammer throwing skills."
		else
			self:setTired(true)
			self.text_override = "I didn't do\nanything\nyet..."
			return {"* Jamm complimented Shade Bro on its hammer throwing skills.", "* Shade Bro, having done nothing yet, became [color:blue]TIRED[color:reset] from confusion."}
		end
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "dess" then
			self.text_override = "Not bad!\nNot bad\nat all!"
			Game.battle:startActCutscene(function(cutscene)
				cutscene:text("* Dess throws her bat at Shade Bro.")
				self:hurt(1)
				cutscene:wait(1)
				cutscene:text("* Shade Bro gives Dess a nod.")
			end)
        end
    end
    return super.onAct(self, battler, name)
end

function Shadynn:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

    local dialogue = {
        "Hammers\nare life!",
        "All hail\nthe king!",
        "Hammers,\nbro!"
    }
    return dialogue[math.random(#dialogue)]
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

function Shadynn:onSpared()
	super.onSpared(self)
	
	Game:setFlag("dungeonkiller", false)
end

return Shadynn