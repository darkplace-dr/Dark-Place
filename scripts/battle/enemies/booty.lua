local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Booty"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("booty")

    -- Enemy health
    self.max_health = 3000
    self.health = 3000
    -- Enemy attack (determines bullet damage)
    self.attack = 8
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = Game:getFlag("booty_finished") and 0 or 100
    self.experience = Game:getFlag("booty_finished") and 0 or 50
	self.service_mercy = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "booty_surround",
		"booty_stomp"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 8 DF 2\n* A greed for cash,[wait:5] and his button eyes are on you."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Thousands of SpongeRobs and Fox Dolls watch the battle.",
        "* Your best bootleg.",
        "* Smells like human hearts.[wait:5]\n* No,[wait:5] not souls.[wait:5] Actual hearts.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* One of Booty's button eyes fall off."
	
	self.tired_percentage = 0
end

function Dummy:onAct(battler, name)
    if name == "Standard" then
		if battler.chara.id == "jamm" and Game:getFlag("marcy_joined") then
			return "* But neither Jamm nor Marcy knew what to do."
		end
        return "* But "..battler.chara:getName().." didn't know what to do."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:onDefeat(...)
    if self.defeat_once then
        super.onDefeat(self, ...)
    end
end

function Dummy:update()
	super.update(self)
	self:setTired(false)
end

return Dummy
