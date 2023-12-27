local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 180
	self.arena_y = 800
	self.soul_start_y = 340
	
	self.time = 10
	
	self.num = 0
end

function Basic:onStart()
	local platform = self:spawnObject(Solid(true, 280, 360, 80, 4))
	
	Game.battle.timer:tween(2, platform, {alpha = 0}, linear, function()
		platform:remove()
	end)
	
	self.timer:every(1/4, function()
		local x = 320
		if self.num%4 == 1 then
			x = 240
		elseif self.num%4 == 3 then
			x = 400
		end
		-- Get a random Y position between the top and the bottom of the arena
		local y = 492

		-- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
		local bullet = self:spawnBullet("smallbullet_homing", x, y, math.rad(270), 8)

		-- Dont remove the bullet offscreen, because we spawn it offscreen
		bullet.remove_offscreen = false
		
		self.num = self.num + 1
    end)
	
	self.timer:after(3, function()
		self:spawnBullet("egg2_bigarms_homing", 480, -12, math.rad(90), 8)
	end)
	
	self.timer:after(7, function()
		self:spawnBullet("egg2_bigarms_homing", 160, -12, math.rad(90), 8)
	end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
	
	if Game.battle.soul.y > SCREEN_HEIGHT + 10 then
		local list = {}
		for k,v in ipairs(Game.battle.party) do
			if v.chara.health > 0 then
				table.insert(list, v)
			end
		end
		
		local member = Utils.pick(list)
		
		member:hurt(math.huge)
		Game.battle.encounter:onWavesDone()
	end
end

function Basic:onEnd()
	if Game.battle.encounter.big_arms and Game.battle.encounter.big_arms.health <= 0 then
		Game.battle:startCutscene("eggman.ending")
	end
end

return Basic