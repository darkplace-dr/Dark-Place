local Hang, super = Class(Wave, "werewire/hang")

function Hang:init()
    super:init(self)

    self:setArenaPosition(321, 241)
    self:setArenaSize(142, 92)

    self.time = 170/30

    -- IN, SWISH, OUT, DONE
    self.state = "IN"

    self.swisher = 0
    self.attacking = false
end

function Hang:onStart()
    self.enemy = self:getAttackers()[1]

    self.enemy:setAnimation("hang")
end

function Hang:onEnd()
    self.enemy:setAnimation("idle")

    self.enemy:resetPhysics()
    self.enemy:setPosition(self.enemy.target_x, self.enemy.target_y)
end

function Hang:update()
    if self.time - Game.battle.wave_timer <= 20/30 then
        self.enemy:resetPhysics()
        self.state = "OUT"
    end

    if self.state == "IN" then
        local x_done, y_done = false, false

        if self.enemy.y <= Game.battle.arena.top + 15 then
            if not self.attacking then
                self.attacking = true

                self.timer:every(6/30, function()
                    if not self.attacking then return false end

                    local x, y = self.enemy:getRelativePos(self.enemy.width/2, 22)
                    local bullet = self:spawnBullet("werewire/spark", x, y)

                    bullet.tp = 2.4

                    local dx, dy = -3 + Utils.random(6), -9 + Utils.random(2)
                    local angle = Utils.angle(0, 0, dx, dy)
                    local dist = Utils.dist(dx, dy, 0, 0)

                    bullet.rotation = angle
                    bullet.physics.speed = dist
                    bullet.physics.gravity = 0.6
                    bullet.physics.match_rotation = true
                end)
            end

            self.enemy.physics.speed_y = self.enemy.physics.speed_y - (self.enemy.physics.speed_y * 0.5) * DTMULT
            if math.abs(self.enemy.physics.speed_y) <= 1 then
                self.enemy.physics.speed_y = 0
                y_done = true
            end
        else
            self.enemy.physics.speed_y = self.enemy.physics.speed_y - (2 * DTMULT)
        end

        local target_x = Game.battle.arena.x - 16
        if self.enemy.x >= target_x then
            self.enemy.x = self.enemy.x - ((self.enemy.x - target_x) / 12) * DTMULT
            if self.enemy.x <= target_x + 2 then
                self.enemy.x = target_x
                x_done = true
            end
        else
            x_done = true
        end

        if x_done and y_done then
            self.state = "SWISH"
        end
    end

    if self.state == "SWISH" then
        self.swisher = self.swisher + (2 * DTMULT)

        self.enemy.x = self.enemy.x + (math.sin(self.swisher / 12) * 3) * DTMULT
    end

    if self.state == "OUT" then
        self.attacking = false

        self.enemy.y = self.enemy.y - ((self.enemy.y - self.enemy.target_y) / 4) * DTMULT
        if self.enemy.y >= self.enemy.target_y - 4 then
            self.enemy.y = self.enemy.target_y
        end
        self.enemy.x = self.enemy.x - (((self.enemy.x - self.enemy.target_x) / 4) - 1) * DTMULT
        if self.enemy.x >= self.enemy.target_x - 1 then
            self.enemy.x = self.enemy.target_x
        end

        if self.enemy.y == self.enemy.target_y and self.enemy.x == self.enemy.target_x then
            self.state = "DONE"
            self.enemy:setAnimation("idle")
        end
    end

    super:update(self)
end

return Hang