local LightTransition, super = Class(Object)

function LightTransition:init(x, y, data)
	local data = data or {}
	super.init(self, x, y, 100, 35)

    if #Game.stage:getObjects(DarkTransition) > 0 then
		self:remove()
		return
	end
	
	self.circle = Assets.getTexture("ui/lightcircle")
	self.pillar = Assets.getTexture("ui/lightpillar")
	
	self.layer = WORLD_LAYERS["below_ui"]
	
	self:setScale(1.5, 2)

	self.con = 0
	self.siner = 0
	self.drawpillar = true
	self.pillarsiner = 0
	self.pillaralpha = 0
	self.pillarscale = 2
	self.particletimer = 0
	
	self.kris_only = false
	self.ralsei_animation = true
	
	-- cutscene
	self.cutsceneSettings = {
		fake_layer = 500,
		fake_speed_y = 3,
		fake_gravity = -0.45,
		
		walk_wait = 0.8,
		afterWalk_wait = 0.1,
		
		walk_distance = 48,
		
		fadeOut_speed = 1.8,
		fadeIn_speed = 12.5/30,
	}
	
	self.collider = CircleCollider(self, 0, 35, 35)
	
	self.newMap = {
		name = data.map,
		marker = data.marker or "spawn",
		facing = data.mapFacing or 'down',
	}
	if not self.newMap.name then
		error("Map name not set for LightTransition.")
	end
end

local function point_distance(x1, y1, x2, y2)
	return math.sqrt(((x1 - x2)^2) + ((y1 - y2)^2))
end

function LightTransition:afterMoveCallback() end

function LightTransition:beforeFadeCallback() end

function LightTransition:afterFadeCallback() end

function LightTransition:afterEndCallback() end

function LightTransition:touchCallback(player)
	return true
end

function LightTransition.cutscene(cutscene, self, player)
    cutscene:detachFollowers()
	local event = self.parent
	local settings = self.cutsceneSettings
	
	local kris_only = false
	if Game.party[2] == nil then -- If no second member, assume empty party
		kris_only = true
	end
    local p1 = cutscene:getCharacter(Game.party[1].actor.id)
	local p2 if Game.party[2] then p2 = cutscene:getCharacter(Game.party[2].actor.id) end
	local p3 if Game.party[3] then p3 = cutscene:getCharacter(Game.party[3].actor.id) end
	local p4 if Game.party[4] then p4 = cutscene:getCharacter(Game.party[4].actor.id) end
    local ralsei = cutscene:getCharacter("ralsei")
	
	local distance = settings.walk_distance
	local wait = settings.walk_wait
	
	do
		local toY = event.y + self.collider.radius
		if p3 then toY = toY + 20 end
		
		cutscene:walkTo(p1, event.x + ((kris_only and 0) or 48), toY, 0.8, 'down', true)
		
		if p2 and not kris_only then
			cutscene:walkTo(p2, event.x - 48, toY, 0.8, 'down', true)
		end

		if p3 and not kris_only then
			if not p4 then
				cutscene:walkTo(p3, event.x, toY - 30, 0.8, 'down', true)
			else
				cutscene:walkTo(p3, event.x + 28, toY - 30, 0.8, 'down', true)
			end
		end

		if p4 and not kris_only then
			cutscene:walkTo(p4, event.x - 28, toY - 30, 0.8, 'down', true)
		end

	end
	
	cutscene:wait(wait + settings.afterWalk_wait)
	self:afterMoveCallback()
	
	if ralsei and self.ralsei_animation then ralsei:setAnimation("wave_start") end

	cutscene:playSound("dtrans_lw")
	
	-- Do we need to do this? why not just... do this to the actual characters?
	-- p1
    p1.visible = false
	local fake_p1 = Sprite("party/"..p1.actor.id:lower().."/dark_transition/dark", p1.x, p1.y)
	fake_p1.physics.speed_y = settings.fake_speed_y
	fake_p1.physics.gravity = settings.fake_gravity
	fake_p1:setAnimation{"party/"..p1.actor.id:lower().."/dark_transition/dark", 0.1, true}
	fake_p1:setScale(2)
	fake_p1:setOrigin(0.5, 1)
	Game.world:spawnObject(fake_p1, settings.fake_layer)



	-- p2
	if p2 and not kris_only then
		p2.visible = false
		local fake_p2 = Sprite("party/"..p2.actor.id:lower().."/dark_transition/dark", p2.x, p2.y)
		fake_p2.physics.speed_y = settings.fake_speed_y
		fake_p2.physics.gravity = settings.fake_gravity
		fake_p2:setAnimation{"party/"..p2.actor.id:lower().."/dark_transition/dark", 0.1, true}
		fake_p2:setScale(2)
		fake_p2:setOrigin(0.5, 1)
		Game.world:spawnObject(fake_p2, settings.fake_layer)
	end



	-- p3
	if p3 and not kris_only then
		p3.visible = false
		local fake_p3 = Sprite("party/"..p3.actor.id:lower().."/dark_transition/dark", p3.x, p3.y)
		Log:print("party/"..p3.actor.id:lower().."/dark_transition/dark")
		fake_p3.physics.speed_y = settings.fake_speed_y
		fake_p3.physics.gravity = settings.fake_gravity
		fake_p3:setAnimation{"party/"..p3.actor.id:lower().."/dark_transition/dark", 0.1, true}
		fake_p3:setScale(2)
		fake_p3:setOrigin(0.5, 1)
		Game.world:spawnObject(fake_p3, settings.fake_layer)
	end



	-- p4
	if p4 and not kris_only then
		p4.visible = false
		local fake_p4 = Sprite("party/"..p4.actor.id:lower().."/dark_transition/dark", p4.x, p4.y)
		Log:print("party/"..p4.actor.id:lower().."/dark_transition/dark")
		fake_p4.physics.speed_y = settings.fake_speed_y
		fake_p4.physics.gravity = settings.fake_gravity
		fake_p4:setAnimation{"party/"..p4.actor.id:lower().."/dark_transition/dark", 0.1, true}
		fake_p4:setScale(2)
		fake_p4:setOrigin(0.5, 1)
		Game.world:spawnObject(fake_p4, settings.fake_layer)
	end
	--]]

	--p1.physics.speed_y = settings.fake_speed_y
	--p1.physics.gravity = settings.fake_gravity
	--p1:setAnimation{p1.actor.path.."/dark_transition/dark", 0.1, true}

	
	self:beforeFadeCallback()

	cutscene:wait(cutscene:fadeOut(settings.fadeOut_speed, {color = {1, 1, 1}}))
	cutscene:wait(0.75)

	cutscene:loadMap(self.newMap.name, self.newMap.marker, self.newMap.facing)
	self:afterFadeCallback()
	
	fake_p1:remove()
	if fake_p2 then fake_p2:remove() end
    p1.visible = true
	if p2 then
    	p2.visible = true
	end
	cutscene:fadeOut(0)
	cutscene:fadeIn(settings.fadeIn_speed, {color = {1, 1, 1}})
	cutscene:interpolateFollowers()

	self:afterEndCallback()
