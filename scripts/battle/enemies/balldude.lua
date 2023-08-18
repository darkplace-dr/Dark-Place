local BallDude, super = Class(EnemyBattler)

function BallDude:init()
    super:init(self)

    -- Enemy name
    self.name = "Ball Dude"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("balldude")

    -- Enemy health
    self.max_health = 900
    self.health = 900
    -- Enemy attack (determines bullet damage)
    self.attack = 12
    -- Enemy defense (usually 0)
    self.defense = 3
    -- Enemy reward
    self.money = 150
    self.experience = 26

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "balldude1",
        --"bobberry1",
        --"bobberry2"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "ballular",
		"heck yeah",
		"it's ball dude\nbaby"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 12 DF 3\n* Heck yeah."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Ball Dude is just balling it up.",
        "* Ball Dude is having a ball of a time.",
        "* Ball Dude is just here.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Ball Dude is losing his spherical shape."

    -- Register act called "Smile"
    self:registerAct("Tennis")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("X-Tennis", "", {"ralsei"})
end

function BallDude:onAct(battler, name)
    if name == "Tennis" then
        -- Give the enemy 100% mercy
        --self:addMercy(20)
        -- Change this enemy's dialogue for 1 turn
        --self.dialogue_override = "god I fucking love orbs"
		Game:setFlag("racket1", true)
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You play some Tennis with Ball Dude.\n* Paddle Get!",
        }

    elseif name == "X-Tennis" then
        -- Loop through all enemies
        --for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            --enemy:setTired(true)
			--self:
        --end
		Game:setFlag("racket1", true)
		Game:setFlag("racket2", true)
		return {
			"* Ultimate double paddle!!\n* Go!!!!",
		}

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(20)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei asked to play Tennis with Ball dude."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            return "* Susie started hitting Ball Dude with a tennis racket repeatedly."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super:onAct(self, battler, name)
end

return BallDude