local Shadynn, super = Class(EnemyBattler)

function Shadynn:init()
    super.init(self)

    -- Enemy name
    self.name = "Shade Ania"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 1500
    self.health = 1500
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

    -- Register act called "Smile"
    self:registerAct("Smile")
    self:registerAct("Barrier", "Protect\nAll", {"jamm"}, 70)
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Tell Story", "", {"ralsei"})
	
	self.siner = 0
	self.shadow = false
	
	self.tired_percentage = 0
    self.low_health_percentage = 0.1
end


function Shadynn:onAct(battler, name)
    if name == "Barrier" then
		Game.battle:powerAct("super_shield", battler, "jamm")
    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "* You and Ralsei told the dummy\na bedtime story.\n* The enemies became [color:blue]TIRED[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
		elseif battler.chara.id == "dess" then
            -- D-Action text
            return "* Dess spun something around."
		elseif battler.chara.id == "jamm" then
            -- J-Action text
            return "* Jamm shot a rock in the air.\nIt landed perfectly on Dummy's hat!"
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
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

return Shadynn