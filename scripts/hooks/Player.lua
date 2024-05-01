---@class Player
local Player, super = Class("Player", true)

function Player:init(...)
    super.init(self, ...)

    self.state_manager:addState("RUN", { update = self.updateRun })
    self.running = false
    self.has_run = false
    local has_run, _ = self.sprite:isDirectional(self.sprite:getPath("run"))
    self.has_run = has_run

    self.old_xv = 0
    self.old_yv = 0
    self.stay_grace = 0

    self.state_manager:addState("HOP", { enter = self.beginHop, update = self.updateHop, leave = self.endHop })
end

function Player:setActor(...)
    super.setActor(self, ...)

    local has_run, _ = self.sprite:isDirectional(self.sprite:getPath("run"))
    self.has_run = has_run
end

function Player:update()
	if Kristal.getLibConfig("pickup_lib", "disable_hold_run") and self.holding then
        -- dobby: This would've'nt even work since running is a local variable of the parent function
		self.run_timer = 0
        if self.state == "RUN" then self:setState("WALK") end
        for _, follower in ipairs(self.world.followers) do
            if follower:getTarget() == self and follower.state == "RUN" then
                follower.state_manager:setState("WALK")
            end
        end
        self:resetFollowerHistory()
	end

    -- Holding run with the Pizza Toque equipped (or if the file name is "PEPPINO")
    -- will cause a gradual increase in speed.
    if Mod:isTauntingAvaliable()
        and (self.world.map.id ~= "everhall" and self.world.map.id ~= "everhall_entry") then
        if self.run_timer > 60 then
            self.walk_speed = self.walk_speed + DT
        elseif self.walk_speed > 4 then
            self.walk_speed = 4
        end
    end

    super.update(self)

    -- Hitting a wall at a speed of 10 or higher will do a small collision effect
    if Mod:isTauntingAvaliable() then
        if self.last_collided_x or self.last_collided_y then
            if self.walk_speed >= 10 then
                self.world.player:shake(4, 0)
                Assets.playSound("wing")
            end
        end
    end

    --haha backroom go brrrrrrr
    if self.world.map.id == "whitespace" or self.world.map.id == "blackspace" then
        if self.walk_speed >= 60 then
    	    self.world:mapTransition("greyarea", "entry")
        end
    end
    if self.world.map.id == "greyarea" then
        if self.walk_speed >= 60 then
    	    self.world:mapTransition("room1", "spawn")
        end
    end
end

function Player:interact()
	if self.holding then return false end

    return super.interact(self)
end

-- from run_anims
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

    local followers = Utils.filter(self.world.followers, function(member)
        return member:getTarget() == self
    end)
    local members = Utils.merge({self}, followers)
    local walkers = 0
    for _, member in ipairs(members) do
        if member.state == "WALK" then walkers = walkers + 1 end
    end

    local function returnToWalk()
        if self.state == "RUN" then self:setState("WALK") end
        for _, follower in ipairs(followers) do
            if follower.state == "RUN" then
                follower.state_manager:setState("WALK")
            end
        end
        self:resetFollowerHistory()
    end

    if self.old_xv == self.x and self.old_yv == self.y and walkers ~= #members then
        self.stay_grace = Utils.approach(self.stay_grace, 2, DTMULT)
    end
    self.old_xv = self.x
    self.old_yv = self.y

    if self.stay_grace == 2 then
        returnToWalk()
        self.stay_grace = 0
    end

    if not running or self.last_collided_x or self.last_collided_y then
        self.run_timer = 0
        returnToWalk()
    elseif running then
        if walk_x ~= 0 or walk_y ~= 0 then
            self.run_timer = self.run_timer + DTMULT
            self.run_timer_grace = 0

            if self.state == "WALK" then
                self:setState("RUN")
            end
            for _, follower in ipairs(followers) do
                if follower.state == "WALK" then
                    follower.state_manager:setState("RUN")
                end
            end
        else
            -- Dont reset running until 2 frames after you release the movement keys
            if self.run_timer_grace >= 2 then
                self.run_timer = 0
                returnToWalk()
            end
            self.run_timer_grace = self.run_timer_grace + DTMULT
        end
    end
end

function Player:updateWalk()
    if self.running then
        self.running = false
        self:resetSprite()
    end

    super.updateWalk(self)

    if not self:isMovementEnabled() then return end

    if Input.pressed("a") and (self.actor.id == "YOU" or self.actor.id == "YOU_lw") and Mod.can_croak ~= false then
        self:croak()
    end
end

function Player:updateRun()
    if self.world:hasCutscene() or self.world.menu or Game.battle then
        self:setState("WALK")
        for _, follower in ipairs(self.world.followers) do
            if follower:getTarget() == self and follower.state == "RUN" then
                follower.state_manager:setState("WALK")
            end
        end
        self:resetFollowerHistory()
        return
    end

    if not self.running then
        self.running = true
    end

    if self.has_run and self.sprite.sprite ~= "run" then
        self:setWalkSprite("run")
    end

    if self:isMovementEnabled() then
        self:handleMovement()
    end
end

function Player:croak()
    Assets.stopAndPlaySound("croak", nil, 0.8 + Utils.random(0.4))

    local bubble = Sprite("croak", nil, nil, nil, nil, "party/you")
    bubble:setOriginExact(60, 23) -- center??
    bubble:setPosition(self.width/2 + 2.5, -20.5)
    bubble.physics.speed_y = -0.8
    bubble:fadeOutSpeedAndRemove(0.065)
    self:addChild(bubble)
end

function Player:beginHop(last_state, tx, ty, hop_time, hop_height)
    self.auto_moving = true
    Assets.playSound("smalljump")
    self.hop_timer = 0
    self.hop_walk_speed = self.sprite.walk_speed
    self.hop_start_x = self.x
    self.hop_start_y = self.y
    self.hop_target_x = tx or self.x
    self.hop_target_y = ty or self.y
    self.hop_speed = hop_time or 0.5
    self.hop_height = hop_height or 20
end
function Player:updateHop()
    self.hop_timer = self.hop_timer + DT

    self.x = Utils.lerp(self.hop_start_x, self.hop_target_x, self.hop_timer / self.hop_speed)
    self.y = Utils.lerp(self.hop_start_y, self.hop_target_y, self.hop_timer / self.hop_speed)

    local half_hop = self.hop_speed / 2
    if self.hop_timer < half_hop then
        self.sprite.y = Utils.ease(0, -self.hop_height, self.hop_timer / half_hop, "out-cubic")
    elseif self.hop_timer < self.hop_speed then
        self.sprite.y = Utils.ease(-self.hop_height, 0, (self.hop_timer - half_hop) / half_hop, "in-cubic")
    end

    self.moved = math.max(4, self.hop_walk_speed)

    --self:moveCamera(100)

    if self.hop_timer >= self.hop_speed then
        self:setState("WALK")
    end
end
function Player:endHop()
    self.auto_moving = false
    self.x = self.hop_target_x
    self.y = self.hop_target_y
    self.sprite.y = 0
end

return Player