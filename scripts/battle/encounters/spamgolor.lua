local Spamgolor, super = Class(Encounter)

function Spamgolor:init()
    super.init(self)

    self.text = "* Spamgolor blocks your way."

    self.music = "spamgolor_battle"
    self.background = true

    self:addEnemy("spamgolor")
	
	self.flee = false

    self.boss_rush = false
	
    if Game:getFlag("spamgolor_defeated") == true then
        self.boss_rush = true
    end
end

function Spamgolor:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    end
end

return Spamgolor
