local BigShot, super = Class("YellowSoulShot")

function BigShot:init(x, y, angle)
    super:init(self, x, y, angle)
    self:setSprite("player/shot/bigshot")
    self.alpha = 0.5
    self:setScale(0.1, 2)
    self.collider = CircleCollider(self, 30,14, 14)

    self.physics.speed = 9
    self.physics.friction = -0.4
    self.damage = 4
    self.big = true
end

function BigShot:update()
    if self.scale_x < 1 then
        self.scale_x = Utils.approach(self.scale_x, 1, 0.2*DTMULT)
    end
    if self.scale_y > 1 then
        self.scale_y = Utils.approach(self.scale_y, 1, 0.2*DTMULT)
    end
    if self.alpha < 1 then
        self.alpha = Utils.approach(self.alpha, 1, 0.2*DTMULT)
    end
    super:update(self)
end

return BigShot