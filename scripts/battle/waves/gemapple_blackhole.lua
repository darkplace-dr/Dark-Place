local GemApple_BlackHole, super = Class(Wave)

function GemApple_BlackHole:init()
    super.init(self)
	self.time = 9
end

function GemApple_BlackHole:onStart()
    self.timer:every(0.75, function()
        local attackers = self:getAttackers()

        for _, attacker in ipairs(attackers) do

            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            local speed = love.math.random(5, 7) + love.math.random()

            self:spawnBullet("gemapple", x, y, angle, speed)
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

function GemApple_BlackHole:update()
    -- Code here gets called every frame
    Game.battle.soul.y = Game.battle.soul.y - (2 * DTMULT)
    if Game.battle.soul.x > SCREEN_WIDTH/2 then
        Game.battle.soul.x = Game.battle.soul.x - (2 * DTMULT)
    else
        Game.battle.soul.x = Game.battle.soul.x + (2 * DTMULT)
    end

    super.update(self)
end

return GemApple_BlackHole