local GGuard, super = Class(EnemyBattler)

function GGuard:init()
    super.init(self)

    -- Enemy name
    self.name = "ErrorGuardian"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("gguard")

    self.defeat_type = "fatal"

    -- Enemy health
    self.max_health = 1500
    self.health = 1500
    -- Enemy attack (determines bullet damage)
    self.attack = 22.2
    -- Enemy defense (usually 0)
    self.defense = 9.9
    -- Enemy reward
    self.money = -99.9

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "aimingrr",
        "aimingrr"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "self.check = AT 4 DF 0* Cotton heart and button eye* Looks just like a fluffy guy'."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* pain",
        "* <EOF> expected near END",
        "* .",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The true way to deal with errors."

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Tell Story", "", {"ralsei"})
end

function GGuard:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(9.9)
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
        self:addMercy(9.9)
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

function GGuard:onDefeat(damage, battler)
    self:onDefeatFatal(damage, battler)
end

return GGuard