local Werewire, super = Class("custom_encounter")

function Werewire:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Werewires swung in!"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the werewires to the encounter
    self:addEnemy("werewire", 528, 156)
    self:addEnemy("werewire", 558, 286)

    -- For the encounter selector
    self.overworld_actor = "werewire"
end

function Werewire:onActionsStart()
    self.check_for_miss = false
    for i,action in pairs(Game.battle.character_actions) do
        if action.action == "ATTACK" then
            self.check_for_miss = true
            break
        end
    end
end

function Werewire:onActionsEnd()
    if self.check_for_miss then
        self.last_missed = true
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy.health < enemy.max_health then
                self.last_missed = false
                break
            end
        end
    else
        self.last_missed = false
    end
end

function Werewire:getEncounterText()
    if self.check_for_miss and self.last_missed then
        return "* Try timing your attacks by\npressing [bind:confirm]!"
    else
        return super:getEncounterText(self)
    end
end

return Werewire