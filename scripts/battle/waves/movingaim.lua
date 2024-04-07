local movingaim, super = Class(Wave)

function movingaim:init()
    super.init(self)
    self.time = 60*2
    -- Initialize timer
    self.siner = 0
end

function movingaim:onStart()
    -- Get the arena object
    local arena = Game.battle.arena

    -- Spawn spikes on top of arena
    self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width/2, 0, math.rad(0))

    -- Spawn spikes on bottom of arena (rotated 180 degrees)
    self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width/2, arena.height, math.rad(180))
    -- Spawn spikes on right of arena
    self:spawnBulletTo(Game.battle.arena, "arenahazard", 0, arena.height-73, math.rad(270))

    -- Spawn spikes on left of arena (rotated 270 degrees)
    self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width, arena.height-73, math.rad(90))
    -- Store starting arena position
    self.arena_start_x = arena.x
    self.arena_start_y = arena.y
    self.timer:every(1/4, function()
        local x, y = (SCREEN_WIDTH/2)+arena.width/2, (SCREEN_HEIGHT/2)+arena.width/2

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)


        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("smallbullet_homing", x, y, angle, 2)
    end)
end

function movingaim:update()
    -- Increment timer for arena movement
    self.siner = self.siner + DT

    -- Calculate the arena Y offset
    local offset = math.sin(self.siner * 1.5) * 60

    -- Move the arena
    Game.battle.arena:setPosition(self.arena_start_x, self.arena_start_y + offset)

    super.update(self)
end

return movingaim