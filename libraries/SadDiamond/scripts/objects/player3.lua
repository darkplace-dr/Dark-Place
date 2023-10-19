local Player3, super = Class(Character)

function Player3:init(chara, x, y, other)
    super.init(self, chara, x, y, other)

    self.is_player3 = true

    self.slide_sound = Assets.newSound("paper_surf")
    self.slide_sound:setLooping(true)

    self.state_manager = StateManager("WALK", self, true)
    self.state_manager:addState("WALK", {update = self.updateWalk})
    self.state_manager:addState("SLIDE", {update = self.updateSlide, enter = self.beginSlide, leave = self.endSlide})


    self.force_run = false
    self.force_walk = false
    self.run_timer = 0
    self.run_timer_grace = 0

    self.auto_moving = false

    self.current_slide_area = nil
    self.slide_in_place = false
    self.slide_lock_movement = false
    self.slide_dust_timer = 0
    self.slide_land_timer = 0

    self.hurt_timer = 0

    self.moving_x = 0
    self.moving_y = 0
    self.walk_speed = 9

    self.last_move_x = self.x
    self.last_move_y = self.y

    self.history_time = 0
    self.history = {}

    self.battle_canvas = love.graphics.newCanvas(320, 240)
    self.battle_alpha = 0

    self.persistent = true
    self.noclip = true

    self.outlinefx = self:addFX(BattleOutlineFX())
    self.outlinefx:setAlpha(self.battle_alpha)
end

function Player3:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "State: " .. self.state)
    table.insert(info, "Walk speed: " .. self.walk_speed)
    table.insert(info, "Run timer: " .. self.run_timer)
    table.insert(info, "Hurt timer: " .. self.hurt_timer)
    table.insert(info, "Slide in place: " .. (self.slide_in_place and "True" or "False"))
    return info
end

function Player3:getDebugOptions(context)
    context = super.getDebugOptions(self, context)
    context:addMenuItem("Toggle force run", "why the fuck do you need the camera to run?", function() self.force_run = not self.force_run end)
    context:addMenuItem("Toggle force walk", "i should remove this", function() self.force_walk = not self.force_walk end)
    --                                           But im not gonna cus it funny
    return context
end

function Player3:onAdd(parent)
    super.onAdd(self, parent)

    if parent:includes(World) and not parent.player3 then
        parent.player3 = self
    end
end

function Player3:onRemove(parent)
    super.onRemove(self, parent)

    self.slide_sound:stop()
    if parent:includes(World) and parent.player3 == self then
        parent.player3 = nil
    end
end

function Player3:onRemoveFromStage(stage)
    super.onRemoveFromStage(stage)
    self.slide_sound:stop()
end

function Player3:setActor(actor)
    super.setActor(self, actor)

end

function Player3:setState(state, ...)
    self.state_manager:setState(state, ...)
end

function Player3:isCameraAttachable()
    return not (self.state == "SLIDE" and self.slide_in_place)
end

function Player3:isCamera2Attachable()
    return not (self.state == "SLIDE" and self.slide_in_place)
end

function Player3:isMovementEnabled()
    return not OVERLAY_OPEN
        and not Game.lock_movement
        and not self.slide_lock_movement
        and Game.state == "OVERWORLD"
        and self.world.state == "GAMEPLAY"
        and self.hurt_timer == 0
end

function Player3:handleMovement()
    local move_x = 0
    local move_y = 0


    if Game.world.player_3 and Game.world.player2 and Game.world.player_4 then
        -- Calculate the position halfway between player 1 and player 2
        local mid_x = (Game.world.player.x + Game.world.player2.x + Game.world.player_3.x + Game.world.player_4.x) / 4
        local mid_y = (Game.world.player.y + Game.world.player2.y + Game.world.player_3.y + Game.world.player_4.y) / 4

        -- Set the target player to the midpoint position
        target_player = { x = mid_x, y = mid_y }
    elseif Game.world.player_3 and Game.world.player2 then
        -- Calculate the position halfway between player 1 and player 2
        local mid_x = (Game.world.player.x + Game.world.player2.x + Game.world.player_3.x) / 3
        local mid_y = (Game.world.player.y + Game.world.player2.y + Game.world.player_3.y) / 3

        -- Set the target player to the midpoint position
        target_player = { x = mid_x, y = mid_y }
    elseif Game.world and Game.world.player2 then
        -- Calculate the position halfway between player 1 and player 2
        local mid_x = (Game.world.player.x + Game.world.player2.x) / 2
        local mid_y = (Game.world.player.y + Game.world.player2.y) / 2

        -- Set the target player to the midpoint position
        target_player = { x = mid_x, y = mid_y }
    else
        -- Calculate the position halfway between player 1 and player 2
        local mid_x = (Game.world.player.x) / 1
        local mid_y = (Game.world.player.y) / 1

        -- Set the target player to the midpoint position
        target_player = { x = mid_x, y = mid_y }
    end

    -- Calculate the movement direction based on the target player's position
    local target_x = target_player.x
    local target_y = target_player.y
    local dist_x = target_x - self.x
    local dist_y = target_y - self.y
    local dist_total = math.sqrt(dist_x ^ 2 + dist_y ^ 2)
    if dist_total > 0 then
        local max_speed = 40
        local speed_scale = math.min(dist_total / 100, 1)
        local speed = max_speed * speed_scale

        move_x = dist_x / dist_total * speed
        move_y = dist_y / dist_total * speed
    end

    -- Move the player towards the target player
    self:move(move_x * DTMULT, move_y * DTMULT)

    -- Reset the running timer if the player collides with an object or stops running
    if not self.moving_x or not self.moving_y or self.last_collided_x or self.last_collided_y then
        self.run_timer = 0
    elseif self.moving_x ~= 0 or self.moving_y ~= 0 then
        self.run_timer = self.run_timer + DTMULT
    end

    -- Call the original handleMovement function

end

function Player3:updateWalk()
    if self:isMovementEnabled() then
        self:handleMovement()
    end
end

function Player3:isMoving()
    return self.moving_x ~= 0 or self.moving_y ~= 0
end

function Player3:beginSlide(last_state, in_place, lock_movement)
    self.slide_sound:play()
    self.auto_moving = true
    self.slide_in_place = in_place or false
    self.slide_lock_movement = lock_movement or false
    self.slide_land_timer = 0
    self.sprite:setAnimation("slide")
end
function Player3:updateSlideDust()
    self.slide_dust_timer = Utils.approach(self.slide_dust_timer, 0, DTMULT)

    if self.slide_dust_timer == 0 then
        self.slide_dust_timer = 3

        local dust = Sprite("effects/slide_dust")
        dust:play(1/15, false, function() dust:remove() end)
        dust:setOrigin(0.5, 0.5)
        dust:setScale(2, 2)
        dust:setPosition(self.x, self.y)
        dust.layer = self.layer - 0.01
        dust.physics.speed_y = -6
        dust.physics.speed_x = Utils.random(-1, 1)
    end
end
function Player3:updateSlide()
    local slide_x = 0
    local slide_y = 0

    if self:isMovementEnabled() then
        if Input.down("h") then slide_x = slide_x + 1 end
        if Input.down("f") then slide_x = slide_x - 1 end
        if Input.down("g") then slide_y = slide_y + 1 end
        if Input.down("t") then slide_y = slide_y - 1 end
    end

    if not self.slide_in_place then
        slide_y = 2
    end

    self.run_timer = 50
    local speed = self.walk_speed + 4

    self:move(slide_x, slide_y, speed * DTMULT)

    self:updateSlideDust()
end
function Player3:endSlide(next_state)
    if self.slide_lock_movement then
        self.slide_land_timer = 4
    else
        self.slide_sound:stop()
        self.sprite:resetSprite()
    end
    self.auto_moving = false
end

function Player3:update()
    if self.hurt_timer > 0 then
        self.hurt_timer = Utils.approach(self.hurt_timer, 0, DTMULT)
    end

    if self.slide_land_timer > 0 and self.state ~= "SLIDE" then
        self.slide_land_timer = Utils.approach(self.slide_land_timer, 0, DTMULT)
        if self.slide_land_timer == 0 then
            self.slide_sound:stop()
            self.sprite:resetSprite()
            self.slide_lock_movement = false
        end
    end

    self.state_manager:update()

    self.world.in_battle_area = false
    for _,area in ipairs(self.world.map.battle_areas) do
        if area:collidesWith(self.collider) then
            if not self.world.in_battle_area then
                self.world.in_battle_area = true
            end
            break
        end
    end

    if self.world:inBattle() then
        self.battle_alpha = math.min(self.battle_alpha + (0.04 * DTMULT), 0.8)
    else
        self.battle_alpha = math.max(self.battle_alpha - (0.08 * DTMULT), 0)
    end

    self.outlinefx:setAlpha(self.battle_alpha)

    super.update(self)
end

function Player3:draw()
    -- Draw the player


end

return Player3