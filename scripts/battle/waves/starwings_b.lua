local StarWingsB, super = Class(Wave)

function StarWingsB:init()
    super.init(self)

    -- Initialize timer
    self.time = love.math.random(10,60)
    self.starwalker = self:getAttackers()[1]
    self.siner = 0
    self.timescale = 4
end

function StarWingsB:onStart()
    -- Get the arena object
    local arena = Game.battle.arena

    -- Spawn spikes on top of arena
    --self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width/2, 0, math.rad(0))

    -- Spawn spikes on bottom of arena (rotated 180 degrees)
    --self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width/2, arena.height, math.rad(180))

    -- Store starting arena position
    self.arena_start_x = arena.x
    self.arena_start_y = arena.y


    self.encounter:setMode("shoot")
    self.timer:every(1, function ()
        self.starwalker.sprite:set("starwalker_shoot_1")
        Assets.playSound("wing")

        self.timer:after(0.5, function ()
            self.starwalker.sprite:set("starwalker_shoot_2")
            Assets.playSound("stardrop")
            for i = -1, 1 do
                local offset = i * 15
                local star = self:spawnBullet("battle/bullets/star", self.starwalker.x - 20, self.starwalker.y - 40)
                star.physics.direction = math.atan2(Game.battle.soul.y - star.y, Game.battle.soul.x - star.x) + math.rad(offset)
                star.physics.speed = 6
            end
        end)
        self.timer:after(1, function ()
            self.starwalker.sprite:set("wings")
        end)
    end)
end

function StarWingsB:onEnd()
    self.encounter:setMode("normal")
    self.starwalker.sprite:set("wings")
    super.onEnd()
end

function StarWingsB:update()
    -- Increment timer for arena movement
    self.siner = self.siner + DT

    -- Calculate the arena Y offset
    local offset = math.sin(self.siner * 1.5) * 60

    -- Move the arena
    Game.battle.arena:setPosition(self.arena_start_x, self.arena_start_y + offset)

    super.update(self)
end

return StarWingsB