end

function LightTransition:update()
	super.update(self)
	
	self.particletimer = self.particletimer + (1 * DTMULT)
	if (self.particletimer >= 2) then
		local ox = self.x
		local oy = self.y + self.height * .5
		
		-- instance_create(random_range((x - (sprite_width / 2)), (x + (sprite_width / 2))), (y - random(sprite_height)), obj_dw_transition_particle)
		local particle = LightTransitionParticle(love.math.random((ox - (self.width * .75)), (ox + (self.width * .75))), (oy - love.math.random(self.height + 240)))
		self:addChild(particle)
		
		self.particletimer = 0
	end
	
	if self.collider:collidesWith(Game.world.player) and not Game.world.cutscene then
		local continue = self:touchCallback(Game.world.player)
		
		if continue then
			Game.world:startCutscene(self.cutscene, self, Game.world.player)
		end
	end
end

function LightTransition:drawLight(moreAlpha)
	local moreAlpha = (moreAlpha or 0)
	self.pillarsiner = self.pillarsiner + (1 * DTMULT)
	
	local dist = 0
	local ox = self.width * .5
	local player = Game.world.player
	if player then
		dist = point_distance(self.x + ox, self.y, player.x + 20, (player.y + 30) - 30)
	end
	
	local alphadist = (dist / 1500)
	if alphadist >= 0.3 then
		alphadist = 0.3
	end
	
	for i = 1, 3 do
		local sinoff = math.sin(((i * .25) + (self.pillarsiner / 10)))
		-- draw_sprite_ext(sprite_index, 0, x, y, ((image_xscale - (0.3 * i)) + (sin(sinoff) * 0.1)), image_yscale, 0, c_white, ((((0.7 - alphadist) + (sin(sinoff) * 0.01)) + pillaralpha) / 2))
		love.graphics.push('all')
		
		local alpha = ((((0.7 - alphadist) + (math.sin(sinoff) * 0.01)) + self.pillaralpha) / 2)
		love.graphics.setColor(1, 1, 1, alpha + moreAlpha)
		love.graphics.draw(self.circle, 0, 0, 0, ((2 - (0.3 * i)) + (math.sin(sinoff) * 0.1)), 1, ox, 0)
		
        -- draw_sprite_ext(sprite_index, 1, x, y, ((pillarscale - (0.3 * i)) + (sin(sinoff) * 0.1)), image_yscale, 0, c_white, ((((0.4 - alphadist) + (sin(sinoff) * 0.01)) + pillaralpha) / 3))
		local alpha = ((((0.4 - alphadist) + (math.sin(sinoff) * 0.01)) + self.pillaralpha) / 3)
		love.graphics.setColor(1, 1, 1, alpha + moreAlpha)
		love.graphics.draw(self.pillar, 0, -240, 0, ((self.pillarscale - (0.3 * i)) + (math.sin(sinoff) * 0.1)), 1, ox, -self.height)

		love.graphics.pop()
	end
end

function LightTransition:getLightAlpha()
	local val = 0
	local fader = Game.world.fader
	
	if fader then
		val = fader.alpha * .3
	end
	
	return val
end

function LightTransition:draw(moreAlpha)	
	-- love.graphics.push('all')
	-- love.graphics.scale(1, 0.5)
	-- self.collider:draw(1, 0, 0, 1)
	-- love.graphics.pop()
	super.draw(self)
	
	self:drawLight(self:getLightAlpha())
end

return LightTransition
