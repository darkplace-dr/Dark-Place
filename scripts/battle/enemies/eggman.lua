local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Eggman"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("eggman")

    -- Enemy health
    self.max_health = 1000
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 0
    self.experience = 0
	self.service_mercy = 0

    self.boss = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.disable_mercy = true

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "egg_swing",
		"egg_burn",
		"egg_spike",
		"egg_labyrinth",
		"egg_launch"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Best scrambled, like his plans."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Eggman gives an evil laugh.",
        "* Time to crack this egg!",
        "* Smells like bacon.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Smoke is coming out of the Eggmobile."

    self.exit_on_defeat = false
    self.killable = false
	
	self.tired_percentage = 0
end

function Dummy:onAct(battler, name)
    if name == "Standard" then --X-Action
		if battler.chara.id == "jamm" and Game:getFlag("marcy_joined") then
			return "* But neither Jamm nor Marcy knew what to do."
		end
        return "* " .. battler.chara.name .. " didn't know what to do."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:selectWave()
	local index = Game.battle.turn_count%5
	if index == 0 then
		index = 5
	end
	self.selected_wave = self.waves[index]
    return self.waves[index]
end

function Dummy:onDefeat(damage, battler)
    self:defeat("VIOLENCE", true)
end

return Dummy