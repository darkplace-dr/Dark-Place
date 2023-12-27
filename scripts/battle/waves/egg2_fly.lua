local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 180
	self.arena_y = 800
	self.soul_start_y = 340
	
	self.time = 10
	
	self.left = true
end

function Basic:onStart()
	local platform = self:spawnObject(Solid(true, 280, 360, 80, 4))
	
	Game.battle.timer:tween(2, platform, {alpha = 0}, linear, function()
		platform:remove()
	end)
	
	self.timer:every(4/6, function()
		for i=1, 2 do
			local x = (i%2==0) and 680 or -20
			-- Get a random Y position between the top and the bottom of the arena
			local y = 300 - 40*i

			-- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
			local bullet = self:spawnBullet("smallbullet_homing", x, y, (i%2==0) and math.rad(180) or 0, 8)

			-- Dont remove the bullet offscreen, because we spawn it offscreen
			bullet.remove_offscreen = false
			
			self.left = not self.left
		end
    end)
	
	self.timer:after(3, function()
		self:spawnBullet("egg2_bigarms_homing", 700, 410, math.rad(180), 8)
		self.timer:after(0.25, function()
			self:spawnBullet("smallbullet_homing", 700, 370, math.rad(180), 8)
			self.timer:after(0.25, function()
				self:spawnBullet("smallbullet_homing", 700, 330, math.rad(180), 8)
				self.timer:after(0.25, function()
					self:spawnBullet("smallbullet_homing", 700, 290, math.rad(180), 8)
				end)
			end)
		end)
	end)
	
	self.timer:after(7, function()
		self:spawnBullet("egg2_bigarms_homing", 700, 410, math.rad(180), 8)
		self.timer:after(0.25, function()
			self:spawnBullet("smallbullet_homing", 700, 370, math.rad(180), 8)
			self.timer:after(0.25, function()
				self:spawnBullet("smallbullet_homing", 700, 330, math.rad(180), 8)
				self.timer:after(0.25, function()
					self:spawnBullet("smallbullet_homing", 700, 290, math.rad(180), 8)
				end)
			end)
		end)
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