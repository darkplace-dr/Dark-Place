local Hathy, super = Class(EnemyBattler)

function Hathy:init()
    super.init(self)

    self.name = "Hathy"
    self:setActor("hathy")

    self.max_health = 150
    self.health = 150
    self.attack = 6
    self.defense = 0
    self.money = 28
    self.experience = 7

    self.spare_points = 20

    local enemies = Game.battle:getActiveEnemies()
    if #enemies >= 2 then
        self.waves = {
            "hathy/spinheart"
        }
    else
        self.waves = {
            "hathy/heartshaper"
        }
    end

    self.dialogue = {
        "[voice:nil]\n[image:enemies/hathy/heartchomp, 0, -5, 1, 1, 0.2]\n",
        "[voice:nil]\n[image:enemies/hathy/heartkiss, 0, -5, 1, 1, 0.2]\n"
    }

    self.check = "AT 7 DF 0\n* I am a [color:yellow]little kiss[color:reset]."

    self.text = {
        "* Hathy's body beats audibly.",
        "* Hathy smiled a darling smile.",
        "* Hathy is whispering a lovely spell.",
        "* Hathy has a little secret.",
        "* Smells like a soft kiss."
    }
    self.low_health_text = "* Hathy's beat seems to stutter."
    self.spareable_text = "* Hathy is skipping beats."

    self:registerAct("Flatter")
    self:registerAct("X-Flatter", "", {"ralsei"})
    self:registerAct("S-Flatter", "", {"susie"})
end

function Hathy:onAct(battler, name)
    if name == "Flatter" then
        self:addMercy(100)
        self.dialogue_override = "[voice:nil]\n[image:enemies/hathy/smallheart, 0, -17, 1, 1, 0.2]"
        if math.random(1, 3) == 1 then
            return "* You told Hathy it has cool tentacles.[wait:10]\n* It began to think about this..."
        elseif math.random(1, 3) == 2 then
            return "* You called Hathy a sweetheart.[wait:10]\n* It began to think about this..."
        else
            return "* You told Hathy its teeth look like knives.[wait:10]\n* It began to think about this..."
        end
    elseif name == "X-Flatter" then
        for _, enemy in ipairs(Game.battle.enemies) do
            if enemy.name == "Hathy" then
                enemy.dialogue_override = "[voice:nil]\n[image:enemies/hathy/smallhearts, 0, -5, 1, 1, 0.2]\n"
            end
        end
        Game.battle:startActCutscene("hathy", "x_flatter")
        return
    elseif name == "S-Flatter" then
        for _, enemy in ipairs(Game.battle.enemies) do
            if enemy.name == "Hathy" then
                enemy.dialogue_override = "[voice:nil]\n[image:enemies/hathy/smallhearts, 0, -5, 1, 1, 0.2]\n"
            end
        end
        Game.battle:startActCutscene("hathy", "s_flatter")
        return
    elseif name == "Standard" then
        self:addMercy(50)
        return "* "..battler.chara:getName().." smiled at Hathy."
    end

    return super.onAct(self, battler, name)
end

function Hathy:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end
    
    return Utils.pick(self.dialogue)
end

function Hathy:update()
    super.update(self)
    local enemies = Game.battle:getActiveEnemies()
    if #enemies >= 2 then
        self.waves = {
            "hathy/heartshaper"
        }
    else
        self.waves = {
            "hathy/spinheart"
        }
    end
end

return Hathy