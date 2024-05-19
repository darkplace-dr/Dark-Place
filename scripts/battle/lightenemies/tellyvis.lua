local TellyVis, super = Class(LightEnemyBattler)

function TellyVis:init()
    super:init(self)

    self.name = "Telly-Vis"
    self:setActor("tellyvisenemy")

    self.max_health = 160
    self.health = 160
    self.attack = 12
    self.defense = 12
    self.money = 25
    self.experience = 0
    
    self.dialogue_bubble = "ut_wide"
    self.dialogue_offset = {-30, 10}

    self.waves = {
        "basic"
    }

    self.dialogue = {
        "Don't touch that\ndial! Seriously,\nI'll hurt you.",
        "I live life in\nglorious standard\ndefinition!\nNothing better!",
        "Never take\nadvice from\nVis. He's\na mouthful!",
        "Network TV? Yeah,\nI do the work,\nand they net\nthe profits!"
    }

    self.low_health_dialogue = {
        "T/Time to;?\nGo on coMmercial\nbreak. ... ."
    }

    self.check = "ATK 12 DEF 12\n* Can't live with or without\none another."

    self.text = {
        "* Telly-Vis are debating which\nseason of the news is superior.",
        "* Telly pushes Vis' mouth-flap\nback and forth for amusement.\nVis isn't having it.",
        "* Vis reminds Telly what time his\nfavorite show airs but she only\nmakes fun of him.",
        "* The sound of TV static fills\nyour head.",
        "* Telly starts to sing an anime\nopening. Vis begs her to stop.",
        "* You wonder where the mute\nbutton is."
    }

    self.spareable_text = "* Telly-Vis hope you enjoyed the\nprogram."
    self.low_health_text = {
        "* Telly is frantically flipping\nchannels.",
        "* Vis spits out a broken video\ncassette."
    }

    self.low_health = false
    self.switched_channel = false

    self:registerAct("Watch")
    self:registerAct("Nap")
    self:registerAct("Signal")

    --self.gauge_size = {250, 20}

    self.damage_offset = {0, 80}
end

function TellyVis:onAct(battler, name)
    if name == "Watch" then
        if self.low_health == true then
            self.dialogue_override = "Th.i>s is- my\nf-f-favorite shoOw/"
            return "* Nothing on."
        else
            if self.switched_channel == false then
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "What are you\nstaring at?"
                else
                    self.dialogue_override = "There's nothing\non yet!"
                end
                return "* While this IS your favorite\nchannel, Telly-Vis don't look\namused."
            else
                self:addMercy(50)
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "Oh! Check\nthis out!"
                else
                    self.dialogue_override = "Here comes the\nbest part!"
                end
                return "* Telly finds a show she thinks\nyou'll love."
            end
        end
    elseif name == "Nap" then
        if self.low_health == true then
            return "* You couldn't sleep if you\nwanted to."
        else
            local rnd = math.random(1, 3)
            if rnd == 1 then
                self.dialogue_override = "Am... Am I\nboring you?"
            else
                self.dialogue_override = "Hey, buddy!\nI'm still here!"
            end
            return "* You begin to drift off to the\ndismay of Telly.. "
        end
    elseif name == "Signal" then
        if self.low_health == true then
            self.dialogue_override = "/NeEd s[ome\nMaint/enan-ce . ,,"
            return "* You see if Telly's antennas\nstill function. They do not."
        else
            if self.switched_channel == false then
                self:addMercy(50)
                self.switched_channel = true
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "Just what\nI needed!"
                else
                    self.dialogue_override = "Whoa, hey!\nI'm picking\nsomething up!"
                end
                return "* You help Telly finagle her\nantennas to find some\nprogramming."
            else
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "They're good\nwhere they are!"
                else
                    self.dialogue_override = "Hey, don't ruin\nmy electrical\nflow!"
                end
                return "* You attempt to touch Telly's\nantennas again but she motions\nyou away."
            end
        end
    elseif name == "Standard" then
        if self.low_health == true then
            self.dialogue_override = "Th.i>s is- my\nf-f-favorite shoOw/"
            return "* Nothing on."
        else
            if self.switched_channel == false then
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "What are you\nstaring at?"
                else
                    self.dialogue_override = "There's nothing\non yet!"
                end
                return "* While this IS your favorite\nchannel, Telly-Vis don't look\namused."
            else
                self:addMercy(50)
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "Oh! Check\nthis out!"
                else
                    self.dialogue_override = "Here comes the\nbest part!"
                end
                return "* Telly finds a show she thinks\nyou'll love."
            end
        end
    end

    return super:onAct(self, battler, name)
end

function TellyVis:onDefeat(damage, battler)
    self.hurt_timer = -1
    local sprite = self:getActiveSprite()
    sprite:stopShake()
    self:defeat("KILLED", true)

    if Game:getFlag("steamworks_kills") == nil then
        Game:setFlag("steamworks_kills", 1)
    else
        Game:setFlag("steamworks_kills", Game:getFlag("steamworks_kills") + 1)
    end

    Game.battle.timer:after(0.8, function()
        Assets.playSound("ut_explosion")
        self:remove()
    end)
end

function TellyVis:getEncounterText()
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

function TellyVis:getEnemyDialogue()
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

function TellyVis:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
    if self.low_health == false and self.health <= (self.max_health * self.low_health_percentage) then
        self.low_health = true
        self:setActor("tellyvisenemy_hurt")
    end
end

return TellyVis