local Spamgolor, super = Class(EnemyBattler)

function Spamgolor:init()
    super.init(self)

    self.name = "Spamgolor"
    self:setActor("spamgolor")

    self.max_health = 1200
    self.health = 1200
    self.attack = 8
    self.defense = 0
    self.money = 97

    self.spare_points = 0
    self.tired_percentage = 0

    self.waves = {
        "gemapple",
        "deadlyneedle",
        "blackhole"
    }

    self.dialogue = {
        "I WILL SHOW YOU\nTHE POWER OF\n[[404 Friends not found]] !!",
        "[[Top rated]] ATTACKS\nFOR [[The low-low price of]] !!",
        "TIME TO MAKE\nMY [[Triumphant Return]] !!"
    }

    self.check = "AT 8 DF 0\n* A forgotten salesman looking to make his triumphant return."

    self.text = {
        "* Spamgolor slicks back his hair.",
        "* Spamgolor flashes an award-losing smile.",
        "* GREAT ENEMY, SUBSCRIBE NOW!!",
        "* Smells like cats.",
    }
    self.low_health_text = "* Smells like cracked eggs."

    self:registerAct("Deal")
    self:registerAct("X-Deal", "", {"susie"})
    self:registerAct("Heal Deal", "Requires\nMoney", nil, 25)

    self.killable = false
end

function Spamgolor:onAct(battler, name)
    if name == "Deal" then
        self:addMercy(10)
        self.dialogue_override = "PLEASURE DOING\n[[Shady Business]]\nWITH YOU, KID!"
        Game.battle:startActCutscene("spamgolor", "deal")
        return
    elseif name == "X-Deal" then
        self:addMercy(25)
        self.dialogue_override = "PLEASURE DOING\n[[Shady Business]]\nWITH YOU TWO!"
        Game.battle:startActCutscene("spamgolor", "x_deal")
        return
    elseif name == "Heal Deal" then
        self.dialogue_override = "ENJOY YOUR\n[Healing Item]!"
        Game.battle:startActCutscene("spamgolor", "heal_deal")
        return
    elseif name == "Standard" then
        if battler.chara.id == "susie" then
            Game.battle:startActCutscene("spamgolor", "susie_talk")
            return
        end
        return {
            "* "..battler.chara:getName().." tried to make a deal...",
            "* ... but they didn't know how to."
        }
    end

    return super.onAct(self, battler, name)
end

function Spamgolor:update()
    super.update(self)
    if self.health <= 300 or self.mercy >= 75 then
        self.waves = {
            "spamgolor_everything"
        }
    elseif self.health <= 600 or self.mercy >= 50 then
        self.waves = {
            "gemapple_deadlyneedle",
            "gemapple_blackhole",
            "deadlyneedle_blackhole"
        }
    end
end

return Spamgolor