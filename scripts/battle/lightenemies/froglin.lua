local Froglin, super = Class(LightEnemyBattler)

function Froglin:init()
    super:init(self)

    self.name = "Froglin"
    self:setActor("rodenteerenemy")

    self.max_health = 80
    self.health = 80
    self.attack = 6
    self.defense = 0
    self.money = 15
    self.experience = 7
    
    self.dialogue_bubble = "ut_large"
    self.dialogue_offset = {0, 10}

    self.waves = {
        "deoxynn/mouse_home",
        "deoxynn/mouse_slash"
    }

    self.dialogue = {
        "*squeak*",
		"*squeak*[wait:5]\n*squeak*",
		"*high-\npitched\nsqueak*"
    }

    self.check = "ATK 6 DEF 0\n* "

    self.text = {
        "* Rodenteer hits the ground with\nits sword tail.",
        "* Smells like cheese.",
    }

    self.low_health_text = {
        "* Rodenteer lowers its blade to the ground."
    }

    self.low_health = false

    self:registerAct("Squeak")

    self.damage_offset = {0, 80}
end

function Froglin:getDamageVoice()
    return "squeak"
end

function Froglin:onAct(battler, name)
    if name == "Squeak" then
        self:addMercy(100)
        self.dialogue_override = "*squeak* ^^"
        return "* You squeak at Rodenteer.[wait:10]\n* Whatever you said made it not\nwant to fight!"
    elseif name == "Standard" then
        return "* "
    end

    return super:onAct(self, battler, name)
end

function Froglin:getEncounterText()
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

function Froglin:getEnemyDialogue()
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

function Froglin:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
end

return Froglin