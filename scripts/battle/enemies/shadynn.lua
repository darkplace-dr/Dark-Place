local Shadynn, super = Class(EnemyBattler)

function Shadynn:init()
    super.init(self)

    self.name = "Shadynn"
    self:setActor("shadynn")

    self.path = "battle/enemies/shadynn"
    self.default = "idle"

    self.max_health = 200
    self.health = 200
    self.attack = 6
    self.defense = 0
    self.money = 30

    self.spare_points = 25
	self.service_mercy = 15

    self.waves = {
        "rudinn/diamonds_up",
        "rudinn/diamonds_aim"
    }

    self.check = "AT 6 DEF 0\nThis shadowy diamond isn't\nany girl's best friend."

    self.text = {
        "* Shadynn is dimming plainly.",
        "* Shadynn has no strong opinions\none way or the other.",
        "* Shadynn thinks about elaborate\nstones."
    }

    self.low_health_text = "* Shadynn's darkness fades."

    self:registerAct("Convince")
    self:registerAct("Lecture")

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
            return "* Dess extinguishes a fire."
        end
    end
    return nil
end


function Shadynn:onAct(battler, name)
    if name == "Convince" then
        self:addMercy(50)
        return "* Jamm told Shadynn to quit fighting.\n* It grew more convinced."
    elseif name == "Lecture" then
        self:setTired(true)
        self.text_override = "(Yawn)...\nWhat? OK.."
        return "* Jamm lectured Shadynn on the\nimportance of kindness.\nShadynn became [color:blue]TIRED[color:reset]..."
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "dess" then
			self.text_override = "Oh!\nThey are??"
			Game.battle:startActCutscene(function(cutscene)
				cutscene:text("* Dess tried to trick Shadynn!")
				cutscene:text("* your shoes are untied lmao", "heckyeah", "dess")
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

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "Yeah I\nguess that\nmakes\nsense.",
            "Alright,\nyou convinced\nme!!"
        }
    else
        dialogue = {
            "I'm a\nnormal\nperson.",
            "Shade,\nshade",
            "Face my\nStone\nCutter!"
        }
    end
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