local PlugSpark, super = Class(WorldBullet, "hangplug/spark")

function PlugSpark:init(x, y, damage, dist, buffed)
    super:init(self, x, y)

    self:setScale(1, 1)

    self:setHitbox(-13-3, -13-3, 26+3, 26+3)

    self.debug_rect = {-13, -13, 26, 26}

    self.damage = damage or 18

    self.start_x = self.x
    self.start_y = self.y

    self.distance = dist or 160
    self.buffed = buffed or false

    self.flash_timer = 0
    self.scaler = 0.25
    self.afterimg_timer = 0

    -- IDLE, FALLING
    self.state = "IDLE"
end

function PlugSpark:update()
    self.scaler = Utils.lerp(self.scaler, 1, 0.25 * DTMULT)

    self.afterimg_timer = self.afterimg_timer + DTMULT
    if self.afterimg_timer >= 1 then
        self.afterimg_timer = self.afterimg_timer - 1

        local afterimg = Sprite("world/bullets/hangplug/spark", self.x, self.y)
        afterimg:setOrigin(0.5, 0.5)
        afterimg:setScale(2, 2)
        afterimg:fadeOutAndRemove()
        afterimg.graphics.grow = -0.2
        afterimg.graphics.remove_shrunk = true
        afterimg.rotation = math.rad(33 * love.math.random(0, 8))
        afterimg.alpha = 0.8
        afterimg.layer = self.layer - 1
        afterimg.debug_select = false
        self.world:addChild(afterimg)
    end

    if self.state == "IDLE" then
        self.flash_timer = self.flash_timer + DTMULT
        if self.flash_timer < 15 then
            self.alpha = math.abs(math.cos(self.flash_timer / 2))
        else
            self.alpha = 1
            self.physics.speed_y = 0.1
            Assets.playSound("ultraswing", 0.6, 2)
            self.state = "FALLING"
        end
    end
    if self.state == "FALLING" then
        self.physics.speed_y = self.physics.speed_y + (self.physics.speed_y * (self.buffed and 0.6 or 0.5)) * DTMULT
        self.physics.speed_y = Utils.clamp(self.physics.speed_y, 0, self.buffed and 18 or 14)

        if self.y >= self.start_y + self.distance then
            self.y = self.start_y + self.distance

            Assets.playSound("battleenter", 0.3, 1.5)

            self.world:spawnBullet("hangplug/wave", self.x, self.y + 10, "left", self.damage)
            self.world:spawnBullet("hangplug/wave", self.x, self.y + 10, "right", self.damage)

            self:remove()
            return
        end
    end

    super:update(self)
end

function PlugSpark:draw()
    local amount = (self.y / (self.start_y + 190))

    local textures = Assets.getFramesOrTexture("world/bullets/hangplug/spark")

    local tex_w, tex_h = textures[1]:getDimensions()
    local shadow_x, shadow_y = 0, (self.distance - (self.y - self.start_y))

    love.graphics.setColor(1, 1, 1, amount / 4)
    love.graphics.ellipse("fill", shadow_x, shadow_y, tex_w * amount, 6 * amount)

    love.graphics.setColor(1, 1, 1, 0.4 * self.alpha)
    for i = 1, 5 do
        love.graphics.draw(Utils.pick(textures), 0, 0, math.rad(33 * love.math.random(0, 8)), 2 * self.scaler, 2 * self.scaler, tex_w / 2, tex_h / 2)
    end

    love.graphics.setColor(1, 1, 1)

    super:draw(self)
end

return PlugSpark