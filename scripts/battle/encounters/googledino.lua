local GoogleDino, super = Class(Encounter)

function GoogleDino:init()
    super.init(self)

    self.text = "* The no wifi pastime begins."

    self.music = "battle"

    self.background = true

    self:addEnemy("googledino")
	
	self.flee = false
	
    self.boss_rush = false
	
    if Game:getFlag("googledino_defeated") == true then
        self.boss_rush = true
    end
end

function GoogleDino:createSoul(x, y)
    return BlueSoul(x, y)
end

function GoogleDino:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    end
end

return GoogleDino
