local FlyingHeads, super = Class(Wave)

function FlyingHeads:init()
    super.init(self)
	
	self.time = 15
	self:setArenaSize(240, 110)
	self:setArenaPosition(300, 175)
end

function FlyingHeads:onStart()
	Game.battle:swapSoul(YellowSoul())
	
    local bulletmaker = self:spawnObject(SNEOGuyMaker(0, 0))
	bulletmaker.type = 2

    -- for testing purposes, lol.
    self.timer:after(5, function()
        bulletmaker.type = 5
	end)
end

return FlyingHeads