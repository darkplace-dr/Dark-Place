local VHSFilter, super = Class(Object)

function VHSFilter:init(x, y)
    super.init(self, x, y)
	
    local filter = Sprite("objects/overlays/vhsfilter", 0, 0)
    filter:play(0.008, true)
    filter:setScale(1.2, 1.2)
    filter.alpha = 0.125
    self:addChild(filter)
	
    self.vhslines = Sprite("objects/overlays/vhslines", -350, 463)
    self.vhslines.physics.speed_x = 80
    self:addChild(self.vhslines)
	
    self.parallax_x = 0
    self.parallax_y = 0
end

function VHSFilter:update()
    super.update(self)
	
    if self.vhslines.x >= 100 then
        self.vhslines.x = -350
    end
end

-- still need help with porting over the exact draw code from the original code.
-- Cause I have absolutely no idea application_surface even is in GML.
-- Plus, the add blend mode behaves really weirdly when entering battles and/or completing battles,
-- which is also something I don't know how to fix either, lmfao.

function VHSFilter:draw()
    love.graphics.setBlendMode("add")
    super.draw(self)
    love.graphics.setBlendMode("screen")
    Utils.mergeColor(COLORS.white, COLORS.red, 0.05)
    Utils.mergeColor(COLORS.white, COLORS.blue, 0.05)
    Utils.mergeColor(COLORS.white, COLORS.green, 0.05)
end

return VHSFilter