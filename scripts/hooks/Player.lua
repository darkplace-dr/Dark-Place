---@class Player
local Player, super = Class("Player", true)

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
		running = false
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
    if Game.world.map.id == "whitespace" then
        if self.walk_speed >= 60 then
    	    Game.world:mapTransition("greyarea", "entry")
        end
    end
end

function Player:interact()
	if self.holding then return false end

    return super:interact(self)
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

return Player