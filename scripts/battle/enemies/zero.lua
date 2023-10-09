local Zero, super = Class(EnemyBattler)

function Zero:init()
    super.init(self)

    -- Enemy name
    self.name = "Zero"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("zero")

    -- Enemy health
    self.max_health = 3000
    self.health = 3000
    -- Enemy attack (determines bullet damage)
    self.attack = 12
    -- Enemy defense (usually 0)
    self.defense = 4
    -- Enemy reward
    self.money = 450

    self.boss = true

    self.downed = false
    Game.battle.disable_spare_all = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.disable_mercy = true

    self.difficulty = 0

    -- List of possible wave ids, randomly picked each turn
    if Game:getFlag("fun") == 12 and not Mod:isInRematchMode() then
        self.waves = {
            "zero/Ascend"
        }
    else
        self.waves = {
            "zero/Rolls",
            "zero/ColorSlash",
            "zero/Aiming",
        }
    end

    -- Dialogue randomly displayed in the enemy's speech bubble
    if Game:getFlag("fun") == 12 then
        self.dialogue = {
            "I must go.[wait:5] My people need me."
        }
    else
        self.dialogue = {}
    end

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {
    "AT ? DF ?\n* Deadly assassin known for quick kills.",
    "One mistake can spell your doom.",
    }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* ..."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    --self.low_health_text = "* ..."

    self:registerAct("Red Buster", "Red\nDamage", {"susie"}, 60)
    --self:registerAct("Red Buster", "Red\nDamage", {"robo_susie"}, 60)
    self:registerAct("Perish", "Perish")

end

function Zero:onAct(battler, name)
    if name == "Perish" then
        self:hurt(self.max_health, battler)
        self:explode(nil, nil, true)
        return ""
    elseif name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
        -- Fun fact! this function crashes if you return a string!
        return
    elseif name == "Standard" then --X-Action
        return "* But "..battler.chara:getName().." didn't know what to do."
    else
        return super.onAct(self, battler, name)
    end
end

function Zero:onHurt(damage,battler)
    self:setAnimation("hurtlong")

    self:getActiveSprite():shake(4, 0, 0.5, 2/30)

 
end

function Zero:onDefeat(damage, battler)
    if self.downed == true and Game.battle.encounter.zero_downed == true then
        self:setAnimation("hurt_ground")
        if Game.battle.state ~= "BATTLETEXT" and Game.battle.state ~= "ACTIONS" then
            Game.battle:setState("CUTSCENE")
        end
        if not Game.battle:hasCutscene() then
            Game.battle:startCutscene("zero", "killed")
        end
    else
        Game.battle.music:pause()
        self.disable_mercy = false
        self.mercy = 100
        self.low_health_text = "* ..."
        self:setAnimation("KO")
        if not self.downed then Assets.stopAndPlaySound("zero/downed") end
        self.waves = nil
        for i,battler in ipairs(Game.battle.party) do
            Game.battle:pushForcedAction(battler, "SKIP")
        end
        if Game.battle.state ~= "BATTLETEXT" and Game.battle.state ~= "ACTIONS" then
            Game.battle:setState("ACTIONSDONE")
        end
        self.downed = true
        Game.battle.money = Game.battle.money + self.money
    end
end

function Zero:onMercy()
    if self:canSpare() then
        if Game.battle.state ~= "BATTLETEXT" and Game.battle.state ~= "ACTIONS" then
            Game.battle:setState("CUTSCENE")
        end
        if not Game.battle:hasCutscene() then
            Game.battle:startCutscene("zero", "spared")
        end
    else
        self:addMercy(self.spare_points)
        return false
    end
end

return Zero