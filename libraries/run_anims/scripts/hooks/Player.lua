local Player, super = Class(Player)

function Player:init(...)
    super:init(self, ...)

    self.state_manager:addState("RUN", { update = self.updateRun })
    self.running = false
    self.has_run = false
    if love.filesystem.getInfo(Mod.info.path.."/libraries/run_anims/assets/sprites/"..self.actor.path.."/run") or love.filesystem.getInfo(Mod.info.path.."/assets/sprites/"..self.actor.path.."/run") then
        self.has_run = true
    end
    self.old_xv = 0
    self.old_yv = 0
    self.stay_grace = 0
end

function Player:handleMovement()
    local walk_x = 0
    local walk_y = 0

    if     Input.down("left")  then walk_x = walk_x - 1
    elseif Input.down("right") then walk_x = walk_x + 1 end
    if     Input.down("up")    then walk_y = walk_y - 1
    elseif Input.down("down")  then walk_y = walk_y + 1 end

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

    local members = Utils.merge({Game.world.player}, Game.world.followers)
    local walkers = 0
    for i, member in ipairs(members) do
        if member.state == "WALK" then walkers = walkers + 1 end
    end

    if (self.old_xv == self.x) and (self.old_yv == self.y) and (walkers ~= #members) then self.stay_grace = self.stay_grace + 1 end
    self.old_xv = self.x
    self.old_yv = self.y
    

    if self.stay_grace == 2 then
        if self.state ~= "WALK" then self:setState("WALK") end
        for i, follower in ipairs(Game.world.followers) do
            if follower.state ~= "WALK" then follower.state = "WALK" end
        end
        self:resetFollowerHistory()
        self.stay_grace = 0
    end

    if not running or self.last_collided_x or self.last_collided_y then
        self.run_timer = 0
        if self.state ~= "WALK" then self:setState("WALK") end
        if walk_x == 0 and walk_y == 0 then
            if self.state ~= "WALK" then self:setState("WALK") end
            for i, follower in ipairs(Game.world.followers) do
                if follower.state ~= "WALK" then follower.state = "WALK" end
            end
            self:resetFollowerHistory()
        end

    elseif running then
        if walk_x ~= 0 or walk_y ~= 0 then
            self.run_timer = self.run_timer + DTMULT
            self.run_timer_grace = 0
            if self.state ~= "RUN" then self:setState("RUN") end
        else
            -- Dont reset running until 2 frames after you release the movement keys
            if self.run_timer_grace >= 2 then
                self.run_timer = 0
                if walk_x ~= 0 and walk_y ~= 0 then
                    if self.state ~= "WALK" then self:setState("WALK") end
                    for i, follower in ipairs(Game.world.followers) do
                        if follower.state ~= "WALK" then follower.state = "WALK" end
                    end
                    self:resetFollowerHistory()
                end
            end
            self.run_timer_grace = self.run_timer_grace + DTMULT
        end

    end

end

function Player:updateRun()
    if not self.running then
        self.running = true
    end

    if self.sprite.sprite ~= "run" and self.has_run then
        self:setWalkSprite("run")
    end

    if self:isMovementEnabled() then
        self:handleMovement()
    end

    if Game.world:hasCutscene() or Game.world.menu or Game.battle then
        if self.state ~= "WALK" then self:setState("WALK") end
        for i, follower in ipairs(Game.world.followers) do
            if follower.state ~= "WALK" then follower.state = "WALK" end
        end
        self:resetFollowerHistory()
    end
end

function Player:updateWalk()
    if self.running then
        self.running = false
        self:resetSprite()
    end

    if self:isMovementEnabled() then
        self:handleMovement()
    end

    if Game.world:hasCutscene() or Game.world.menu or Game.battle then
        if self.state ~= "WALK" then self:setState("WALK") end
        for i, follower in ipairs(Game.world.followers) do
            if follower.state ~= "WALK" then follower.state = "WALK" end
        end
        self:resetFollowerHistory()
    end
end

return Player