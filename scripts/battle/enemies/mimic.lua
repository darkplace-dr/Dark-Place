local Mimic, super = Class(EnemyBattler)

function Mimic:init()
    super:init(self)

    -- Enemy name
    self.name = "Mimic"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("ufoofdoom")

    -- Enemy health
    self.max_health = 6400
    self.health = 6400
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 4
    -- Enemy reward
    self.money = 1000
	self.experience = 0
	

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        --"starsides"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        --"..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 10 DF 4\n* Uheehee!"

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
end

function Mimic:onAct(battler, name)
    if name == "Mutate" then
        
		Assets.playSound("sparkle_gem")
		for i=1,#Game.battle.party do
			Game.battle.party[i]:sparkle(1, 1, 1)
		end
		
		self.encounter.energy = self.encounter.energy + 10
		
		if self.encounter.energy >= 100 then
			self.encounter.energy = 150
			return "* Energy raised to "..self.encounter.energy.."%![wait:10]\n* Full power!"
		end
		
        return "* Energy raised to "..self.encounter.energy.."%!"
	
	elseif name == "X-Mutate" then
        
		Assets.playSound("boost")
		for i=1,#Game.battle.party do
			Game.battle.party[i]:sparkle(1, 1, 1)
			Game.battle.party[i]:flash()
		end
		
		self.encounter.energy = self.encounter.energy + 25
		
		if self.encounter.energy >= 100 then
			self.encounter.energy = 150
			return "* Energy raised to "..self.encounter.energy.."%!!![wait:10]\n* Full power!"
		end
		
        return "* Energy raised to "..self.encounter.energy.."%!!!"

	elseif name == "Send" then
		
		if self.encounter.energy > 0 then
		
			Assets.playSound("scytheburst")
			self:flash()
		
			self:addMercy(self.encounter.energy / 5)
			self.encounter.energy = 0
			
			return "* Energy was sent to Mimic!"
		else
		
			return "* There's nothing to send!"
		
		end

    elseif name == "Standard" then --X-Action
        if battler.chara.id == "ralsei" then
			self.encounter.energy = self.encounter.energy + 5
            -- R-Action text
            return "* Ralsei generated a bit of energy!"
        elseif battler.chara.id == "susie" then
			self.encounter.energy = self.encounter.energy + 5
			-- S-Action text
            return "* Susie generated a bit of energy!"
		elseif battler.chara.id == "dess" then
			self.encounter.energy = self.encounter.energy + 5
            -- D-Action text
            return "* Dess generated a bit of energy!"
        else
			self.encounter.energy = self.encounter.energy + 5
			-- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." generated a bit of energy!"
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end



return Mimic