local Basic, super = Class(Wave)

function Basic:onStart()
	local house = self:spawnBullet("deoxynn/mouse_house", Game.battle.arena:getRight(), Game.battle.arena:getTop())
	house.layer = 800
	local share = false
	local ex = false
	local battlers = Game.battle:getActiveEnemies()
	for k,v in pairs(battlers) do
		if (v.id ~= "rodenteer" and v.id ~= "rodenteer_ex") then
			share = true
		end
		if v.id == "rodenteer_ex" then
			ex = true
		end
	end
	local timeval = 5/6
	local numval = 1
	if share and not ex then
		timeval = 1
	elseif ex and not share then
		numval = 2
	end
    -- Every 0.33 seconds...
    self.timer:every(timeval, function()
		local attackers = self:getAttackers()
		for i = 1,numval,1 
		do 
			-- Our X position is offscreen, to the right
			local x = Game.battle.arena:getRight() + 10
			-- Get a random Y position between the top and the bottom of the arena
			local rany = math.random(1,4)
			
			local y = Game.battle.arena:getTop() - 20 + (36 * rany)

			-- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
			local bullet = self:spawnBulletTo(Game.battle.mask, "deoxynn/mouse", x, y, 4)

			-- Dont remove the bullet offscreen, because we spawn it offscreen
			bullet.remove_offscreen = false
		end
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super:update(self)
end

function Basic:onEnd(death)
end

return Basic