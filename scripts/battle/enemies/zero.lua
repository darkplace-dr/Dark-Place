local Zero, super = Class(EnemyBattler)

function Zero:init()
    super.init(self)

    -- Enemy name
    self.name = "Zero"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("zero")

    -- Enemy health
    self.max_health = 3500
    self.health = 3500
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 5
    -- Enemy reward
    self.money = 100
    -- Disables running away
    self.boss = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.disable_mercy = true

    self.difficulty = 0

    -- List of possible wave ids, randomly picked each turn
    if Game:getFlag("fun") == 12 then
        self.waves = {
            "zero/Ascend"
        }
    else
        self.waves = {
            --"zero/ColorSlash",
            "zero/Aiming",
        }
    end

    -- Dialogue randomly displayed in the enemy's speech bubble
    if Game:getFlag("fun") == 12 then
        self.dialogue = {
            "I must go.[wait:5] My people need me."
        }
    else
        self.dialogue = {}
    end

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {
    "AT ? DF ?\n* Deadly assassin known for quick kills.",
    "One mistake can spell your doom.",
    }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Enemy flavor text."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* He's running out of time."

    self:registerAct("Red Buster", "Red\nDamage", {"susie"}, 60)
    --self:registerAct("Red Buster", "Red\nDamage", {"robo_susie"}, 60)

end

function Zero:onAct(battler, name)
    if name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
        -- Fun fact! this function crashes if you return a string!
        return
    elseif name == "Standard" then --X-Action
        if battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("zero", "susie_action")
            return
        elseif battler.chara.id == "robo_susie" then
            -- Robo-S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("zero", "robo_susie_action")
            return
        end
    else
        return super.onAct(self, battler, name)
    end
end

return Zero