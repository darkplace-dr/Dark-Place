local GasterBlaster, super = Class(Bullet)

function GasterBlaster:init(x, y, rot, target_x, target_y, target_rot, wait_time, blast_time, play_sound)
    self.sprite = Sprite("battle/bullets/gaster_blaster")

    play_sound = play_sound or true
    if play_sound then Assets.stopAndPlaySound("gaster_blaster", 0.8, 1.2) end

    Object.init(self, x or 0, y or 0, self.sprite.width, self.sprite.height)
    self.origin_x = 0.5
    self.origin_y = 0.5
    self.scale_x = 2
    self.scale_y = 2
    self.rotation = math.rad(rot or 0)

    self.target_x = target_x or self.x
    self.target_y = target_y or self.y
    self.target_rot = target_rot or self.rotation

    self.wait_time = wait_time or 8
    self.blast_time = blast_time or 10

    self.blast_size = 0
    self.blast_timer = 0

    self.state = 0

    self.fade = 1

    self.collider = nil

    self:addChild(self.sprite)

    self.layer = BATTLE_LAYERS["bullets"]

    self.tp = 1.6
    self.time_bonus = 1

    -- Originally 1 but I left it at nil because no KR + see Bullet @ Line 29
    -- KR value is 10 in case you need it
    self.damage = nil
    self.inv_timer = (4/3)
    self.destroy_on_hit = false

    self.grazed = false

    self.remove_offscreen = false
end

function GasterBlaster:update()
    Object.update(self)

    if self.state == 0 then
        self.x = self.x + math.floor((self.target_x - self.x) / 3.0) * DTMULT
        self.y = self.y + math.floor((self.target_y - self.y) / 3.0) * DTMULT

        if self.x < self.target_x then self.x = self.x + DTMULT end
        if self.y < self.target_y then self.y = self.y + DTMULT end
        if self.x > self.target_x then self.x = self.x - DTMULT end
        if self.y > self.target_y then self.y = self.y - DTMULT end

        if math.abs(self.x - self.target_x) < 3 then self.x = self.target_x end
        if math.abs(self.y - self.target_y) < 3 then self.y = self.target_y end

        local rotation_degrees = math.deg(self.rotation)
        rotation_degrees = rotation_degrees + math.floor((self.target_rot - rotation_degrees) / 3.0) * DTMULT

        if rotation_degrees < self.target_rot then rotation_degrees = rotation_degrees + DTMULT end
        if rotation_degrees > self.target_rot then rotation_degrees = rotation_degrees - DTMULT end

        if math.abs(self.target_rot - rotation_degrees) < 3 then rotation_degrees = self.target_rot end

        if
            math.abs(self.x - self.target_x) < 0.1 and
            math.abs(self.y - self.target_y) < 0.1 and
            math.abs(rotation_degrees - self.target_rot) < 0.01
        then
            self.state = 1
        end

        self.rotation = math.rad(rotation_degrees)
    end

    if self.state == 1 or self.state == 2 then
        if self.wait_time <= 0 then
            if self.state == 1 then
                self.wait_time = 3
                self.sprite:play(1/15, false)
            else
                self.sprite:setSprite({"battle/bullets/gaster_blaster_5", "battle/bullets/gaster_blaster_6"})
                self.sprite:play(1/15, true)
            end

            self.state = self.state == 1 and 2 or 3
        else
            self.wait_time = self.wait_time - DTMULT
        end
    end

    if self.state == 3 then
        if self.blast_timer == 0 then
            self.physics.direction = self.rotation - math.rad(90)
            Assets.stopAndPlaySound("gaster_blast", 0.8, 1.2)
            Assets.stopAndPlaySound("gaster_blast2", 0.6, 1.2)

            self.collider = Hitbox(self, 0, 0)

            if self.scale_x >= 2 then Game.battle:shakeCamera(5) end
        end

        self.blast_timer = self.blast_timer + DTMULT

        if self.blast_timer < 5 then
            self.physics.speed = self.physics.speed + DTMULT
            self.blast_size = self.blast_size + math.floor((35 * self.scale_x) / 4) * DTMULT
        else
            self.physics.speed = self.physics.speed + 4 * DTMULT
        end

        if self.blast_timer > self.blast_time then
            self.blast_size = self.blast_size * math.pow(0.8, DTMULT)

            self.fade = self.fade - 0.1 * DTMULT

            if self.fade <= 0.8 then self.collider = nil end
            if self.blast_size <= 2 then self:remove() end
        end

        if self.x < -self:getScaledWidth() then self.physics.speed = 0 end
        if self.x > SCREEN_WIDTH + self:getScaledWidth() then self.physics.speed = 0 end
        if self.y > SCREEN_HEIGHT + self:getScaledHeight() then self.physics.speed = 0 end
        if self.y < -self:getScaledHeight() then self.physics.speed = 0 end
    end
end

function GasterBlaster:draw()
    Draw.setColor(1, 1, 1, self.fade)

    local laser_siner = (math.sin(self.blast_timer / 1.5) * self.blast_size) / 8

    local rr = math.random(2) - math.random(2)
    local rr2 = math.random(2) - math.random(2)

    love.graphics.setLineWidth((self.blast_size + laser_siner) / 2)
    local y = 35 * self.scale_x
    love.graphics.line(self.width / 2 + rr, y + rr2, self.width / 2 + rr, 1000 + rr2)

    love.graphics.setLineWidth(((self.blast_size / 1.25) + laser_siner) / 2)
    local y2 = 30 * self.scale_x
    love.graphics.line(self.width / 2 + rr, y + rr2, self.width / 2 + rr, y2 + rr2)

    love.graphics.setLineWidth(((self.blast_size / 2) + laser_siner) / 2)
    local y3 = 25 * self.scale_x
    love.graphics.line(self.width / 2 + rr, y2 + rr2, self.width / 2 + rr, y3 + rr2)

    if self.collider then
        self.collider.width = (self.blast_size * 3) / 8
        self.collider.height = 1000
        self.collider.x = self.width / 2 - self.collider.width / 2
        self.collider.y = y
    end

    Draw.setColor()

    super.draw(self)
end

return GasterBlaster