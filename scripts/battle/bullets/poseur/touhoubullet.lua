local TouhouBullet, super = Class(Bullet)

function TouhouBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/poseurbullet")
    self:setScale(1, 1)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false
    self.remove_offscreen = false

    self.timer = 0
    self.offset = 0
    self.negmult = 0
    self.neg = 1
end

function TouhouBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    local posx = math.cos(self.timer + self.offset) + 1
    local posy = math.sin(self.timer*self.negmult + self.offset)
    self:move(-posx, posy)
    self.timer = self.timer + 1/40

    super.update(self)
end

return TouhouBullet