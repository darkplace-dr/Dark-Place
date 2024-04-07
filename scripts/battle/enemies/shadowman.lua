local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    self.name = "Shadowman"
    self:setActor("shadowman")
    self.sprite:play(1/4)

    self.max_health = 1900
    self.health = 1900
    self.attack = 4
    self.defense = 0
    self.money = 100
    self.experience = 5

    self.spare_points = math.floor(20/#Game.battle.party)
    self.tired_percentage = 0.25
	self.service_mercy = 15

    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    self.dialogue = {
        "We're the shadows!\n...And men.",
        "Surprise me!",
        "I don't have shade\nto throw.",
        "I like my coffee black.\nJust like me."
    }

    self.check = "AT 8 DF 3\n* Always looking for something that would knock their socks off."

    self.text = {
        "* Shadowman readies his gun.",
        "* Shadowman remembers he has a casting soon.",
        "* Shadowman looks for something impressive.",
        "* Shadowman looks for his shadow before realizing there's none."
    }
    self.low_health_text = "* Shadowman slowly fades into the darkness."

    self:registerAct("Knock Off!")
    local party = {}
    for i,v in ipairs(Game.battle.party) do
        table.insert(party, v.chara.id)
    end
    self:registerAct("Knock Off DX!", nil, party)
end

function Dummy:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You smile.[wait:5]\n* The dummy smiles back.",
            "* It seems the dummy just wanted\nto see you happy."
        }

    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "* You and Ralsei told the dummy\na bedtime story.\n* The enemies became [color:blue]TIRED[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
		elseif battler.chara.id == "dess" then
            -- D-Action text
            return "* Dess spun something around."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Dummy