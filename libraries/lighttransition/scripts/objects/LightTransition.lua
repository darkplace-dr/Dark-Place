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
	
	self.layer = 500000
	
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
	
	local kris_only = self.kris_only
    local kris = Mod:getLeader("chara")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
	
	local distance = settings.walk_distance
	local wait = settings.walk_wait
	
	do
		local toY = event.y + self.collider.radius
		
		cutscene:walkTo(kris, event.x + ((kris_only and 0) or distance), toY, wait, 'down', true)
		
		if susie and not self.kris_only then
			cutscene:walkTo(susie, event.x - distance, toY, wait, 'down', true)
		end
	end
	
	cutscene:wait(wait + settings.afterWalk_wait)
	self:afterMoveCallback()
	
	if ralsei and self.ralsei_animation then ralsei:setAnimation("wave_start") end

	cutscene:playSound("dtrans_lw")
	
	-- kris
    kris.visible = false
	local fakeKris = Sprite(kris.actor.path.."../dark_transition/dark", kris.x - 29, kris.y - 86)
	fakeKris.physics.speed_y = settings.fake_speed_y
	fakeKris.physics.gravity = settings.fake_gravity
	fakeKris:setAnimation{"party/kris/dark_transition/dark", 0.1, true}
	fakeKris:setScale(2)
	Game.world:spawnObject(fakeKris, settings.fake_layer)
	
	-- sus
	local fakeSusie
	if susie and not kris_only then
		susie.visible = false
		fakeSusie = Sprite("party/susie/dark_transition/dark", susie.x - 29, susie.y - 86)
		fakeSusie.physics.speed_y = settings.fake_speed_y
		fakeSusie.physics.gravity = settings.fake_gravity
		fakeSusie:setAnimation{"party/susie/dark_transition/dark", 0.1, true}
		fakeSusie:setScale(2)
		Game.world:spawnObject(fakeSusie, settings.fake_layer)
	end
	
	self:beforeFadeCallback()

	cutscene:wait(cutscene:fadeOut(settings.fadeOut_speed, {color = {1, 1, 1}}))
	cutscene:wait(0.75)

	cutscene:loadMap(self.newMap.name, self.newMap.marker, self.newMap.facing)
	self:afterFadeCallback()
	
	fakeKris:remove()
	if fakeSusie then fakeSusie:remove() end
    kris.visible = true
    susie.visible = true
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