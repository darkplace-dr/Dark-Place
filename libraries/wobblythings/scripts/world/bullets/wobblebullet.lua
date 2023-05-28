local WobbleBullet, super = Class(WorldBullet)

function WobbleBullet:init(x, y, direction)
    super.init(self, x, y, "bullets/wobblebullet")

    self.damage = 15

    self.alpha = 0.7

    self.physics.speed = 10
    self.physics.direction = direction

    self.timer = 0
    self.collidable = false

    self.battle_fade = false
end

function WobbleBullet:update()
    self.timer = self.timer + DTMULT
    if (self.timer >= 2) then
        if (self.alpha < 1) then
            self.alpha = self.alpha + (0.1 * DTMULT)
        end
        if (self.alpha >= 1) then
            self.collidable = true
        end
    end

    local screen_x, screen_y = self:getScreenPos()

    if screen_y >= 600 then -- if (y > (__view_get((1 << 0), 0) + 600)) {
        self:remove()
    end
    if screen_y < -800 then -- if (y < (__view_get((1 << 0), 0) - 800)) {
        self:remove()
    end

    super.update(self)
end

return WobbleBullet