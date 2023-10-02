local UfoEncounter, super = Class(Encounter)

function UfoEncounter:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* It's too easy!"

    -- Battle music ("battle" is rude buster)
    self.music = "threestrikesyoureout"

    -- Enables the purple grid battle background
    self.background = false
	self.hide_world = true

	self.energy = 0

    -- Add the dummy enemy to the encounter
    self.mimic = self:addEnemy("mimic")
    self.death_cine_played = false
	
	self.flee = false

    self.boss_rush = false
	
    if Game:getFlag("mimic_defeated") == true then
        self.boss_rush = true
    end
end

function UfoEncounter:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    else
        self.bg = StarsBG({1, 1, 1})
	    Game.battle:addChild(self.bg)
    end
end

function UfoEncounter:onActionsEnd()
    if (self.mimic.done_state == "VIOLENCE" or self.mimic.done_state == "KILLED")
        and not self.death_cine_played then
        self.death_cine_played = true
        local cutscene = Game.battle:startCutscene("mimic.dies", nil, self.mimic)
        cutscene:after(function ()
            Game.battle:setState("ENEMYDIALOGUE")
        end)
        return true
    end
end

return UfoEncounter
