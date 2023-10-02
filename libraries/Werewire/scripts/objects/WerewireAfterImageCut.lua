local WerewireAfterImageCut, super = Class(Object)

function WerewireAfterImageCut:init(object)
    super:init(self)

    self.canvas = Draw.captureObject(object)

    self.transform = object:getTransform()
    self.layer = object.layer

    self.faderate = 0.1
    self.siner = 0
end

function WerewireAfterImageCut:applyTransformTo(tf, floor_x, floor_y)
    tf:apply(self.transform)
end

function WerewireAfterImageCut:update()
    self.siner = self.siner + DTMULT
    self.alpha = self.alpha - self.faderate * DTMULT

    if self.alpha <= 0 then
        self:remove()
        return
    end

    super:update(self)
end

function WerewireAfterImageCut:draw()
    local hw = self.canvas:getWidth()/2
    local hh = self.canvas:getHeight()/2
    local m = Utils.ease(0, hh, (self.siner + 2) / 10, "out-sine")

    Draw.drawPart(self.canvas, -m, -m, 0, 0, hw, hh)
    Draw.drawPart(self.canvas, hw+m, -m, hw, 0, hw, hh)
    Draw.drawPart(self.canvas, -m, hh+m, 0, hh, hw, hh)
    Draw.drawPart(self.canvas, hw+m, hh+m, hw, hh, hw, hh)

    super:draw(self)
end

return WerewireAfterImageCut