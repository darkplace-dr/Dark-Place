local DeadlyNeedle, super = Class(Wave)

function DeadlyNeedle:onStart()
	local arenacenter = Game.battle.arena.left + Game.battle.arena.right
	local x = arenacenter / 2
	local y
	local top
	if love.math.random(1,2) == 1 then
		y = Game.battle.arena.top + 35.5
		top = true
	else
		y = Game.battle.arena.bottom - 35.5
		top = false
	end

	self.timer:script(function(wait)
		wait(1)
		local function warn(times)
			for i = 1, times do
				local last = i == times
				Assets.playSound("mtt_prebomb")
				local bullet = self:spawnBullet("firewarning", x, y, math.rad(180), 0)
				wait(0.1)
				Assets.playSound(not last and "mtt_prebomb" or "spearrise")
				bullet:remove()
				if not last then
					wait(0.1)
				end
			end
		end
		warn(5)
		if top then
			self:spawnBullet("deadlyneedle", SCREEN_WIDTH/2, Game.battle.arena.top, 0, 0)
		else
			self:spawnBullet("deadlyneedle", SCREEN_WIDTH/2, Game.battle.arena.bottom, math.rad(180), 0)
		end
	end)
end

return DeadlyNeedle
