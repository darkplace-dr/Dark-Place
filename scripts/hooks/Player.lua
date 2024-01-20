---@class Player
local Player, super = Class("Player", true)

function Player:init(...)
    super.init(self, ...)

    self.state_manager:addState("HOP", {enter = self.beginHop, update = self.updateHop, leave = self.endHop})
end

function Player:update()
    -- Holding run with the Pizza Toque equipped (or if the file name is "PEPPINO") will cause a gradual increase in speed.
    local toque_equipped = false
    for _,party in ipairs(Game.party) do
        if party:checkArmor("pizza_toque") then toque_equipped = true end
    end
    local player_name = Game.save_name:upper()
    if Game.world.map.id ~= "everhall" and Game.world.map.id ~= "everhall_entry" and toque_equipped == true or player_name == "PEPPINO" then
        if self.run_timer > 60 then
            self.walk_speed = self.walk_speed + DT
        elseif self.walk_speed > 4 then
            self.walk_speed = 4
        end
    end

    super.update(self)
	
	if Kristal.getLibConfig("pickup_lib", "disable_hold_run") and self.holding then
        -- dobby: This would've'nt even work since running is a local variable of the parent function
		--running = false
		self.run_timer = 0
	end

    -- Hitting a wall at a speed of 10 or higher will do a small collision effect
    if toque_equipped or player_name == "PEPPINO" then
        if self.last_collided_x or self.last_collided_y then
            if self.walk_speed >= 10 then
                Game.world.player:shake(4, 0)
                Assets.playSound("wing")
            end
        end
    end

    --haha backroom go brrrrrrr
    if Game.world.map.id == "whitespace" or Game.world.map.id == "blackspace" then
        if self.walk_speed >= 60 then
    	    Game.world:mapTransition("greyarea", "entry")
        end
    end
    if Game.world.map.id == "greyarea" then
        if self.walk_speed >= 60 then
    	    Game.world:mapTransition("room1", "spawn")
        end
    end
end

function Player:interact()
	if self.holding then return false end

    return super.interact(self)
end

function Player:updateWalk()
    super.updateWalk(self)

    if not self:isMovementEnabled() then return end

    if Input.pressed("a") and (self.actor.id == "YOU" or self.actor.id == "YOU_lw") and Mod.can_croak ~= false then
        self:croak()
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