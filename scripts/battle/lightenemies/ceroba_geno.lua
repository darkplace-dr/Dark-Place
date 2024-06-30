local Ceroba, super = Class(LightEnemyBattler)

function Ceroba:init()
    super:init(self)

    self.name = "Ceroba"
    self:setActor("cerobaboss")

    self.max_health = 1000
    self.health = 1000
    self.attack = 13
    self.defense = 21
    self.money = 50
    self.experience = 1500

    self.spare_percentage = 0
    self.phase = 1
    self.attack_cycle = 0
    self.low_health = false
    
    self.dialogue_bubble = "ut_wide"
    self.dialogue_offset = {-20, -30}

    self.waves = {
        "steamworks/ceroba_opener"
    }

    self.check = "ATK 13 DEF 21\n* Nothing left."

    self.text = {
        "* There is no hope.",
        "* She wipes sweat from\nher brow.",
        "* The sand swirls around you.",
        "* She stares into your SOUL.",
        "* The fight rages.",
        "* The atmosphere chills with\nire.",
        "* No mercy."
    }

    --self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    self:registerAct("Resist")
    self:registerAct("Calm")
    self:registerAct("Mock")

    self.large_dust = true

    self.gauge_size = {250, 18}

    self.damage_offset = {0, 30}
end

function Ceroba:onDefeat(damage, battler)
    self.hurt_timer = -1
    if Game.battle.battle_ui.attacking then
        Game.battle.battle_ui:endAttack()
    end
    Game.battle:setState("NONE")
    Game.battle:startCutscene("ceroba_geno", "death")
end

function Ceroba:onAct(battler, name)
    if name == "Resist" then
        return "* You hold your ground against\nthe magic."
    elseif name == "Calm" then
        return "* You take a moment to breathe,\npreparing for what's to come."
    elseif name == "Mock" then
        return "* You attempt to belittle your\nopponent but she's in another\nworld."
    elseif name == "Standard" then
        return "* But there was nothing "..battler.chara:getName().."\ncould do."
    end

    return super:onAct(self, battler, name)
end

function Ceroba:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
    if self.low_health == false and self.health < 250 then
        self.low_health = true
        self:setActor("cerobaboss_p2_hurt")
    end
end

function Ceroba:getNextWaves()
    if self.attack_cycle == 0 then
        self.attack_cycle = 1
        return {"steamworks/ceroba_opener"} -- Opening Attack
    elseif self.health <= 500 and self.phase == 1 then
        if self.attack_cycle == 9 then
            self.attack_cycle = 1
        else
            self.attack_cycle = self.attack_cycle + 1
        end
        return {"steamworks/ceroba_opener"} -- Phase Switch Attack
    elseif self.attack_cycle == 1 then
        self.attack_cycle = 2
        return {"steamworks/ceroba_opener"} -- Attack 1
    elseif self.attack_cycle == 2 then
        self.attack_cycle = 3
        return {"steamworks/ceroba_opener"} -- Attack 2
    elseif self.attack_cycle == 3 then
        self.attack_cycle = 4
        return {"steamworks/ceroba_opener"} -- Attack 3
    elseif self.attack_cycle == 4 then
        self.attack_cycle = 5
        return {"steamworks/ceroba_opener"} -- Attack 4
    elseif self.attack_cycle == 5 then
        self.attack_cycle = 6
        return {"steamworks/ceroba_opener"} -- Attack 5
    elseif self.attack_cycle == 6 then
        self.attack_cycle = 7
        return {"steamworks/ceroba_opener"} -- Attack 6
    elseif self.attack_cycle == 7 then
        self.attack_cycle = 8
        return {"steamworks/ceroba_opener"} -- Attack 7
    elseif self.attack_cycle == 8 then
        self.attack_cycle = 9
        return {"steamworks/ceroba_opener"} -- Attack 8
    elseif self.attack_cycle == 9 then
        self.attack_cycle = 1
        return {"steamworks/ceroba_opener"} -- Attack 9
    end
    return super.getNextWaves(self)
end

return Ceroba