local GemApple, super = Class(Bullet)

function GemApple:init(x, y, dir, speed)
    super.init(self, x, y, "battle/bullets/gemapple")

    self.physics.direction = dir
    self.physics.speed = speed
    self.physics.friction = love.math.random(1,3) / 15
    self.scale = self:getScale()
    self.destroy_on_hit = false
end

function GemApple:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if self.physics.speed <= 0 then
        self.scale = self:getScale()
        self:setScale(self.scale + (0.2 * DTMULT))
    end
    if self.scale >= 4 then
        Assets.stopAndPlaySound("badexplosion")
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(0), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(45), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(90), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(135), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(180), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(225), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(270), 8)
        self.wave:spawnBullet("smallbullet", self.x, self.y, math.rad(315), 8)
        self:explode()
    end

    super.update(self)
end

return GemApple