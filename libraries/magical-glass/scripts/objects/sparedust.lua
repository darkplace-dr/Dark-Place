local SpareDust, super = Class(Sprite, "SpareDust")

function SpareDust:init(x, y)
    super.init(self, "effects/spare/dustcloud", x, y)

    self:play(5/30, false, function(s) s:remove() end)

    self.physics.friction = 0.8

    self.scale_variance = Utils.random(0, 1, 1) + 0.7
    self:setScale(self.scale_variance)

end

function SpareDust:spread()
    self.physics.direction = math.rad(Utils.random(360)) -- why

    local low = 0.75
    local high = 1.25

    if self.rightside < low then
        self.physics.direction = math.rad(180)
    end
    if self.rightside > high then
        self.physics.direction = math.rad(0)
    end
    if self.topside > high and self.rightside > high then
        self.physics.direction = math.rad(45)
    end
    if self.topside > high and self.rightside > low and self.rightside < high then
        self.physics.direction = math.rad(90)
    end
    if self.topside > high and self.rightside < low then
        self.physics.direction = math.rad(135)
    end
    if self.topside < low and self.rightside > high then
        self.physics.direction = math.rad(315)
    end
    if self.topside < low and self.rightside > low and self.rightside < high then
        self.physics.direction = math.rad(270)
    end
    if self.topside < low and self.rightside < low then
        self.physics.direction = math.rad(235)
    end
    
    self.physics.direction = self.physics.direction
    self.physics.speed = 8
end

function SpareDust:update()
    self.alpha = self.alpha - 0.03 * DTMULT
    super.update(self)
end

return SpareDust