local GGuard2, super = Class(EnemyBattler)

function GGuard2:init()
    super.init(self)

    -- Enemy name
    self.name = "ErrorGuardian EX"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("errorman")

    self.defeat_type = "fatal"

    -- Enemy health
    self.max_health = 9999.9
    self.health = 9999.9
    -- Enemy attack (determines bullet damage)
    self.attack = 12.12
    -- Enemy defense (usually 0)
    self.defense = 9.9
    -- Enemy reward
    self.money = 999.9

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = -20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "aiming",
        "aimingr",
        "aimingrr",
        "bobberry1",
        "zero/Aiming",
        "spamgolor/everything",
        "thestars/starcircle",
        "gun",
        "ch1_fields/neo_ponman/spreadshot"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "self.check = AT DF."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "*************************************************************************************"
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The Err*r151."

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Tell Story", "", {"ralsei"})
end

function GGuard2:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(0.0000000000000000000001)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "yo what ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You smile.[wait:5]\n* The dummy smiles back.",
            "* It seems the dummy just wanted\nto see you suffer."
        }

    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(false)
        end
        return "* You and Ralsei told the dummy a bedtime story.* The enemies became    ."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(0.0000000000000000000001)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            
            return "Susie didn't fix anything."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\n[wait:20]'s hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function GGuard2:onDefeat(damage, battler)
    self:onDefeatFatal(damage, battler)
end

return GGuard2