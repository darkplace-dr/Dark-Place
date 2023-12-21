local LightRudeBusterBeam, super = Class(RudeBusterBeam, "LightRudeBusterBeam")

function LightRudeBusterBeam:init(red, x, y, tx, ty, after)
    super.init(self, red, x, y, tx, ty, after)
    if red then
        self:setScale(12)
        self.physics.speed = 6
    else
        self:setScale(10)
        self.physics.speed = 12
    end
end

function LightRudeBusterBeam:update()
    if self.scale_x > 2 then
        self.scale_x = Utils.approach(self.scale_x, 1, 0.8 * DTMULT)
        self.scale_y = Utils.approach(self.scale_y, 1, 0.8 * DTMULT)
    end
    
    super.update(self)
end

return LightRudeBusterBeam