local Grounder, super = Class(EnemyBattler)

function Grounder:init()
    super.init(self)

    self.name = "Grounder"
    self:setActor("grounder")

    self.path = "enemies/grounder"
    self.default = "idle"

    self.max_health = 120
    self.health = 120
    self.attack = 6
    self.defense = 0
    self.gold = 30

    self.spare_points = 20

    self.waves = {
        "grounder/diamonds_up",
        "grounder/diamonds_aim"
    }

    self.check = "AT 6 DEF 0\nThis ambivalent diamond isn't\nany girl's best friend."

    self.text = {
        "* Grounder is glimmering plainly.",
        "* Grounder has no strong opinions\none way or the other.",
        "* Grounder thinks about smashing\nSonic.",
        "* Grounder dislikes its boss,\nbut doesn't care enough to quit.",
	    "* Smells like oil."
    }

    self.low_health_text = "* Grounders's luster begins to fade."

    self:registerAct("Dupe")
    self:registerAct("Lecture")

    self.text_override = nil
end

function Grounder:isXActionShort(battler)
    return true
end

function Grounder:onShortAct(battler, name)
    if name == "Lecture" then
		self:setAnimation("tired")
		self:setTired(true)
        if battler.chara.id == "kris" then
            return "* You lectured the enemies on eating healthy."
        else
            return "* " .. battler.chara.name .. " lectured the enemies on eating healthy."
        end
    elseif name == "Standard" then
        self:addMercy(100)
        if battler.chara.id == "noelle" then
            return "* Noelle encouraged the enemies!"
        elseif battler.chara.id == "susie" then
            return "* Susie motivated the enemies!"
        elseif battler.chara.id == "ralsei" then
            return "* Ralsei reasoned with the enemies!"
        end
    end
    return nil
end


function Grounder:onAct(battler, name)
    if name == "Dupe" then
        self:addMercy(100)
        return "* You fooled Grounder with cartoon hijinks.\n* He was utterly duped."
    elseif name == "Lecture" then
		self:setAnimation("tired")
        self:setTired(true)
        self.text_override = "(Burp)...\nWhat? OK.."
        return "* You lectured Grounder on eating healthy.\nGrounder became [color:blue]FED[color:reset]..."

        --local heck = DamageNumber("damage", love.math.random(600), 200, 200, battler.actor.dmg_color)
        --self.parent:addChild(heck)
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "noelle" then
			self.text_override = "Oh!\nIt is??"
			Game.battle:startActCutscene(function(cutscene)
				cutscene:text("* Noelle tried to give encouragement!")
				cutscene:text("* That necklace is, um...\nit's really shiny!", "smile_closed", "noelle")
			end)
        elseif battler.chara.id == "susie" then
            self.text_override = "Alright,\nalready..."
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Susie tried to give encouragement!")
                cutscene:text("* You! Get off your ass,\nor else!!", "teeth", "susie")
            end)
            return
        elseif battler.chara.id == "ralsei" then
			self.text_override = "Oh! I'll\ntake a\nbreak\nright now!"
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Ralsei tried to give encouragement!")
                cutscene:text("* Don't feel bad about taking\nbreaks every so often...\nit's perfectly normal!", "smile", "ralsei")
            end)
            return
        end
    end
    return super.onAct(self, battler, name)
end

function Grounder:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "Sure, I\ncan give\nyou my\nwallet.",
            "Alright,\nyou convinced\nme!!"
        }
    else
        dialogue = {
            "I don't\nhave a\nmovie!",
            "Long live\nthe guy\nwho pays us!",
            "Lock up\nthe\nthrottle!",
            "I'm just a\n normal person."
        }
    end
    return dialogue[math.random(#dialogue)]
end

return Grounder