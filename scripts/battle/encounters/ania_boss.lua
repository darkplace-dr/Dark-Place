local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The dungeon boss approaches.\n* Jamm is stunned."

    -- Battle music ("battle" is rude buster)
    self.music = "jamm_boss"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("shade_ania")
end

-- function Dummy:onBattleStart()
	-- local jamm = Game.battle.party[1]
	-- jamm.chara.stun = true
	-- jamm:setSprite("battle/hurt_1")
-- end

-- function Dummy:update()
	-- super:update(self)
	-- local jamm = Game.battle.party[1]
	-- if Game.battle.turn_count < 2 then
		-- jamm.chara.stun = true
	-- end
	-- if jamm.chara.stun then
		-- jamm:setSprite("battle/hurt_1")
	-- end
-- end

return Dummy