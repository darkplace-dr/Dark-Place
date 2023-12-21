local UnderPlayer, super = Class(Player, "UnderPlayer")

function UnderPlayer:init(chara, x, y)
    super.init(self, chara, x, y)

    self.force_walk = true
    self.walk_speed = 5

end

function UnderPlayer:handleMovement()
    local walk_x = 0
    local walk_y = 0

    local should_turn = true
    if Input.down("left") then
        walk_x = walk_x - 1
        if self.moving_y < 0 and self.facing == "up" then
            should_turn = false
        end
        if self.moving_y > 0 and self.facing == "down" then
            should_turn = false
        end
        if should_turn then
            self.facing = "left"
        end
    elseif Input.down("right") then
        walk_x = walk_x + 1
        if self.moving_y < 0 and self.facing == "up" then
            should_turn = false
        end
        if self.moving_y > 0 and self.facing == "down" then
            should_turn = false
        end
        if should_turn then
            self.facing = "right"
        end
    end

    if Input.down("up") then
        walk_y = walk_y - 1
        if self.moving_x > 0 and self.facing == "right" then
            should_turn = false
        end
        if self.moving_x < 0 and self.facing == "left" then
            should_turn = false
        end
        if should_turn then
            self.facing = "up"
        end
    elseif Input.down("down") then
        walk_y = walk_y + 1
        if self.moving_x > 0 and self.facing == "right" then
            should_turn = false
        end
        if self.moving_x < 0 and self.facing == "left" then
            should_turn = false
        end
        if should_turn then
            self.facing = "down"
        end
    end

    if self.moving_y < 0 and (Input.down("up") and Input.down("down")) then
        self.sprite.facing = "up"
    else
        self.sprite.facing = self.facing
    end
    --self.sprite.facing = self.facing

    self.moving_x = walk_x
    self.moving_y = walk_y

    local running = (Input.down("cancel") or self.force_run) and not self.force_walk
    if Kristal.Config["autoRun"] and not self.force_run and not self.force_walk then
        running = not running
    end

    if self.force_run and not self.force_walk then
        self.run_timer = 200
    end

    local speed = self.walk_speed
    if running then
        if self.run_timer > 60 then
            speed = speed * 2.25
        elseif self.run_timer > 10 then
            speed = speed * 2
        else
            speed = speed * 1.5
        end
    end

    self:move(walk_x, walk_y, speed * DTMULT)

    if not running or self.last_collided_x or self.last_collided_y then
        self.run_timer = 0
    elseif running then
        if walk_x ~= 0 or walk_y ~= 0 then
            self.run_timer = self.run_timer + DTMULT
            self.run_timer_grace = 0
        else
            -- Dont reset running until 2 frames after you release the movement keys
            if self.run_timer_grace >= 2 then
                self.run_timer = 0
            end
            self.run_timer_grace = self.run_timer_grace + DTMULT
        end
    end
end

function UnderPlayer:doMoveAmount(type, amount, other_amount)
    other_amount = other_amount or 0

    if amount == 0 then
        self["last_collided_"..type] = false
        return false, false
    end

    local other = type == "x" and "y" or "x"

    local sign = Utils.sign(amount)
    for i = 1, math.ceil(math.abs(amount)) do
        local moved = sign
        if (i > math.abs(amount)) then
            moved = (math.abs(amount) % 1) * sign
        end

        local last_a = self[type]
        local last_b = self[other]

        self[type] = self[type] + moved

        if (not self.noclip) and (not NOCLIP) then
            Object.startCache()
            local collided, target = self.world:checkCollision(self.collider, self.enemy_collision)
            if collided and not (other_amount > 0) then
                for j = 1, 2 do
                    Object.uncache(self)
                    self[other] = self[other] - j
                    collided, target = self.world:checkCollision(self.collider, self.enemy_collision)
                    if not collided then break end
                end
            end
            if collided and not (other_amount < 0) then
                self[other] = last_b
                for j = 1, 2 do
                    Object.uncache(self)
                    self[other] = self[other] + j
                    collided, target = self.world:checkCollision(self.collider, self.enemy_collision)
                    if not collided then break end
                end
            end
            Object.endCache()

            if collided then
                self[type] = last_a
                self[other] = last_b

                if not target:includes("Event") then
                    if self.moving_y < 0 and (Input.down("up") and Input.down("down")) then
                        self[type] = self[type] + 6
                        self.facing = "down"
                        self.sprite.facing = self.facing
                        --[[
                        if self.facing == "down" then
                            self.sprite.facing = "down"
                        else
                            self.sprite.facing = "up"
                        end
                        --]]
                    end
                end

                if target and target.onCollide then
                    target:onCollide(self)
                end

                self["last_collided_"..type] = true
                return i > 1, target
            end
        end
    end
    self["last_collided_"..type] = false
    return true, false
end

function UnderPlayer:move(x, y, speed, keep_facing)
    local movex, movey = x * (speed or 1), y * (speed or 1)

    local moved = false
    moved = self:moveX(movex, movey) or moved
    moved = self:moveY(movey, movex) or moved

    if moved then
        self.moved = math.max(self.moved, math.max(math.abs(movex) / DTMULT, math.abs(movey) / DTMULT))

        self.sprite.walking = true
        self.sprite.walk_speed = self.moved > 0 and math.max(4, self.moved) or 0
    end

    return moved
end

return UnderPlayer