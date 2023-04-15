local HeartBullet, super = Class(Bullet)

function HeartBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/hathy/heartbullet")
    self:setScale(1)

    self.physics.direction = 0
    self.physics.speed = 0.5
    self.siner = 0
    self.xdir = 0
    self.type = 0
    self.norot = 0
    self.maxradius = 80
    self.movespeed = 0.5
    self.radcon = 0
    self.radius = 160
    self.index = 0
end

function HeartBullet:update()
    super.update(self)
    if self.type == 0 then
        if self.radius > self.maxradius then
            self.radius = self.radius - 2.5
        else
            self.radius = self.radius + (math.sin(self.siner / 10) / 2)
        end
    end
    if self.type == 1 then
        if self.radius > self.maxradius and self.radcon == 0 then
            self.radius = self.radius - 2
        else
            self.radcon = 0
            self.radius = self.radius + 4
            self.damage = 0
            self.alpha = self.alpha - 0.05
        end
    end
    self.physics.direction = self.physics.direction + math.rad(1)
    self.siner = self.siner + 0.75
    if self.radcon == 0 then
        if self.alpha < 1 then
            self.alpha = self.alpha + 0.05
        end
        local xx = (math.sin((((math.pi * self.index) / 8) + (self.siner / 20))) * self.radius)
        local yy = (math.cos((((math.pi * self.index) / 8) + (self.siner / 20))) * self.radius)
        local xxx = ((self.x) + xx) / 2
        local yyy = ((self.y + 10) + yy) / 2
        self.x = xxx + (SCREEN_WIDTH / 4)
        self.y = yyy + (SCREEN_HEIGHT / 6)
        if self.radcon == 1 then
            self.alpha = self.alpha - 0.05
            self.damage = 0
            if self.alpha == 0 then
                self:remove()
            end
        end
    end
end

return HeartBullet