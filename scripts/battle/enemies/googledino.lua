local GoogleDino, super = Class(EnemyBattler)

function GoogleDino:init()
    super.init(self)

    -- Enemy name
    self.name = "Google Dino"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("googledino")

    -- Enemy health
    self.max_health = 970
    self.health = 970
    -- Enemy attack (determines bullet damage)
    self.attack = 5
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = 98
    self.experience = 5
	
    self.difficulty = 1

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 10

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "googledino/runner"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 5 DF 2"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* (Your internet has been disconnected.)",
        "* ",
        "* Smells like network diagnostics.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    -- Register act called "Smile"
    self:registerAct("Reboot")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("X-Reboot", "", {"susie"})
end

function GoogleDino:onAct(battler, name)
    if name == "Reboot" then
        -- Give the enemy 100% mercy
		Assets.playSound(Utils.pick{
            "dialup_0",
            "dialup_1",
		    "dialup_2",
		    "dialup_3",
		    "dialup_4",
		    "dialup_5",
        })
        self:addMercy(10)
        self.difficulty = self.difficulty + 1
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You attempt to reboot the internet...\n[wait:5]* Mercy increased by 10%!",
        }

    elseif name == "X-Reboot" then
        -- Give the enemy 100% mercy
		Assets.playSound(Utils.pick{
            "dialup_0",
            "dialup_1",
		    "dialup_2",
		    "dialup_3",
		    "dialup_4",
		    "dialup_5",
        })
        self:addMercy(25)
        self.difficulty = self.difficulty + 1
        return "* You both attempted to reboot the internet...\n[wait:5]* Difficulty increased!"

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            self:addMercy(5)
            return "* Ralsei jumped as high as he could. The dino jumped back in response."
        elseif battler.chara.id == "susie" then
            --S-Action text
            self:addMercy(5)
            return "* Susie roared at the Dino.\n* It roared back. What an interesting conversation!"
		elseif battler.chara.id == "dess" then
            -- D-Action text
            return "* Dess did absolutely nothing. The dino got bored and started feeling [color:blue]TIRED[color:reset]."
		elseif battler.chara.id == "brandon" then
            -- D-Action text
            return "* Brandon got up and did the dinosaur. The dino wasn't sure what to make of this."
        else
            -- Text for any other character (like Noelle)
            self:addMercy(5)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return GoogleDino