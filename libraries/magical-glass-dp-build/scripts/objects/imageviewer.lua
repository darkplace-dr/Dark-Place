local ImageViewer, super = Class(Sprite, "ImageViewer")

function ImageViewer:init(sprite, x, y)
    super.init(self, sprite, x, y)
    self.x = x or 0
    self.y = y or 0

    self:setParallax(0, 0)
    self.draw_children_below = 0
    self:setScale(2)
end

function ImageViewer:onKeyPressed(key)
    if Input.is("cancel", key) then
        self:remove()
        Game.world:closeMenu()
    end
end

return ImageViewer