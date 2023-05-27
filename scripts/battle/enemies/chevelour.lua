local chevelour, super = Class(EnemyBattler)

function chevelour:init()
    super.init(self)

    -- Enemy name
    self.name = "Chevelour"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/chevelour.lua)
    self:setActor("chevelour")

    -- Enemy health
    self.max_health = 1200
    self.health = 1200
    -- Enemy attack (determines bullet damage)
    self.attack = 2
    -- Enemy defense (usually 0)
    self.defense = 3
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "chevelour/mousedrop",
        "chevelour/mouserun"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Pasta la Vista!"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 2 DF 3\n* Rat :)"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Chevelour gives you a wide\ngrin.",
        "* The power of rats is in the air.",
        "* Smells like cheese.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Chevelour looks like she's about to fall."

        -- Register act called "Smile"
        -- Register party act with Ralsei called "Tell Story"
        -- (second argument is description, usually empty)
        self:registerAct("Insult")
        self:registerAct("X2 Insult", "", {"susie"})
    end
    
    function chevelour:onAct(battler, name)
        if name == "Insult" then
            self:addMercy(10)
            self.attack = self.attack + .5
            Game.battle:startActCutscene("chevelour", "Insult")
            return

        elseif name == "X2 Insult" then
            self:addMercy(15)
            self.attack = self.attack + 1
            Game.battle:startActCutscene("chevelour", "X2_Insult")
            return
            
        elseif name == "Standard" then --X-Action
            -- Give the enemy 50% mercy
            self:addMercy(5)
            if battler.chara.id == "ralsei" then
                -- R-Action text
                return "* Ralsei complimented Chevelour.\n* Chevelour laughed."
            else
                -- Text for any other character (like Noelle)
                return "* "..battler.chara:getName().." gave a compliment."
            end
        end
    
        -- If the act is none of the above, run the base onAct function
        -- (this handles the Check act)
        return super.onAct(self, battler, name)
end


return chevelour