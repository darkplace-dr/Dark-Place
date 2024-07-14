---@class Mimic : EnemyBattler
local Mimic, super = Class(EnemyBattler)

function Mimic:init()
    super.init(self)

    -- Enemy name
    self.name = "Tutorial Terry"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("tutorial_terry")

    -- Enemy health
    self.max_health = 999999
    self.health = 999999
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 2
	self.service_mercy = 0
	
	self.boss = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "unavoidable_terry"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Bruh..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT INF DF 2\n* You've upset the Gods."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {}

    self:registerAct("Anything")

    self.exit_on_defeat = false
    self.killable = false
end

function Mimic:onAct(battler, name)
    if name == "Anything" then
        return "* You didn't know what to do, bruh."
    elseif name == "Standard" then --X-Action
		return "* "..battler.chara:getName().." didn't know what to do, bruh."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Mimic
