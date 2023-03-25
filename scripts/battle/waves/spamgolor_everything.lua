local Spamgolor_Everything, super = Class(Wave)

function Spamgolor_Everything:init()
    super:init(self)
	self.time = 9
end

function Spamgolor_Everything:onStart()
    self.timer:every(0.75, function()
        local attackers = self:getAttackers()

        for _, attacker in ipairs(attackers) do

            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            local speed = math.random(5, 7) + math.random()

            self:spawnBullet("gemapple", x, y, angle, speed)
        end
    end)
    local arenacenter = Game.battle.arena.left + Game.battle.arena.right
	self.x = arenacenter / 2
	if math.random(1,2) == 1 then
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
	self:spawnBullet("blackhole", SCREEN_WIDTH/2, 40, 0, 0)
    self.timer:every(1/2, function()
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local y = SCREEN_HEIGHT + 20

        local angle = Utils.angle(x, y, SCREEN_WIDTH/2, 50)

        local bullet = self:spawnBullet("smallbullet_bh", x, y, angle, 6)
        bullet.remove_offscreen = false
    end)
end

function Spamgolor_Everything:update()
    -- Code here gets called every frame
	Game.battle.soul.y = Game.battle.soul.y - (2 * DTMULT)
    if Game.battle.soul.x > SCREEN_WIDTH/2 then
        Game.battle.soul.x = Game.battle.soul.x - (2 * DTMULT)
    else
        Game.battle.soul.x = Game.battle.soul.x + (2 * DTMULT)
    end

    super.update(self)
end

return Spamgolor_Everything