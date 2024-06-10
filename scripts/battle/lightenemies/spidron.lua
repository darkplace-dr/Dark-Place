local Spidron, super = Class(LightEnemyBattler)

function Spidron:init()
    super:init(self)

    self.name = "Spidron"
    self:setActor("rodenteerenemy")

    self.max_health = 50
    self.health = 50
    self.attack = 3
    self.defense = 0
    self.money = 2
    self.experience = 2
    
    self.dialogue_bubble = "ut_large"
    self.dialogue_offset = {0, 10}

    self.waves = {
        "deoxynn/mouse_home",
        "deoxynn/mouse_slash"
    }

    self.dialogue = {
        "Hissssss!"
    }

    self.check = "ATK 3 DEF 0\n* It's literally just a spider."

    self.text = {
        "* Spidron marches in place.",
    }

    self.low_health_text = {
        "* Spidron tries to make a web shield,[wait:5] but fails utterly."
    }

    self.low_health = false

    self:registerAct("Knit")
    self:registerAct("Crush")

    self.damage_offset = {0, 80}
	
	self.acts[3].color = {255, 0, 0}
end

function Spidron:onAct(battler, name)
    if name == "Knit" then
        self:addMercy(100)
        return {
            "* You knit a pair of socks from Spidron's webs.",
			"* If these weren't so sticky,[wait:5] they might be usable.",
			"* Spidron appreciates its web\nbeing useful!"
        }
    elseif name == "Crush" then
        self:hurt(99, battler)
		return {
			"* You crush Spidron beneath your\nfoot."
		}
    elseif name == "Standard" then
        return "* "
    end

    return super:onAct(self, battler, name)
end

function Spidron:getEncounterText()
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

function Spidron:getEnemyDialogue()
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

function Spidron:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
end

return Spidron