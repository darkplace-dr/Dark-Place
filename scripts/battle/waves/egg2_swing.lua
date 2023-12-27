local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
	
	self.arena_width = 130
	self.arena_height = 10
	self.arena_y = 300
    self.soul_start_y = 260
	
	self.time = 10
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.swinger = self:spawnBullet("egg_swing", Game.battle.arena:getRight(), Game.battle.arena:getTop() - 142)
	
	self.timer:every(3, function()
        -- Get a random Y position between the top and the bottom of the arena
        local y = -30

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("egg2_bigarms_homing", Game.battle.arena:getLeft() + (self.left and -30 or 160), y, math.rad(90), 8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
		
		self.left = not self.left
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