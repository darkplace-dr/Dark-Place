local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Booty time"

    -- Battle music ("battle" is rude buster)
    self.music = "booty_boss"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("booty")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")

	if Game:getFlag("booty_finished") == true then
        self.boss_rush = true
    end
end

function Dummy:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    end
end

function Dummy:createSoul(x, y, color)
	return StarSoul(x,y)
end

function Dummy:beforeStateChange(old, new)
	if new == "ENEMYDIALOGUE" and Game.battle.enemies[1] and Game.battle.enemies[1].health == 0 and not Game.battle.enemies[1].defeat_once then
		Game.battle:startCutscene("booty.surrender")
	end
end

return Dummy