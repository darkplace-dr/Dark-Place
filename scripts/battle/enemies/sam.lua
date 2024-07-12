local Sam, super = Class(EnemyBattler)

function Sam:init()
    super.init(self)

    self.name = "Sam"
    self:setActor("sam")

    self.max_health = 6000
    self.health = 6000
    self.attack = 1
    self.defense = 0
    self.money = 0
    self.experience = Mod:isInRematchMode() and 0 or 420
	self.service_mercy = 100
	
	self.boss = true

    self.spare_points = 0
    self.tired_percentage = 0

    self.waves = {
        "empty"
    }

    self.dialogue = {
        "[font:sans][voice:sans]hehehehe",
        "[font:sans][voice:sans]the name's sam",
        "[font:sans][voice:sans]hi",
        "[font:sans][voice:sans]miss thoodleoo,[wait:5]\nmay i go to\nthe restroom?"
    }

    self.check = "AT 1 DF 0\n* His name's Sam.[wait:5]\n* Apparently."

    self.text = {
        "* Sam just sits there."
    }
    self.low_health_text = "* Smells like fluff."

    self:registerAct("Talk", "")
    self:registerAct("Red Buster", "Red\nDamage", "susie", 60)
    self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)

    self.killable = true
end

function Sam:onSpared()
    super.onSpared(self)

    self.sprite:resetSprite()
    Game.battle.music:stop()
end

function Sam:isXActionShort(battler)
    return false
end

function Sam:onActStart(battler, name)
    super.onActStart(self, battler, name)
end

function Sam:onAct(battler, name)
    if name == "DualHeal" then
        Game.battle:powerAct("dual_heal", battler, "ralsei")
    elseif name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
    elseif name == "Talk" then
        self:addMercy(7)
        self.dialogue_override = "[font:sans][voice:sans]heya"
        return "* You talk to Sam."
    elseif name == "Standard" then
		self:addMercy(3)
        return {
            "* "..battler.chara:getName().." talks to Sam."
        }
    end

    return super.onAct(self, battler, name)
end

function Sam:onDefeat(damage, battler)
    self.exit_on_defeat = true
    super.onDefeat(self, damage, battler)
end

return Sam
