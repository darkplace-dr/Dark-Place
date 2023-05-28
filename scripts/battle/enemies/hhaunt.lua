local HHaunt, super = Class(EnemyBattler)

function HHaunt:init()
    super.init(self)

    -- Enemy name
    self.name = "H. Haunt"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("hhaunt")

    -- Enemy health
    self.max_health = 850
    self.health = 850
    -- Enemy attack (determines bullet damage)
    self.attack = 7
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 45
    self.experience = 8

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "uwforest/scytheBoomerang",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {"..."}

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT "..self.attack.." DF "..self.defense.."\n* The 'H' at the start stands for 'Hockey'."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* H.Haunt is wondering why it put tape on it's scythe.",
		"* H.Haunt is thinking about buying a machete.",
		"* H.Haunt is slightly afraid of you, but is trying not to show it.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* H.Haunt's mask is cracked."
	
	
	self:registerAct("Magic", "", nil, 10)
	
	if Game:hasPartyMember("susie") then
		self:registerAct("Terrorize", "", {"susie"})
	end
	if Game:hasPartyMember("noelle") then
		self:registerAct("Be Scared", "", {"noelle"})
	end
	if Game:hasPartyMember("ralsei") then
		self:registerAct("Befriend", "", {"ralsei"})
	end
	if Game:hasPartyMember("noyno") then
		self:registerAct("Exorcise", "", {"noyno"})
	end
	
	
	
	self.timer = 0
	
end

function HHaunt:onAct(battler, name)
    if name == "Magic" then
		Assets.playSound("hypnosis")
		self:addMercy(25)
		self.attack = self.attack + 1
		self.defense = self.defense + 1
        return "* "..battler.chara.name.." chanted something!\n* H.Haunt's ATTACK and DEFENSE went up!"
	elseif name == "Terrorize" then
		Game.battle:startActCutscene("hhaunt", "terrorize")
		self:addMercy(25)
		if self.attack > 3 then
			self.attack = self.attack - 2
		end
		self.defense = self.defense + 3
		return
	elseif name == "Be Scared" then
		Game.battle:startActCutscene("hhaunt", "bescared")
		self:addMercy(25)
		self.attack = self.attack + 3
		if self.defense > -5 then
			self.defense = self.defense - 2
		end
		return
	elseif name == "Befriend" then
		Game.battle:startActCutscene("hhaunt", "befriend")
		if self.attack > 3 then
			self.attack = self.attack - 2
		end
		if self.defense > -5 then
			self.defense = self.defense - 2
		end
		return
	elseif name == "Exorcise" then
		Game.battle:startActCutscene("hhaunt", "exorcise")
		self:addMercy(25)
		return
    elseif name == "Standard" then --X-Action
	
		self:addMercy(10)
	
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei pretended to be a witch."
        elseif battler.chara.id == "susie" then
			-- S-Action text
            return "* Susie acted like an axe murderer."
		elseif battler.chara.id == "noelle" then
            -- N-Action text
            return "* Noelle did her best banshee impression."
		elseif battler.chara.id == "dess" then
            -- D-Action text
            return "* Dess was spooky... somehow."
		elseif battler.chara.id == "brandon" then
            -- B-Action text
            return "* Brandon mirrored the enemy."
		elseif battler.chara.id == "robo_susie" then
            -- RS-Action text
            return "* (Other?) Susie talked fondly of their time as an axe murderer."
		elseif battler.chara.id == "noyno" then
            -- N-Action text
            return "* Noyno pretended to be a wizard."
		elseif battler.chara.id == "dumbie" then
            -- D-Action text
            return "* Dumbie made ghost noises."
        end
        -- Text for any other character
        return "* "..battler.chara:getName().." pretended to be a halloween monster."
    end
	
	self.check = "AT "..self.attack.." DF "..self.defense.."\n* The 'H' at the start stands for 'Hockey'."
	
    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function HHaunt:update()
	super.update(self)
	
	
	if Game.battle.transition_timer >= 10 and not self.starty then
		
		self.starty = self.y
	
	end
	
	if self.starty then
		self.timer = self.timer + (1 * DTMULT)
		
		self.y = self.starty + (math.sin(self.timer * 0.1) * 16)
	end
	
end

return HHaunt
