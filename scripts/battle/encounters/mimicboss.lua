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
    self:addEnemy("mimic")

end

function UfoEncounter:onBattleStart()
	super:onBattleStart(self)
	Game.battle.encounter.bg = StarsBG({1, 1, 1})
	Game.battle:addChild(Game.battle.encounter.bg)
	Game.battle.encounter.bg.visible = true
end

return UfoEncounter