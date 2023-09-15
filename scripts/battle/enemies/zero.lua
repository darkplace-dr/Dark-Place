local Zero, super = Class(EnemyBattler)

function Zero:init()
    super.init(self)

    -- Enemy name
    self.name = "Zero"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("zero")

    -- Enemy health
    self.max_health = 1000
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.disable_mercy = true

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        --"aiming",
        --"movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        --"..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {
    "AT ? DF ?\n* Deadly assassin known for quick kills.",
    "One mistake can spell your doom.",
    }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        ""
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* He's running out of time."

end

function Zero:onAct(battler, name)
    return super.onAct(self, battler, name)
end

return Zero