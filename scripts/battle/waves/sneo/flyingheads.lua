local FlyingHeads, super = Class(Wave)

function FlyingHeads:init()
    super.init(self)
	
	self.time = 15
	self:setArenaSize(240, 110)
	self:setArenaPosition(300, 175)

    self.sneo = Game.battle:getEnemyBattler("sneo")
	self.sneo.sprite:setPartSine("head", 2)
    self.type = 2
end
function FlyingHeads:onStart()
	Game.battle:swapSoul(YellowSoul())

    local bulletmaker = self:spawnObject(SNEOGuyMaker(0, 0))

    if self.type == 1 then
	    bulletmaker.type = 2
    end	
    if self.type == 2 then
	    bulletmaker.type = 5
        self.sneo:setAnimation("walk")
        self.sneo.sprite.head:setFrame(3)
        self.sneo:setMode("shoot")
    end
end

function FlyingHeads:onEnd()
    super.onEnd(self)
	self.sneo.sprite:setPartSine("head", 0)
    self.sneo:setAnimation("idle")
    self.sneo:setMode("normal")
end

return FlyingHeads