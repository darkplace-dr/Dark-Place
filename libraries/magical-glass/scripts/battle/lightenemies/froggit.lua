local Froggit, super = Class(LightEnemyBattler)

function Froggit:init()
    super:init(self)

    -- Enemy name
    self.name = "Froggit"
    -- Sets the actor, which handles the enemy's sprites
    self:setActor("froggit")

    -- Enemy health
    self.max_health = 30
    self.health = 30
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 5
    -- Enemy reward
    self.money = 2
    self.experience = 3

    -- The Speech bubble offset
    self.dialogue_offset = {20, 0}
    self.dialogue_bubble = "ut_large"

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "froggit/leapfrog",
        "froggit/flies"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "[wave:2]Ribbit,\nribbit.",
        "[wave:2]Croak,\ncroak.",
        "[wave:2]Hop,\nhop.",
        "[wave:2]Meow."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "ATK 4 DEF 5\n* Life is difficult for\nthis enemy."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Froggit doesn't seem to\nknow why it's here.",
        "* Froggit hops to and fro.",
        "* The battlefield is filled\nwith the smell of mustard\nseed.",
        "* You are intimidated by\nFroggit's raw strength.[wait:40]\n* Only kidding."
    }
    
    self.low_health_text = "* Froggit is trying to\nrun away."
    self.spareable_text = "* Froggit seems reluctant\nto fight you."

    self:registerAct("Compliment")
    self:registerAct("Threaten")

    self.damage_offset = {0, -65}
end

function Froggit:getMoney()
    if self.health >= self.max_health and self.mercy >= 100 then
        return self.money + 2
    else
        return self.money
    end
end

function Froggit:selectWave()
    local waves = self:getNextWaves()

    if waves and #waves > 0 then
        local wave = Utils.pick(waves)
        if #Game.battle.enemies > 1 and wave == "froggit/leapfrog" then
            wave = "froggit/flies"
        end

        if #Game.battle.enemies > 1 and wave == "froggit/flies" then
            local picker = Utils.random(0, 1, 1)
            if picker == 1 then
                wave = "froggit/splinter"
            end
        end
        self.selected_wave = wave
        return wave
    end
end

function Froggit:onAct(battler, name)
    if name == "Compliment" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "[wave:2](Blushes\ndeeply.)\nRibbit.."

        return "* Froggit didn't understand\nwhat you said,[wait:5] but was\nflattered anyway."

    elseif name == "Threaten" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "[wave:2]Shiver,\nshiver."

        return "* Froggit didn't understand\nwhat you said,[wait:5] but was\nscared anyway."
    elseif name == "Standard" then
        self:addMercy(100)
        self.dialogue_override = "[wave:2](Blushes\ndeeply.)\nRibbit.."
        return "* Froggit didn't understand\nwhat "..battler.chara:getName().." did,[wait:5] but was\nsated anyway."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super:onAct(self, battler, name)
end

function Froggit:onDefeat(damage, battler)
    Game:setFlag("##test_kills", Game:getFlag("##test_kills", 0) + 1)
    super.onDefeat(self, damage, battler)
end

function Froggit:getDamageVoice()
    return "ehurt1"
end

return Froggit