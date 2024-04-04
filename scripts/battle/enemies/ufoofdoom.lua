local UFOOfDoom, super = Class(EnemyBattler)

function UFOOfDoom:init()
    super.init(self)

    -- Enemy name
    self.name = "UFO Of Doom"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("ufoofdoom")

    -- Enemy health
    self.max_health = 500
    self.health = 500
    -- Enemy attack (determines bullet damage)
    self.attack = 3
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 50
    self.experience = 13
	self.service_mercy = 10

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 34

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "thestars/starsides",
        "thestars/starcircle",
        "thestars/starfade",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {}

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 3 DF 0\n* HOLY SHIT"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The UFO Of Doom is here......",
        "* HOLY SHIT",
        "* You feel just like John Wick.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The UFO Of Doom is almost done for."

    self:registerAct("SUPER ACT", "", {"dess"})
end

function UFOOfDoom:onAct(battler, name)
    if name == "SUPER ACT" then
		Game.battle:startActCutscene("ufoofdoom", "kill")
        return
    elseif name == "Standard" then --X-Action
        if battler.chara.id == "ralsei" then
			-- Give the enemy 50% mercy
			self:addMercy(50)
            -- R-Action text
            return "* Ralsei passively made the UFO more friendly somehow."
        elseif battler.chara.id == "susie" then
            -- Give the enemy 50% mercy
			self:addMercy(50)
			-- S-Action text
            return "* Susie asked the UFO if it heard a buzzing sound."
        elseif battler.chara.id == "jamm" then
            -- Give the enemy 50% mercy
			self:addMercy(50)
			-- S-Action text
            return {
				"* Jamm asked the UFO to abduct him.",
				"* ...The UFO felt pity."
			}
		elseif battler.chara.id == "dess" then
            -- D-Action text
            return "* Dess did absolutely nothing."
        end
        -- Give the enemy 50% mercy
        self:addMercy(50)
        -- Text for any other character (like Noelle)
        return "* "..battler.chara:getName().." did something mysterious."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return UFOOfDoom
