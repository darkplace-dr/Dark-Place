local DustEffectParticle, super = Class(Object, "DustEffectParticle")

function DustEffectParticle:init(color, x, y)
    super.init(self, x, y)

    self.color = Utils.unpackColor({color})
    self:setScale(0.5)
end

function DustEffectParticle:update()
    super.update(self)

    if self.activated then
        local new_color = Utils.unpackColor({self.color})
        new_color[4] = new_color[4] - 0.07 * DTMULT
        self.color = new_color

        if new_color[4] < 0.01 then
            self:remove()
        end
    end
end

function DustEffectParticle:draw()
    super.draw(self)
    Draw.setColor(self.color)
    love.graphics.rectangle("fill", 0, 0, 2, 2)
end

return DustEffectParticle