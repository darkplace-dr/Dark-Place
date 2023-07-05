local Particle, super = Class(Sprite)

function Particle:init(texture, x, y)
    super:init(self, texture, x, y)
    self:setOrigin(0.5, 0.5)
end

function Particle:update()
    if self.update_func then self:update_func() end
    super:update(self)
end

function Particle:draw()
    if self.pre_draw_func then self:pre_draw_func() end
    if self.blend ~= "alpha" and self.blend ~= "add" then
        love.graphics.setBlendMode(self.blend, "premultiplied")
    else
        love.graphics.setBlendMode(self.blend)
    end
    if self.draw_func then
        self:draw_func(function()
            super:draw(self)
        end)
    else
        super:draw(self)
    end
    love.graphics.setBlendMode("alpha")
    if self.post_draw_func then self:post_draw_func() end
end

function Particle:remove()
    if self.remove_func then
        self:remove_func(function()
            super:remove(self)
        end)
    else
        super:remove(self)
    end
end

return Particle