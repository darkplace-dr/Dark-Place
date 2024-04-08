local LightRudeBusterBeam, super = Class(Sprite, "LightRudeBusterBeam")

function LightRudeBusterBeam:init(red, x, y, tx, ty, after)
    super.init(self, red and "effects/rudebuster/beam_red" or "effects/rudebuster/beam", x, y)

    self:setOrigin(0.5, 0.5)
    self:setScale(4.5)

    self:play(1/30, true)

    self.target_x = tx
    self.target_y = ty
    self.red = red

    self.rotation = math.rad(-10)
    self.physics.speed = 50
    self.physics.match_rotation = true

    self.alpha = 0

    self.pressed = false

    self.afterimg_timer = 0
    self.after_func = after

    self.timer = 0
end

function LightRudeBusterBeam:update()
    self.timer = self.timer + DTMULT

    if self.timer > 9 then
        self.physics.friction = 3
    end

    self.scale_x = Utils.approach(self.scale_x, 2, 0.2*DTMULT)
    self.scale_y = Utils.approach(self.scale_y, 2, 0.2*DTMULT)

    self.alpha = Utils.approach(self.alpha, 1, 0.25 * DTMULT)

    local dir = Utils.angle(self.x, self.y, self.target_x, self.target_y)
    self.rotation = self.rotation + (Utils.angleDiff(dir, self.rotation) / 3.3) * DTMULT

    if Input.pressed("confirm") then
        self.pressed = true
    end

    if Utils.dist(self.x, self.y, self.target_x, self.target_y) <= 45 then
        if self.after_func then
            self.after_func(self.pressed)
        end
        Assets.playSound("rudebuster_hit")
        for i = 1, 8 do
            local burst = RudeBusterBurst(self.red, self.target_x, self.target_y, math.rad(45 + ((i - 1) * 90)), i > 4)
            burst.layer = self.layer + (0.01 * i)
            self.parent:addChild(burst)
        end
        self:remove()
        return
    end

    self.afterimg_timer = self.afterimg_timer + DTMULT
    if self.afterimg_timer >= 1 then
        self.afterimg_timer = 0

        local sprite = Sprite(self.red and "effects/rudebuster/beam_red" or "effects/rudebuster/beam", self.x, self.y)
        sprite:fadeOutSpeedAndRemove()
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(1.8, 1.6)
        sprite.rotation = self.rotation
        sprite.alpha = self.alpha - 0.3
        sprite.layer = self.layer - 0.01
        sprite.graphics.grow_y = -0.1
        sprite.graphics.remove_shrunk = true
        sprite:play(1/15, true)
        self.parent:addChild(sprite)
    end

    super.update(self)
end

return LightRudeBusterBeam