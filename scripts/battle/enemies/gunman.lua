local Gunman, super = Class(EnemyBattler)

function Gunman:init()
    super.init(self)
    self.name = "gunman"
    self:setActor("gunman")
    self.max_health = 2000
    self.health = 2000
    self.attack = 9999
    self.defense = 3
    if Game:getFlag("rightsign_read") then
        self.money = 1500
    else
        self.money = 60
    end
    self.spare_points = 100
    self.waves = {
        "gun"
    }
    self.dialogue = {
        "die lol"
    }
    self.check = "AT 9999 DF 3"
    self.text = {
        "* the power of almost dying shines within you i think",
        "* bepis",
    }
    self.low_health_text = "* oh god hes is gonna die"
    self:registerAct("Stare")
end

function Gunman:onAct(battler, name)
    if name == "Stare" then
        self:addMercy(-20)
        self.dialogue_override = ".. Alright"
        return {
            "* You stare at whoevger this guy is.[wait:5]\n* Hes confused.",
            "* It, uh.. did nothing."
        }

    elseif name == "Standard" then
        if battler.chara.id == "YOU" then
			 Game.battle:startActCutscene("gunman", "you_Heal")
            return
        elseif battler.chara.id == "susie" then
			self:addMercy(25)
            return "* Susie gave the gun man a thumbs up."
        else
			self:addMercy(0)
            return "* "..battler.chara:getName().." didnt even bother to do anything."
        end
    end
    return super.onAct(self, battler, name)
end

return Gunman