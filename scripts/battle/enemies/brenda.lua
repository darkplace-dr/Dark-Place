local Brenda, super = Class(EnemyBattler)

function Brenda:init()
    super.init(self)

    self.name = "Brenda"
    self:setActor("brenda_dreamscape")

    self.path = "battle/enemies/b_dreamscape/battle"
    self.default = "idle"
    self:setAnimation("idle")

    self.max_health = 10000
    self.health = 10000
    self.attack = 15
    self.defense = 3
    self.money = 0
    self.experience = 0

    self.boss = true
    self.spare_points = 0
    self.service_mercy = 0

    self.comfort = 0
    self.hits = 0
    self.hurt_progress = 0

    self.waves = {
        "basic"
    }

    self.dialogue = {
        "..."
    }

    self.check = "AT 15 DF 3\n* ."

    self.text = {
        "* ",
    }
    self.low_health_text = "* "

    self:registerAct("Console")
    self:registerAct("D-Console", "", {"dess"})
    if not Game:getFlag("dungeonkiller") then
        self:registerAct("J-Console", "", {"jamm"})
        self:registerAct("X-Console", "", {"dess", "jamm"})
    end
end

function Brenda:onAct(battler, name)
    if name == "Console" then
        if Game:getFlag("dungeonkiller") then
            if self.comfort == 0 then
                Game.battle:startActCutscene("brenda", "comfort1")
                return
            elseif self.comfort == 4 then
                Game.battle:startActCutscene("brenda", "dk_comfort3")
                return
            else
                return "* But you didn't know what to say..."
            end
        else
            if self.comfort == 0 then
                Game.battle:startActCutscene("brenda", "comfort1")
                return
            else
                return "* But you didn't know what to say..."
            end
        end
    elseif name == "D-Console" then
        if Game:getFlag("dungeonkiller") then
            if self.comfort == 1 then
                Game.battle:startActCutscene("brenda", "comfort2")
                return
            elseif self.comfort == 2 then
                Game.battle:startActCutscene("brenda", "dk_comfort1")
                return
            elseif self.comfort == 3 then
                Game.battle:startActCutscene("brenda", "dk_comfort2")
                return
            elseif self.comfort == 5 then
                Game.battle:startActCutscene("brenda", "dk_comfort4")
                return
            else
                return "* But you didn't know what to say..."
            end
        else
            if self.comfort == 1 then
                Game.battle:startActCutscene("brenda", "comfort2")
                return
            else
                return "* But you didn't know what to say..."
            end
        end
    elseif name == "J-Console" then
        if self.comfort == 2 then
            
            return
        else
            return "* But you didn't know what to say..."
        end
    elseif name == "X-Console" then
        if self.comfort == 3 then
            
            return
        else
            return "* But you didn't know what to say..."
        end
    elseif name == "Standard" then
        return "* But "..battler.chara:getName().." didn't know what to say..."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Brenda:onHurt(damage, battler)
    super.onHurt(self)

    self.hits = self.hits + 1
end

function Brenda:hurt(amount, battler, on_defeat, color, show_status_msg)
    -- This sucks ass but idk how to remove Dess's attack button mid-battle
    if battler.chara.id == "dess" and Game:getFlag("b_fight_dess") then
        amount = 0
        self.hits = self.hits - 1
    end

    show_status_msg = show_status_msg or true

    amount = amount / (BadgesLib:getBadgeEquipped("deal") + 1)

    self.health = self.health - amount
    if show_status_msg then
        self:statusMessage("damage", amount, color or (battler and {battler.chara:getDamageColor()}))
    end

    self.hurt_timer = 1
    self:onHurt(amount, battler)

    self:checkHealth(on_defeat, amount, battler)
end

return Brenda