local LightArenaBackground, super = Class(Object)

function LightArenaBackground:init(arena, x, y)
    super.init(self, x, y)

    self.arena = arena

    self:setScaleOrigin(0.5, 0.5)
    self:setRotationOrigin(0.5, 0.5)
end

function LightArenaBackground:update()
    self.x = self.arena.x
    self.y = self.arena.y

    self.width = self.arena.width + 1
    self.height = self.arena.height
    super.update(self)
end

function LightArenaBackground:draw()
    super.draw(self)

    Draw.setColor(self.arena:getBackgroundColor())
    for _,triangle in ipairs(self.arena.triangles) do
        love.graphics.polygon("fill", unpack(triangle))
    end
end

return LightArenaBackground