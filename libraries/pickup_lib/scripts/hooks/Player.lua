local Player, super = Class("Player", true)

-- dobby: there is a bit for disable_hold_run in the base hook
--[[function Player:handleMovement()
    local walk_x = 0
    local walk_y = 0

    if Input.down("right") then walk_x = walk_x + 1 end
    if Input.down("left") then walk_x = walk_x - 1 end
    if Input.down("down") then walk_y = walk_y + 1 end
    if Input.down("up") then walk_y = walk_y - 1 end

    self.moving_x = walk_x
    self.moving_y = walk_y

    local running = (Input.down("cancel") or self.force_run) and not self.force_walk
    if Kristal.Config["autoRun"] and not self.force_run and not self.force_walk then
        running = not running
    end

    if self.force_run and not self.force_walk then
        self.run_timer = 200
    end
	
	if Kristal.getLibConfig("pickup_lib", "disable_hold_run") and self.holding then
		running = false
		self.run_timer = 0
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
]]

function Player:interact()
	if self.holding then return false end
	
    return super.interact(self)
end

return Player