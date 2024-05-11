local Ceroba, super = Class(LightEnemyBattler)

function Ceroba:init()
    super:init(self)

    self.name = "Ceroba"
    self:setActor("cerobaenemy")

    self.max_health = 1000
    self.health = 1000
    self.attack = 13
    self.defense = 21
    self.money = 50
    self.experience = 1500

    self.spare_percentage = 0
    self.phase = 1
    self.low_health = false
    
    self.dialogue_bubble = "ut_wide"
    self.dialogue_offset = {-20, -30}

    self.waves = {
        "basic",
        "aiming"
    }

    --[[self.dialogue = {
        "[speed:0.5]....."
    }]]

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
        self:setActor("cerobaenemy_p2_hurt")
    end
end

--[[function Ceroba:getNextWaves()
    if self.progress >= 11 then
        return nil
    end
    return super.getNextWaves(self)
end]]

return Ceroba