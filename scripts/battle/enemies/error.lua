local Error, super = Class(EnemyBattler)

function Error:init()
    super.init(self)

    -- Enemy name
    self.name = "ERROR"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("error")

    -- Enemy health
    self.max_health = 800
    self.health = 800
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 4
    -- Enemy reward
    self.money = 200
	self.service_mercy = 5

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 10

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "error_basic",
        "error_aiming",
        "error_movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    -- self.dialogue = {
        -- "..."
    -- }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 10 DF 4\n[color:red]* Error: Could not load Library Client"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* There's a feeling of fustration in the air.",
        "* The console log is filled with errors.",
        "* Smells like bad programming.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The broken model\nis starting to glitch."

    -- Register act called "Fix"
    self:registerAct("Fix")
    -- Register party act with Ralsei called "Sleep Mode"
    -- (second argument is description, usually empty)
    self:registerAct("Sleep Mode", "", {"ralsei"})
end

function Error:onAct(battler, name)
    if name == "Fix" then
        -- Give the enemy 25% mercy
        self:addMercy(25)
        -- Change this enemy's dialogue for 1 turn
        -- self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You tried to fix the error.[wait:10].[wait:10].[wait:20]\n* It seems to be working better now.",
            "* But you get that feeling that 2 more things are now broken because of that."
        }

    elseif name == "Sleep Mode" then
		self:setTired(true)
        return "* You and Ralsei have pressed\nthe sleep button.\n* The ERROR became [color:blue]TIRED[color:reset]..."
    elseif name == "Standard" then --X-Action
        -- Give the enemy 15% mercy
		if battler.chara.id ~= "dess" then
			self:addMercy(15)
		end
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei looked into the code and fixed a math error.[wait:5]\n* Who even tried to divide by zero?"
        elseif battler.chara.id == "susie" then
            -- S-Action text
            return "* Susie looked into the code and started entering random values out of fustration."
        elseif battler.chara.id == "noelle" then
            -- N-Action text
            return "* Noelle looked into the code and added funny comments for anyone else who may look at it."
        elseif battler.chara.id == "dess" then
            -- N-Action text
            return "* Dess did absolutely nothing."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." looked into the code and fixed a syntax error."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Error