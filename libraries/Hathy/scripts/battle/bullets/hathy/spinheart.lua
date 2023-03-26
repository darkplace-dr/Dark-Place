local SpinHeart, super = Class(Bullet)

function SpinHeart:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/hathy/spinheart")
    self:setScale(3)

    self.physics.direction = dir
    self.physics.speed = speed
    self.destroy_on_hit = false
    self.collider = PolygonCollider(self, {{3,20},{0,16},{0,7},{7,0},{20,0},{40,20},{20,40},{7,40},{0,33},{0,24},{3,20},{8,20},{4,15},{4,8},{9,4},{18,4},{36,20},{18,36},{9,36},{4,32},{4,25},{8,20}})
    self.damage = 0

    self.con = 0
    self.htimer = 0
    self.alpha = 0
    self.spinmax = 0
    self.hmax = 0
end

function SpinHeart:update(dt)
    -- For more complicated bullet behaviours, code here gets called every update
    if self.con == 0 then
        self.alpha = self.alpha + 0.1
        local scale = self.getScale(self)
        self:setScale(scale - 0.1)
        self.htimer = self.htimer + 0.5
        if self.htimer >= 5 then
            self.con = 1
            self.htimer = 0
            self.damage = nil
        end
    end
    if self.con == 1 then
        self.htimer = self.htimer + 0.5
        if self.htimer >=10 then
            if math.random(1, 4) == 1 then
                self.spinmax = 26.25
            elseif math.random(1, 4) == 2 then
                self.spinmax = 30
            elseif math.random(1, 4) == 3 then
                self.spinmax = 33.75
            else
                self.spinmax = 37.5
            end
            self.con = 2
            self.htimer = 0
        end
    end
    if self.con == 2 then
        self.htimer = self.htimer + 0.5
        self.rotation = self.rotation + math.rad(12)
        if self.htimer >= self.spinmax then
            self.hmax = 19
            self.rotation = math.rad(self.spinmax * 24)
            self.con = 3
            self.htimer = 0
        end
    end
    if self.con == 3 then
        self.htimer = self.htimer + 0.5
        if self.htimer >= self.hmax then
            self.physics.direction = self.rotation
            self.physics.speed = 2.5
            self.physics.friction = -0.5
            self.con = 4
            self.htimer = 0
        end
    end
    if self.con == 4 then
        self.htimer = self.htimer + 0.5
        if self.htimer >= 10 then
            self.physics.friction = 0
            self.physics.speed = 0
        end
        if self.htimer >= 20 then
            self.damage = 0
            self.alpha = self.alpha - 0.1
        end
        if self.htimer >= 25 then
            self.wave.finished = true
        end
    end

    super.update(self, dt)
end

return SpinHeart