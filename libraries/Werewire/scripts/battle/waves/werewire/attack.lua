local Attack, super = Class(Wave, "werewire/attack")

function Attack:init()
    super:init(self)

    self.time = 7
end

function Attack:onStart()
    self.attacking = {}
    self.attacker_id = {}

    for i, attacker in ipairs(self:getAttackers()) do
        self.attacker_id[attacker] = i
        self:queueAttack(Utils.random(5/30) + ((i - 1) % 4), attacker)
    end
end

function Attack:onEnd()
    for _, attacker in ipairs(self:getAttackers()) do
        if attacker.anim ~= "idle" then
            attacker:setAnimation("idle")
        end
    end
end

function Attack:canEnd()
    for _, attacker in ipairs(self:getAttackers()) do
        if self.attacking[attacker] then
            return false
        end
    end
    return true
end

function Attack:queueAttack(time, attacker)
    self.timer:after(time, function()
        if self.finished then return end

        --self:doAttack(attacker, Utils.pick{"throw", "shoot"})
        self:doAttack(attacker, Utils.pick{"shoot", "throw"}, function()
            local attackers = math.min(#self:getAttackers(), 4)
            local next_attack_time = ((attackers * 6/30) + Utils.random(7/30)) * attackers

            self:queueAttack(next_attack_time, attacker)
        end)
    end)
end

function Attack:doAttack(attacker, type, after)
    self.attacking[attacker] = true

    local attacker_x, attacker_y = attacker:getRelativePos(0, 0)

    if type == "shoot" then
        attacker:setAnimation({"attack_shoot", 2/30, false, frames={"1-4"}}, function()
            Assets.playSound("electric_talk", 1, 1.5)

            self.timer:everyInstant(5/30, function()
                local laser_x, laser_y = attacker_x - 52, attacker_y + 18 + 32
                local laser_angle = Utils.angle(laser_x, laser_y, Game.battle.soul.x, Game.battle.soul.y)
                for i = 1, 3 do
                    local angle = laser_angle + math.rad(-5 + ((i - 1) * 5)) + math.rad(Utils.random(4))
                    local spin = math.rad((i - 2) * 1.6)

                    local laser = self:spawnBullet("werewire/laser_circle", laser_x, laser_y, 4, 4, 0.2, angle, spin)
                    laser.attacker = attacker
                end
            end, 3)

            -- shoot lasers
            self.timer:after(15/30, function()
                attacker:setAnimation({"attack_shoot", 2/30, false, frames={"5-10"}}, function()
                    self.attacking[attacker] = false
                    attacker:setAnimation("idle")

                    if after then
                        after()
                    end
                end)
            end)
        end)
    elseif type == "throw" then
        local throw_positions = {
            {-24, -54},
            {-40, -30},
            {-48,   6},
            {-46,  46},
            {-26,  72}
        }

        local throw_angle = Utils.angle(attacker_x + throw_positions[2][1], attacker_y + throw_positions[2][2] + 32,
                                        Game.battle.soul.x, Game.battle.soul.y)
        throw_angle = throw_angle + math.rad(Utils.random(20))

        attacker:setSprite("attack_throw")
        self.timer:after(7.5/30, function()
            local throw_bullets = {}

            self.timer:after(4/30, function()
                Assets.playSound("motor_swing_down")

                self.timer:everyInstant(1/30, function()
                    for i = 1, 2 do
                        if #throw_bullets < #throw_positions then
                            local throw_i = #throw_bullets + 1

                            local angle = (throw_angle + math.rad(28)) - ((throw_i - 1) * math.rad(14))
                            local bullet = self:spawnBullet("werewire/spark", attacker_x + throw_positions[throw_i][1], attacker_y + throw_positions[throw_i][2] + 32)

                            bullet.rotation = angle

                            bullet.physics.speed = 9 - (self.attacker_id[attacker] - 1)
                            bullet.physics.friction = 1
                            bullet.physics.match_rotation = true

                            table.insert(throw_bullets, bullet)
                        end
                    end
                end, 3)
            end)

            attacker:setAnimation({"attack_throw", 2/30, false}, function()
                self.attacking[attacker] = false
                attacker:setAnimation("idle")

                for _,bullet in ipairs(throw_bullets) do
                    if bullet.physics.speed <= 0 then
                        bullet.physics.speed = 0.2
                    end
                    bullet.physics.friction = -0.25
                end

                if after then
                    after()
                end
            end)
        end)
    end
end

function Attack:update()
    super:update(self)


end

return Attack