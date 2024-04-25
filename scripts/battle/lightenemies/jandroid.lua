local Jandroid, super = Class(LightEnemyBattler)

function Jandroid:init()
    super:init(self)

    self.name = "Jandroid"
    self:setActor("jandroidenemy")

    self.max_health = 150
    self.health = 150
    self.attack = 11
    self.defense = 7
    self.money = 18
    self.experience = 0
    
    self.dialogue_bubble = "ut_wide"
    self.dialogue_offset = {-30, 10}

    self.waves = {
        "basic"
    }

    self.dialogue = {
        "Gee, you're too\nClean! Let's\nstaIN thaT VEsT!!",
        "Nothin' like the\nsmell of RuSted\nmeTal in the\nMorning!!",
        "I will NeVER take\nout the TrASH!\nYOU CAN'T MAKE\nME!!!",
        "Scrub-a-dub-dub!\nSewage in the\ntub!!!",
        "Want a sip of\nmy Mop Water?\nIt's FReshly MaDe!!"
    }

    self.low_health_dialogue = {
        "//Cleaaaaan - _",
        "LLLet's\n;-:_\nWassh up"
    }

    self.check = "ATK 11 DEF 7\n* \"Hygiene\" is not in their\nvocabulary."

    self.text = {
        "* Jandroid wrings out their\nmop... over their head.",
        "* Jandroid tries to whistle to\nthe music.",
        "* Smells like poor choices.",
        "* Jandroid tosses garbage this\nway and that."
    }

    self.spareable_text = "* Jandroid finds you too\nhygienic."
    self.low_health_text = {
        "* Jandroid doesn't seem to know\nwhat they're doing anymore.",
        "* You hear metallic and\nelectrical noises as Jandroid\ntwitches."
    }

    self.low_health = false

    self:registerAct("Question")
    self:registerAct("Clean")
    self:registerAct("Analyze")

    --self.gauge_size = {250, 20}

    self.damage_offset = {0, 80}
end

function Jandroid:getDamageVoice()
    return "hurt_robot"
end

function Jandroid:onAct(battler, name)
    if name == "Question" then
        if self.low_health == true then
            self.dialogue_override = "W//what\nwas_That? /("
            return "* You ask Jandroid how they're\nstill functioning."
        else
            local rnd = math.random(1, 3)
            if rnd == 1 then
                self.dialogue_override = "To rid the\nUnderground of\nSOAP!!!"
            else
                self.dialogue_override = "To cle//a--I\nmean help all\nGerms conquer\nthe land!!"
            end
            return "* You ask Jandroid what their\nprimary directive is."
        end
    elseif name == "Clean" then
        if self.low_health == true then
            self.dialogue_override = "St_amwrrks\nNeed_/ scruBbed\n0"
            return "* Cleaning Jandroid wouldn't\ndo any good at this point."
        else
            local rnd = math.random(1, 3)
            if rnd == 1 then
                self.dialogue_override = "NO YOU!!"
            else
                self.dialogue_override = "You are RUDE!\nTake THIS!!"
            end
            return "* You offer to give Jandroid\na scrub. They seem offended."
        end
    elseif name == "Analyze" then
        if self.low_health == true then
            self.dialogue_override = "AaAAaoo/aa/.\nBzzt.\"<<<"
            return "* You look Jandroid over and\nnotice many missing screws."
        else
            local rnd = math.random(1, 3)
            if rnd == 1 then
                self.dialogue_override = "I can't beLIEVE\nyou Would propose\nsuch a Thing!"
            else
                self.dialogue_override = "Don't comE\nANY cLosER!!"
            end
            return "* You look Jandroid over and\ntell them they need a shower."
        end
    elseif name == "Standard" then
        local rnd = math.random(1, 3)
        if rnd == 1 then
            self.dialogue_override = "NO YOU!!"
        else
            self.dialogue_override = "You are RUDE!\nTake THIS!!"
        end
        return "* You offer to give Jandroid\na scrub. They seem offended."
    end

    return super:onAct(self, battler, name)
end

function Jandroid:onDefeat(damage, battler)
    self.hurt_timer = -1
    local sprite = self:getActiveSprite()
    sprite:stopShake()
    self:defeat("KILLED", true)
    Game.battle.timer:after(15/30, function()
        Assets.playSound("ut_explosion")
        self:remove()
    end)
end

function Jandroid:getEncounterText()
    local has_spareable_text = self.spareable_text and self:canSpare()

    local priority_spareable_text = Game:getConfig("prioritySpareableText")
    if priority_spareable_text and has_spareable_text then
        return self.spareable_text
    end

    if self.low_health_text and self.health <= (self.max_health * self.low_health_percentage) then
        return Utils.pick(self.low_health_text)

    elseif self.tired_text and self.tired then
        return self.tired_text

    elseif has_spareable_text then
        return self.spareable_text
    end

    return Utils.pick(self.text)
end

function Jandroid:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end
    if self.low_health_dialogue and self.health <= (self.max_health * self.low_health_percentage) then
        return Utils.pick(self.low_health_dialogue)
    end
    return Utils.pick(self.dialogue)
end

function Jandroid:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
    if self.low_health == false and self.health <= (self.max_health * self.low_health_percentage) then
        self.low_health = true
        self:setActor("jandroidenemy_hurt")
    end
end

return Jandroid