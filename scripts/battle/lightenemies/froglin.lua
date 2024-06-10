local Froglin, super = Class(LightEnemyBattler)

function Froglin:init()
    super:init(self)

    self.name = "Froglin"
    self:setActor("rodenteerenemy")

    self.max_health = 110
    self.health = 110
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
        "You're gonna croak!",
		"Hoppity hop,[wait:5] little kids!",
    }

    self.check = "ATK 6 DEF 0\n* An overexcited frog with a passion for jumping."

    self.text = {
        "* Froglin hops around,[wait:5] impatiently waiting for its turn.",
		"* You are impressed by the high hops.",
    }

    self.low_health_text = {
        "* Froglin's jumps are faster out of desperation."
    }

    self.low_health = false

    self:registerAct("Lick")
    self:registerAct("Hop")

    self.damage_offset = {0, 80}
end

function Froglin:onAct(battler, name)
    if name == "Hop" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "You're really speaking to me!"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You hop with Froglin.[wait:5]\n* It seems to relate!"
        }
    elseif name == "Lick" then
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "Gross."
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You lick the back of Froglin.[wait:5]\n* Gross!",
            "* You thought this was supposed to give you the \"experience of a lifetime\"?",
        }
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