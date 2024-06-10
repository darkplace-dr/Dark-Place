local Waspon, super = Class(LightEnemyBattler)

function Waspon:init()
    super:init(self)

    self.name = "Waspon"
    self:setActor("rodenteerenemy")

    self.max_health = 160
    self.health = 160
    self.attack = 8
    self.defense = 0
    self.money = 25
    self.experience = 18
    
    self.dialogue_bubble = "ut_large"
    self.dialogue_offset = {0, 10}

    self.waves = {
        "deoxynn/mouse_home",
        "deoxynn/mouse_slash"
    }

    self.dialogue = {
        "Defeat the intruders!",
        "Buzz,[wait:5] buzz!",
    }

    self.check = "ATK " .. self.attack .. " DEF 0\n* You can hear this thing from more than a mile away!"

     self.text = {
        "* That buzzing is starting to annoy you.",
        "* Waspon's wings flap really fast.",
    }

    self.low_health_text = {
        "* Waspon struggles to keep off the ground."
    }

    self.low_health = false

    self:registerAct("Shoo")
    self:registerAct("Smack")
    self:registerAct("Buzz")

    self.damage_offset = {0, 80}
end

function Waspon:onAct(battler, name)
    if name == "Smack" then
        self:addMercy(100)
		Assets.playSound("damage")
		self:hurt(1, battler)
        return {
            "* You smack Waspon lightly.",
			"* Smacking it makes it want to run away!"
        }
	elseif name == "Shoo" then
		self.attack = self.attack + 1
		return {
            "* You wave my arms in an attempt to get Waspon\nto fly away.",
			"* This just makes it more upset![wait:5]\n* Waspon's attack increases!"
        }
	elseif name == "Buzz" then
		self.attack = self.attack + 1
        self.dialogue_override = "Hey![wait:5] That's MY thing!"
		return {
            "* You buzz at the Waspon.",
			"* This just makes it more upset![wait:5]\n* Waspon's attack increases!"
        }
    elseif name == "Standard" then
        return "* "
    end

    return super:onAct(self, battler, name)
end

function Waspon:getEncounterText()
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

function Waspon:getEnemyDialogue()
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

function Waspon:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
end

return Waspon