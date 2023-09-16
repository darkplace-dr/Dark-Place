local ErrorMovingArena, super = Class(Wave)

function ErrorMovingArena:init()
    super.init(self)

    -- Initialize timer
    self.siner = 0
end

function ErrorMovingArena:onStart()
    -- Get the arena object
    local arena = Game.battle.arena
	arena.width = arena.width / 1.75
    -- Spawn spikes on top of arena
    self:spawnBulletTo(Game.battle.arena, "errorarenahazard", arena.width/2, 0, math.rad(0))

    -- Spawn spikes on bottom of arena
    self:spawnBulletTo(Game.battle.arena, "errorarenahazard", arena.width/2, arena.height - 34, math.rad(0))

    -- Store starting arena position
    self.arena_start_x = arena.x
    self.arena_start_y = arena.y
	Game.battle.soul.y = Game.battle.soul.y + 20
end

function ErrorMovingArena:update()
    -- Increment timer for arena movement
    self.siner = self.siner + DT

    -- Calculate the arena Y offset
    local offset = math.sin(self.siner * 3) * 60

    -- Move the arena
    Game.battle.arena:setPosition(self.arena_start_x, self.arena_start_y + offset)

    super.update(self)
end

return ErrorMovingArena