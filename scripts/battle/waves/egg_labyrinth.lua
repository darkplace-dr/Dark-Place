local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 120
	self.arena_height = 440
	self.arena_y = SCREEN_HEIGHT/2
    self.soul_start_y = 420
    self.soul_start_x = 300
	
	self.time = 10
end

function Basic:onStart()
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 30, Game.battle.arena:getBottom() - 70, 30, 70))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 60, Game.battle.arena:getBottom() - 30, 30, 30))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 75, Game.battle.arena:getBottom() - 100, 20, 30))
	self:spawnObject(Solid(true, Game.battle.arena:getLeft(), Game.battle.arena:getBottom() - 140, 20, 70))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 30, Game.battle.arena:getBottom() - 200, 30, 50))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 60, Game.battle.arena:getBottom() - 160, 30, 10))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 75, Game.battle.arena:getBottom() - 230, 20, 30))
	self:spawnObject(Solid(true, Game.battle.arena:getLeft(), Game.battle.arena:getBottom() - 270, 20, 70))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 30, Game.battle.arena:getBottom() - 330, 30, 50))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 60, Game.battle.arena:getBottom() - 290, 30, 10))
	self:spawnObject(Solid(true, Game.battle.arena:getRight() - 75, Game.battle.arena:getBottom() - 360, 20, 30))
	self:spawnObject(Solid(true, Game.battle.arena:getLeft(), Game.battle.arena:getBottom() - 400, 20, 70))
	
	self:spawnBullet("egg_spikes_labyrinth", 320, 520)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic