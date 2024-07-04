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
	
	self.siner = 0
	
	self.invincible_colors = false
	self.inv_timer = 0
	self.old_song = ""


    local so_gamer = [[
#define OCTAVES 4  // Reduced number of octaves

extern vec2 iResolution;
extern float iTime;

float random (in vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(3.1, 6.1))) * 30.1);
}

float noise (in vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm (in vec2 uv) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;  // Initialize frequency to 1.0

    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(uv * frequency);  // Apply frequency scaling here
        frequency *= 2.0;  // Double the frequency each octave
        amplitude *= 0.5;
    }
    return value;
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = screen_coords / iResolution;

    uv.x *= iResolution.x / iResolution.y;

    vec3 col = 2.3 * 0.5 + cos(iTime * 8 + 10.0 * fbm(uv * 3.14159) + vec3(0, 23, 21));  // Use a constant for pi
    col += fbm(uv * 6.0);

    return Texel(tex, texture_coords) * vec4(col, 1.0) * color;
}

    ]]
    self.so_gamer = love.graphics.newShader(so_gamer)

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
    if self.invincible_colors then
        self:starman()
    end
end

function Player:starman()
	
    if Kristal.Config["simplifyVFX"] == true then
		self.siner = self.siner + DT * 40
		self.inv_timer = self.inv_timer - DT
		self:setColor(Utils.hsvToRgb(((self.siner * 8) % 255)/255, 255/255, 255/255))
		if (self.inv_timer + DT) % 0.125 < self.inv_timer % 0.125 then
			local afterimage = Sprite(self.sprite:getTexture(), self.x - self.sprite:getOffset()[1], self.y - self.sprite:getOffset()[2])
			afterimage:setScale(2, 2)
			afterimage:setOrigin(0.5, 1)
			afterimage:setColor(self.color)
			Game.world:spawnObject(afterimage)
			Game.world.stage.timer:tween(0.5, afterimage, {alpha = 0}, 'linear', function()
                            afterimage:remove()
                        end)
		end
	
	if self.inv_timer <= 0 and self.invincible_colors then
		self.invincible_colors = false
		Game.world.music:play(self.old_song)
		self:setColor(1, 1, 1, 1)
                self:removeFX(66)
	end

    else
        self.siner = self.siner + DT * 40
        self.inv_timer = self.inv_timer - DT

        if not self.shader_applied then
            self:addFX(ShaderFX(self.so_gamer, {
                ["iTime"] = function () return love.timer.getTime() end,
                ["iResolution"] = { love.graphics.getWidth(), love.graphics.getHeight() }
            }), 66)
            self.shader_applied = true
        end

        if (self.inv_timer + DT) % 0.125 < self.inv_timer % 0.125 then
            local afterimage = Sprite(self.sprite:getTexture(), self.x - self.sprite:getOffset()[1], self.y - self.sprite:getOffset()[2])
            afterimage:setScale(2, 2)
            afterimage:setOrigin(0.5, 1)
            -- Apply the shader effect to the afterimage

            local hey_yall = love.timer.getTime()
            afterimage:addFX(ShaderFX(self.so_gamer, {
                ["iTime"] = function () return hey_yall end,
                ["iResolution"] = { love.graphics.getWidth(), love.graphics.getHeight() }
            }))
            Game.world:spawnObject(afterimage)
            Game.world.stage.timer:tween(0.5, afterimage, {alpha = 0}, 'linear', function()
                afterimage:remove()
            end)
        end

        if self.inv_timer <= 0 and self.invincible_colors then
            self.invincible_colors = false
            self:setColor(1, 1, 1, 1)
            self:removeFX(66)
            self.shader_applied = false
            Game.world.music:play(self.old_song)
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
	
	if self.invincible_colors then
		speed = speed * 1.5
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
    bubble:setLayer(WORLD_LAYERS["soul"])
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
