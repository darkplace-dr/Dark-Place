local DeadlyNeedle, super = Class(Wave)

function DeadlyNeedle:onStart()
	local arenacenter = Game.battle.arena.left + Game.battle.arena.right
	self.x = arenacenter / 2
	if love.math.random(1,2) == 1 then
		self.y = Game.battle.arena.top + 35.5
		self.top = true
	else
		self.y = Game.battle.arena.bottom - 35.5
		self.top = false
	end
	self.timer:script(function(wait)
		wait(1)
		Assets.playSound("mtt_prebomb")
		local bullet = self:spawnBullet("firewarning", self.x, self.y, math.rad(180), 0)
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		bullet:remove()
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		local bullet = self:spawnBullet("firewarning", self.x, self.y, math.rad(180), 0)
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		bullet:remove()
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		local bullet = self:spawnBullet("firewarning", self.x, self.y, math.rad(180), 0)
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		bullet:remove()
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		local bullet = self:spawnBullet("firewarning", self.x, self.y, math.rad(180), 0)
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		bullet:remove()
		wait(0.1)
		Assets.playSound("mtt_prebomb")
		local bullet = self:spawnBullet("firewarning", self.x, self.y, math.rad(180), 0)
		wait(0.1)
		Assets.playSound("spearrise")
		bullet:remove()
		if self.top == true then
			self:spawnBullet("deadlyneedle", SCREEN_WIDTH/2, Game.battle.arena.top, 0, 0)
		else
			self:spawnBullet("deadlyneedle", SCREEN_WIDTH/2, Game.battle.arena.bottom, math.rad(180), 0)
		end

	end)
end

function DeadlyNeedle:update()
    -- Code here gets called every frame

    super.update(self)
end

return DeadlyNeedle
