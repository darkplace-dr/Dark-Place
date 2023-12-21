local LightArenaSprite, super = Class(Object)

function LightArenaSprite:init(arena, x, y)
    super.init(self, x, y)

    self.arena = arena

    self.width = arena.width
    self.height = arena.height

    self:setScaleOrigin(0.5, 0.5)
    self:setRotationOrigin(0.5, 0.5)

    self.debug_select = false
end

function LightArenaSprite:update()
    self.x = self.arena.x
    self.y = self.arena.y

    self.width = self.arena.width
    self.height = self.arena.height
    super.update(self)
end

function LightArenaSprite:draw()
    super.draw(self)

    local r,g,b,a = self:getDrawColor()

    Draw.setColor(r, g, b, a)
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(self.arena.line_width)
    love.graphics.line(unpack(self.arena.border_line))
    
end

function LightArenaSprite:canDeepCopyKey(key)
    return super.canDeepCopyKey(self, key) and key ~= "arena"
end

return LightArenaSprite