local Bobberry, super = Class(EnemyBattler)

function Bobberry:init()
    super.init(self)

    -- Enemy name
    self.name = "Bobberry"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("bobberry")

    -- Enemy health
    self.max_health = 400
    self.health = 400
    -- Enemy attack (determines bullet damage)
    self.attack = 8
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 80
    self.experience = 12

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "bobberry1",
        "bobberry1",
        "bobberry2"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Hello yes\nI am Bobberry",
		"Don't make me use\nmy Bobberry Beam",
		"Please don't kill me"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 8 DF 0\n* It's fucking Bobberry."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Bobberry is clutching very hard to his berry.",
        "* Gaming.",
        "* It would be really funny if you hit Bobberry lmao.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Bobberry's not clutching so hard to his berry anymore."

    -- Register act called "Smile"
    self:registerAct("Orbulate")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Take Berry", "", {"susie"})
end

function Bobberry:onAct(battler, name)
    if name == "Orbulate" then
        -- Give the enemy 100% mercy
        self:addMercy(50)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "god I fucking love orbs"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* What the hell does 'orbulate' mean?[wait:10]\n* It doesn't really matter.",
        }

    elseif name == "Take Berry" then
        -- Loop through all enemies
        --for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            --enemy:setTired(true)
			--self:
        --end
		if Game:getFlag("tookberry") then
			return "* Haven't you already taken enough?"
		else
			if self.health <= self.max_health / 2 then
				self:setActor("bob")
				self.name = "Bob"
				Game:setFlag("tookberry", true)
				Game.inventory:addItem("berry")
				self.check = "AT 5 DF -5\n* It's Bob."
				self.attack = 5
				self.defense = -5
				self.dialogue = {
					"..."
				}
				self.text = {
					"* Bob."
				}
				self.waves = {}
				self.low_health_text = "* Bob."
				return "* You took Bobberry's Berry.[wait:15]\n* Now he's just 'Bob'."
			else
				return "* You can't take his Berry!\n* He's not at low enough HP!"
			end
		end

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(25)
        if battler.chara.id == "brenda" then
            -- R-Action text
            return "* Brenda offered Bobberry some food.\n* Bobberry politely declined."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            return "* Susie shook a tree really hard and a bunch of berries came down."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Bobberry
