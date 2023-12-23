local Basic, super = Class(Wave)

function Basic:onStart()
	local attackers = self:getAttackers()
	self.time = 7
	self.racket1bullet = nil
	self.racket2bullet = nil
    -- Every 0.33 seconds...
    --self.timer:every(1/3, function()
        -- Our X position is offscreen, to the right
        --local x = SCREEN_WIDTH + 20
        -- Get a random Y position between the top and the bottom of the arena
        --local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        --local bullet = self:spawnBullet("smallbullet", x, y, math.rad(180), 8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        --bullet.remove_offscreen = false
    --end)
	for i=0,#attackers-1 do
		local bullet = self:spawnBullet("balldudebullet", Game.battle.arena:getRight() - 16, Game.battle.arena:getTop() + 16 + (i*20), 0, 0)
	end
	
	if Game:getFlag("racket1") then
		self.racket1bullet = self:spawnBullet("racket1", Game.battle.soul.x + 16, Game.battle.soul.y - 8, 0, 0)
	end
	if Game:getFlag("racket2") then
		self.racket2bullet = self:spawnBullet("racket2", Game.battle.soul.x - 16, Game.battle.soul.y - 8, 0, 0)
	end
	
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic