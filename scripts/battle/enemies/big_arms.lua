local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Big Arms"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("big_arms")

    -- Enemy health
    self.max_health = 1000
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 999
    -- Enemy reward
    self.money = 0
    self.experience = 0

    self.boss = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.disable_mercy = true

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "egg2_swing"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF INF\n* Truly the final boss of all time."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Eggman gives an evil laugh.",
        "* Time to crack this egg!",
        "* Smells like bacon.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Smoke is coming out of Big Arms."

    self.exit_on_defeat = false
    self.killable = false
end

function Dummy:onAct(battler, name)
	if name == "Light Speed" then -- Jamm
		Game.battle.encounter.light_speed = true
		return "Jamm boosted the SOUL's homing attack!"
	elseif name == "High Jump" then -- Mario
		Game.battle.encounter.high_jump = true
		return "Mario gets in a few practice jumps..."
    elseif name == "Standard" then
		return "* This shouldn't happen."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:getXAction(battler)
	if battler.chara.id == "mario" then
        return "High Jump"
    elseif battler.chara.id == "jamm" then
        return "Light Speed"
	end
	return "Standard"
end

function Dummy:onDefeat(damage, battler)
    self:defeat("VIOLENCE", true)
end

return Dummy