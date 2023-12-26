local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 130
	
	self.time = 10
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.swinger = self:spawnBullet("egg_swing", Game.battle.arena:getRight(), Game.battle.arena:getTop())
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic