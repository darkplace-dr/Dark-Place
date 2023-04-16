local Mimic, super = Class(EnemyBattler)

function Mimic:init()
    super.init(self)

    -- Enemy name
    self.name = "Mimic"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("ufoofdoom")

    -- Enemy health
    self.max_health = 4400
    self.health = 4400
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = 1000
    self.experience = Mod:isInRematchMode() and 0 or 50

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "mimic/starsidesmimic",
		"mimic/starcirclemimic",
		"mimic/starfademimic",
        "mimic/diamonds_aimmimic",
        "mimic/diamonds_upmimic",
        "mimic/bouncymimic",
		-- add more, please :)
		-- (PS, bonus points if it's an upgraded version of another enemy's attack to stick with the theme)
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Uheehee!",
		"Here or there?",
		"Can you see me?",
		"Maybe, maybe not!",
		"From the darkness\ncomes stars!",
		"From the cold\ncomes warmth!",
		"From the clock\ncomes destiny!",
		"Will you find out?",
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 10 DF 2\n* Uheehee!"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Uheehee!",
        "* The air grows cold.",
        "* It's too easy to become anyone you want to be!",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Mimic grows exhausted."
	self.tired_percentage = 0.15

    self:registerAct("Mutate", "TP to\nEnergy", nil, 10)
	self:registerAct("X-Mutate", "All to\nEnergy", "all", 25)
	self:registerAct("Send", "Send All\nEnergy", "all")

    self.exit_on_defeat = false
    self.killable = false

    self.current_actor = "ufoofdoom"
end

function Mimic:onAct(battler, name)
    if name == "Mutate" then
		Assets.playSound("sparkle_gem")
		for _, ally in ipairs(Game.battle.party) do
			ally:sparkle(1, 1, 1)
		end
		self.encounter.energy = self.encounter.energy + 10
		if self.encounter.energy >= 100 then
			self.encounter.energy = 150
			return "* Energy raised to "..self.encounter.energy.."%![wait:10]\n* Full power!"
		end
        return "* Energy raised to "..self.encounter.energy.."%!"
	elseif name == "X-Mutate" then
		Assets.playSound("boost")
		for _, ally in ipairs(Game.battle.party) do
			ally:sparkle(1, 1, 1)
            ally:flash()
		end
		self.encounter.energy = self.encounter.energy + 25
		if self.encounter.energy >= 100 then
			self.encounter.energy = 150
			return "* Energy raised to "..self.encounter.energy.."%!!![wait:10]\n* Full power!"
		end
        return "* Energy raised to "..self.encounter.energy.."%!!!"
	elseif name == "Send" then
		if self.encounter.energy <= 0 then
			return "* There's nothing to send!"
		end

        Assets.playSound("scytheburst")
        self:flash()
    
        self:addMercy(self.encounter.energy / 5)
        self.encounter.energy = 0
        
        return "* Energy was sent to Mimic!"
    elseif name == "Standard" then --X-Action
        self.encounter.energy = self.encounter.energy + 5
		return "* "..battler.chara:getName().." generated a bit of energy!"
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Mimic:onDefeat(damage, battler)
    if not Mod:isInRematchMode() then
        self:defeat("KILLED", true)
    else
        self:defeat("VIOLENCE", true)
    end

    Game.battle:startActCutscene("mimic.dies", battler, self)
end

return Mimic