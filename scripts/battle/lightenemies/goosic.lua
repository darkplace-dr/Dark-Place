local Goosic, super = Class(LightEnemyBattler)

function Goosic:init()
    super:init(self)

    self.name = "Goosic"
    self:setActor("goosicenemy")

    self.max_health = 160
    self.health = 160
    self.attack = 12
    self.defense = 8
    self.money = 18
    self.experience = 0
    
    self.dialogue_bubble = "ut_wide"
    self.dialogue_offset = {-30, 10}

    self.waves = {
        "basic"
    }

    self.dialogue = {
        "bzt- YOU'RE\nLISTENING TO\nD-E-A-T-H\nRADIO-O-o !",
        "TH-TH-THIS ONE\nGOES OUT TO ALL\nTHE HUMANS\nOUT THERE !",
        "LOUDER !\nLOUDER !\nLOUDER !",
        "I'M G-GIVING AWAY\nONE FREE TICKET\nTO THE A-A-AFTERLIFE !",
        "bzt- AND NOW A WORD\nFROM OUR SPONSOR:\nBULLET-PATTERNS ! "
    }

    self.calm_dialogue = {
        "This is\nn-nice :)",
        "Mhm,\nyeah :)"
    }

    self.low_health_dialogue = {
        "D-DOn'T HATE\nON MY m/MusIC\nTASTES_",
        "BiT OF A\nH-H-HARSH nOISE\nCOMPLAINT/ /"
    }

    self.check = "ATK 12 DEF 8\n* Music drives the mood."

    self.text = {
        "* Goosic slowly scratches a\nrecord with its needle. The\nsound is unbearable.",
        "* Goosic begins spinning in\ncircles.",
        "* Goosic blasts battle music from\nits beak.",
        "* Your eardrums do not appreciate\nthe current situation.",
        "* Goosic does a little two-step\nlike it's nothing."
    }

    self.spareable_text = "* Goosic is lost in the music."
    self.low_health_text = {
        "* Goosic struggles to keep\ndancing.",
        "* Goosic's music bends in and out\nof tune."
    }

    self.low_health = false
    self.track_changed = false

    self:registerAct("Vibe")
    self:registerAct("Ignore")
    self:registerAct("Needle")

    --self.gauge_size = {250, 20}

    self.damage_offset = {0, 80}
end

function Goosic:getDamageVoice()
    return "hurt_robot"
end

function Goosic:onAct(battler, name)
    if name == "Vibe" then
        if self.low_health == true then
            return "* You calm yourself in the midst\nof the battle."
        else
            if self.track_changed == false then
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "KEEP UP !\nKEEP UP !"
                else
                    self.dialogue_override = "IF YOU CAN'T\nV-VIBE TO IT,\nGIVE IT U-U-UP !"
                end
                return "* You try to enjoy the music but\ncan't keep up."
            else
                self:addMercy(50)
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "Okay, yeah !\nI see you !"
                else
                    self.dialogue_override = "Oh, now THIS\nis groovy !"
                end
                return "* You close your eyes and tap\nyour foot to the music. Goosic\njoins you."
            end
        end
    elseif name == "Ignore" then
        if self.low_health == true then
            return "* You tune Goosic out."
        else
            if self.track_changed == false then
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "WHAT'S THAT ?\nMORE VOLUME ?"
                else
                    self.dialogue_override = "D-D-DISRESPECTFUL !"
                end
                return "* You plug your ears in hopes to\nblock the noise. Goosic just\nturns it up."
            else
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "Come o-on,\nrelax a\nl-l-little ."
                else
                    self.dialogue_override = "N-No need to\nbe bashful,\nbuddy ."
                end
                return "* You try not to get wrapped up\nin the music."
            end
        end
    elseif name == "Needle" then
        if self.low_health == true then
            return "* You try to move Goosic's needle\nbut it shocks you."
        else
            if self.track_changed == false then
                self.track_changed = true
                self:addMercy(50)
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "HEY W-W-what\nis... this ?"
                else
                    self.dialogue_override = "WAIT !\nI... Oh ?"
                end
                return "* You move Goosic's needle to a\nnew, calmer record."
            else
                local rnd = math.random(1, 3)
                if rnd == 1 then
                    self.dialogue_override = "Don't k-kill\nthe mood :)"
                else
                    self.dialogue_override = "I like\nth-this one :)"
                end
                return "* Goosic seems to be calming\ndown. Shouldn't change the song\nnow."
            end
        end
    elseif name == "Standard" then
        if battler.chara.id == "jamm" and Game:getFlag("dungeonkiller") then
            return "* Jamm refused to act."
        else
            if self.low_health == true then
                return "* "..battler.chara:getName().." calms themselves in the\nmidst of the battle."
            else
                if self.track_changed == false then
                    local rnd = math.random(1, 3)
                    if rnd == 1 then
                        self.dialogue_override = "KEEP UP !\nKEEP UP !"
                    else
                        self.dialogue_override = "IF YOU CAN'T\nV-VIBE TO IT,\nGIVE IT U-U-UP !"
                    end
                    return "* "..battler.chara:getName().." tries to enjoy the music\nbut can't keep up."
                else
                    self:addMercy(50)
                    local rnd = math.random(1, 3)
                    if rnd == 1 then
                        self.dialogue_override = "Okay, yeah !\nI see you !"
                    else
                        self.dialogue_override = "Oh, now THIS\nis groovy !"
                    end
                    return "* "..battler.chara:getName().." closes their eyes and taps\ntheir foot to the music. Goosic\njoins them."
                end
            end
        end
    end

    return super:onAct(self, battler, name)
end

function Goosic:onDefeat(damage, battler)
    self.hurt_timer = -1
    local sprite = self:getActiveSprite()
    sprite:stopShake()
    self:defeat("KILLED", true)

    if Game:getFlag("steamworks_kills") == nil then
        Game:setFlag("steamworks_kills", 1)
    else
        Game:setFlag("steamworks_kills", Game:getFlag("steamworks_kills") + 1)
    end

    Game.battle.timer:after(1/2, function()
        Assets.playSound("ut_explosion")
        self:remove()
    end)
end

function Goosic:getEncounterText()
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

function Goosic:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end
    if self.low_health_dialogue and self.health <= (self.max_health * self.low_health_percentage) then
        return Utils.pick(self.low_health_dialogue)
    end
    if self.track_changed == true then
        return Utils.pick(self.calm_dialogue)
    end
    return Utils.pick(self.dialogue)
end

function Goosic:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
    if self.low_health == false and self.health <= (self.max_health * self.low_health_percentage) then
        self.low_health = true
        self:setActor("goosicenemy_hurt")
    end
end

return Goosic