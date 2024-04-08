local Froggit, super = Class(LightEnemyBattler)

function Froggit:init()
    super.init(self)

    -- Enemy name
    self.name = "Final Froggit"
    -- Sets the actor, which handles the enemy's sprites
    self:setActor("finalfroggit")

    -- Enemy health
    self.max_health = 32
    self.health = 32
    -- Enemy attack (determines bullet damage)
    self.attack = 7
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = 2
    self.experience = 4

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
        "[wave:2]Robbit,\nrobbit.",
        "[wave:2]Croak,\ncroak.",
        "[wave:2]Hop,\nhop.",
        "[wave:2]Woof."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "ATK 30 DEF 24\n* Its future looks brighter\nand brighter."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Final Froggit knows exactly\nwhy it's here.",
        "* Final Froggit jumps ominously\nup and down.",
        "* The battlefield is filled\nwith the smell of mustard\nseed.",
        "* You are intimidated by\nFinal Froggit's strength.[wait:40]\n* Truly."
    }
    
    self.low_health_text = "* Final Froggit stands its ground."
    self.spareable_text = "* Final Froggit seems reluctant\nto fight you."

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
    return super.onAct(self, battler, name)
end

function Froggit:onDefeat(damage, battler)
    Game:setFlag("##test_kills", Game:getFlag("##test_kills", 0) + 1)
    super.onDefeat(self, damage, battler)
end

function Froggit:getDamageVoice()
    return "ehurt1"
end

return Froggit