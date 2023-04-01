local DeadlyNeedle, super = Class(Bullet)

function DeadlyNeedle:init(x, y, rot)
    super.init(self, x, y, "battle/bullets/arenahazard")

    self.collider = Hitbox(self, 0, 0, self.width, self.height/1.5)
    self:setOrigin(0.5, 0)
    self:setScale(2, 0)
    self.yscale = 0

    self.rotation = rot

    self.destroy_on_hit = false
end

function DeadlyNeedle:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if self.yscale < 7 then
        self.yscale = self.yscale + (1 * DTMULT)
        self:setScale(2, self.yscale)
    end

    super.update(self)
end

return DeadlyNeedle