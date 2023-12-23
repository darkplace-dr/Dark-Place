local Test, super = Class(Wave)

function Test:init()
    super.init(self)

    self.time = -1
	self:setArenaSize(440, 160)
	self:setArenaPosition(320, 190)
end

function Test:onStart()
    Game.battle:swapSoul(BlueSoul())

    local arena = Game.battle.arena
    local haywire = self:spawnBullet("ph_boss/haywire", arena.x, -64)
end

function Test:onEnd()
    Assets.stopSound("ph_boss/haywire")
    Assets.stopSound("chain_extend")
end

return Test