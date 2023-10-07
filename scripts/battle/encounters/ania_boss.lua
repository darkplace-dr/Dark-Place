local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The dungeon boss approaches.\n* Jamm is stunned."
	
	self.boss_rush = false
	if Game:getFlag("jamm_closure") == true then
        self.boss_rush = true
        self.text = "* The dungeon boss approaches."
    end

    -- Battle music ("battle" is rude buster)
    self.music = nil
	if self.boss_rush then
		self.music = "jamm_boss"
	end
    -- Enables the purple grid battle background
    self.background = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("shade_ania")
end

function Dummy:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    end
end

function Dummy:onBattleStart()
	if not self.boss_rush then
		local jamm = Game.battle.party[1]
		jamm.chara.stun = true
		jamm:setSprite("battle/hurt_1")
	end
end

function Dummy:update()
	super:update(self)
	if not self.boss_rush then
		local jamm = Game.battle.party[1]
		if Game.battle.turn_count < 2 and not Game.battle.unstun then
			jamm.chara.stun = true
		end
		if jamm.chara.stun then
			jamm:setSprite("battle/hurt_1")
		end
	end
end

function Dummy:getEncounterText()
	if Game.battle.turn_count%5 == 3 then
		return "* A lethal attack is coming!\n* Brace yourself!"
	end
	return super:getEncounterText(self)
end

return Dummy
