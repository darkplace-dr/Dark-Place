local Python, super = Class(LightEnemyBattler)

function Python:init()
    super:init(self)

    self.name = "Python"
    self:setActor("rodenteerenemy")

    self.max_health = 220
    self.health = 220
    self.attack = 7
    self.defense = -1
    self.money = 20
    self.experience = 12
    
    self.dialogue_bubble = "ut_large"
    self.dialogue_offset = {0, 10}

    self.waves = {
        "deoxynn/mouse_home",
        "deoxynn/mouse_slash"
    }

    self.dialogue = {
        "Hissssss!",
		"Your mother is a hamssster.",
		"This parrot is no more!"
    }

    self.check = "ATK 7 DEF -1\n* There are some who call it... Tim."

    self.text = {
        "* So many functions and variables...",
		"* Smells like a flesh wound.",
		"2a 20 53 6d 65 6c 6c 73 20 6c 69 6b 65 20 68 65 78 61 64 65 63 69 6d 61 6c 2e" -- So you can't type this whole thing out?
    }

    self.low_health_text = {
        "* We probably shouldn't bicker and argue over who almost killed who."
    }

    self.low_health = false

    self:registerAct("Quiz")
    self:registerAct("Learn")
    self:registerAct("Advice")

    self.damage_offset = {0, 80}
end

function Python:onAct(battler, name)
    if name == "Advice" then
        self:addMercy(100)
        self.dialogue_override = "It'sss called Pygame..."
        return {
            "* You ask for any advice on making\na project."
        }
    elseif name == "Quiz" then
        return {
            "* You ask Python to let you prove\nyour Python skill.",
			"* However,[wait:5] it only seems\ninterested in teaching!"
        }
    elseif name == "Learn" then
        return {
            "* You try to learn from Python...",
			"* Python's lessons are almost\ncomplete gibberish!"
        }
    elseif name == "Standard" then
        return "* "
    end

    return super:onAct(self, battler, name)
end

function Python:getEncounterText()
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

function Python:getEnemyDialogue()
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

function Python:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
end

return Python