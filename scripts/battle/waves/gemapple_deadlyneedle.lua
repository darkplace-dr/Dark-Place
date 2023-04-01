local GemApple_DeadlyNeedle, super = Class(Wave)

function GemApple_DeadlyNeedle:init()
    super:init(self)
	self.time = 9
end

function GemApple_DeadlyNeedle:onStart()
    self.timer:every(0.75, function()
        local attackers = self:getAttackers()

        for _, attacker in ipairs(attackers) do

            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            local speed = love.math.random(5, 7) + love.math.random()

            self:spawnBullet("gemapple", x, y, angle, speed)
        end
    end)
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

function GemApple_DeadlyNeedle:update()
    -- Code here gets called every frame

    super.update(self)
end

return GemApple_DeadlyNeedle