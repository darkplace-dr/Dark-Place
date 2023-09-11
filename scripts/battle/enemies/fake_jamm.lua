local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Jamm?"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("fake_jamm")
	
	self:setAnimation("idle")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100
    self.experience = 5
	self.service_mercy = 0
	
	self.boss = true
	
	self.dt = true
	
	self.dt_text = {"FAILURE","But it didn't work","Nope","Absorbed","Don't worry about it","I'm lovin' it"}

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "stick_thrust"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF INF\n* Just a faker."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Fake Jamm gives you a creepy smile."
    }
end

function Dummy:onAct(battler, name)
    if name == "Standard" then --X-Action
        return "* But "..battler.chara:getName().." couldn't think of what to do."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:hurt(amount, battler, on_defeat, color)
	self.health = 99999
	
	local x, y = self:getRelativePos(self.x, self.y)
	local message = DTText(self.dt_text, -28, -4)
	self:addChild(message)

	self.hurt_timer = 1
	self:onHurt(amount, battler)

	self:checkHealth(on_defeat, amount, battler)
end

return Dummy