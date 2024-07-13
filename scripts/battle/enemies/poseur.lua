local Poseur, super = Class(EnemyBattler)

function Poseur:init()
    super.init(self)

    self.name = "Poseur"
    self:setActor("poseur")

    self.max_health = 450
    self.health = 450
    self.attack = 4
    self.defense = 1
    self.money = 20
    self.experience = 10
	self.service_mercy = 50

    self.spare_points = 20

    self.waves = {
        "poseur/bouncy",
        "poseur/chaserorb",
        "poseur/touhou"
    }

    self.dialogue = {
        "Random\nDialogue\n1.",
        "Random\nDialogue\n2.",
        "Random\nDialogue\n3."
    }

    self.check = "AT 4 DF 1\n* Check message goes here."

    self.text = {
        "* Smells like the work\nof an enemy stand.",
        "* Poseur is posing like his\nlife depends on it.",
        "* Poseur's limbs shouldn't be\nmoving in this way.",
    }
    self.low_health_text = "* Poseur looks like it's\nabout to fall over."

    self:registerAct("Act 1")
    self:registerAct("Act 2", nil, "susie")
    self:registerAct("Act 3")
end

function Poseur:onAct(battler, name)
    if name == "Act 1" then
        self:addMercy(25)
        self.dialogue_override = "Selected\nAct 1."
        return "* You selected\nACT 1."

    elseif name == "Act 2" then
        self:addMercy(50)
        self.dialogue_override = "Selected\nAct 2."
        return "* You and Susie selected\nACT 2."

    elseif name == "Act 3" then
        self:setTired(true)
        self.dialogue_override = "Selected\nAct 3."
        return {
            "* You selected\nACT 3.",
            "* Poseur became [color:blue]TIRED[color:reset]."
        }

    elseif name == "Standard" then
        self:addMercy(25)
		if battler.chara.id == "dess" then
            -- D-Action lmao
            return "* "..battler.chara:getName().." used their X-Action but like wrong somehow."
        end
		if battler.chara.id == "jamm" then
            -- J-Action
			self:addMercy(10)
            return "* Jamm used his X-Action expertly."
        end
		return "* "..battler.chara:getName().." used their X-Action."
    end

    return super.onAct(self, battler, name)
end

return Poseur