local MyWave, super = Class(Wave)

function MyWave:init()
    super.init(self)
	
	self.time = 8
	self.waves = {}
    self.enemies = self:getAttackers()
	self.layer = self.enemies[1].layer - 1
	
	for idx, enemy in ipairs(self.enemies) do
		enemy.idx = idx
	end
end

local function spawnNote(self, wave, enemy)
	-- local enemy = self.enemy
	
	local x, y = enemy.x - 28, enemy.y - 24
	
	local bullet = self:spawnBullet("shadowmen/note", x, y)
	bullet.curve = wave.curve
end

local function generateWave(self, enemy)
	-- local enemy = self.enemy
	local wave = {}
	
	local soul = Game.battle.soul
	local arena = Game.battle.arena
	
	local x, y = enemy.x - 64, enemy.y - 24
	
	local midY = arena:getTop() - 256
	
	if soul.y <= arena.y then
		midY = arena:getBottom() + 160
	end
	
	if enemy.idx % 2 == 0 then
		midY = arena:getBottom() + 160
		
		if soul.y <= arena.y then
			midY = arena:getTop() - 256
		end
	end
	
	wave.curve = love.math.newBezierCurve{
		x, y,
		x - 32, arena:getTop(),
		arena:getRight(), soul.y,
		soul.x, soul.y,
		soul.x - 32, soul.y,
		soul.x - 64, arena:getBottom() + 80,
		soul.x - 128, arena:getBottom() + 64,
		128, midY,
		0, 180,
	}
	
	wave.derivative = wave.curve:getDerivative()
	
	wave.segment = 0.1
	wave.segments = {}
	
	self.timer:script(function(wait)
		wait(0.03)
        Assets.playSound("spearappear")
		
		local seg = wave.curve:renderSegment(0, 0.1, 10)
		seg.color = {1, 0, 0, 1}
		
		table.insert(wave.segments, seg)
		self.timer:tween(0.25, seg, {color = {0.5, 0.5, 0.5}})
	
		wait(0.03)
		
		while wave.segment < 1 do
			if wave.segment + 0.1 <= 1 then
				local seg = wave.curve:renderSegment(wave.segment, wave.segment + 0.1, 10)
				seg.color = {1, 0, 0, 1}
				self.timer:tween(0.25, seg, {color = {0.5, 0.5, 0.5, 1}})
	
				table.insert(wave.segments, seg)
			end
			
			wave.segment = wave.segment + 0.1
			
			if wave.segment > 1 then
				wave.segment = 1
			end
			
			wait(0.03)
		end
		
		wait(0.03)
			
		for i = 1, 9 do
			spawnNote(self, wave, enemy)
			wait(0.05)
		end

		for k,seg in ipairs(wave.segments) do
			self.timer:tween(1, seg, {color = {0.5, 0.5, 0.5, 0}}, nil, function()
				table.remove(wave.segments, k)
			end)
		end
		
		wait(1)
		collectgarbage()
		
		for k,v in ipairs(self.waves) do
			if v == wave then
				table.remove(self.waves, k)
				break
			end
		end
		
		generateWave(self, enemy)
	end)
	
	table.insert(self.waves, wave)
end

function MyWave:onStart()
	local arena = Game.battle.arena
	arena.layer = arena.layer - 600
	
	for _, enemy in ipairs(self.enemies) do
		enemy:setAnimation('play')
	end
	
	-- self.enemy:setAnimation('play')
	self.timer:script(function(wait)
		local idx = 1
		
		while idx <= #self.enemies do
			local enemy = self.enemies[idx]
			generateWave(self, enemy)
			
			idx = idx + 1
			wait(1)
		end
	end)
	-- for _, enemy in ipairs(self.enemies) do
		-- enemy:setAnimation('play')
		-- generateWave(self, enemy)
	-- end
end

local function drawCurve(wave)
	local curve = wave.curve
	local derivative = wave.derivative
	
	if not curve then return end
	
	love.graphics.push()

	love.graphics.setLineWidth(1)
	
	local segmentCount = #wave.segments
	
	for k,segment in ipairs(wave.segments) do
		local maxDiv = k * .85
		local div = 3 + maxDiv
		
		if maxDiv > 5 then
			maxDiv = 5
		end
		
		love.graphics.setColor(segment.color)
		
		love.graphics.translate(0, -(div * 4.8))
		
		for i = 1, 5 do
			love.graphics.translate(0, div)
			love.graphics.line(segment)
			
			if i == 1 then
				love.graphics.line(segment[1], segment[2], segment[1], segment[2] + (div * 4))	
			end
		end
	end
		
	love.graphics.pop()
end

function MyWave:draw()
	super:draw(self)

	for k,wave in ipairs(self.waves) do
		drawCurve(wave)
	end
end

function MyWave:onEnd()
	for _, enemy in ipairs(self.enemies) do
		enemy:setAnimation('idle')
	end
end

return MyWave