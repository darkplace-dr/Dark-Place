---@class GMPathTest : Sprite
local GMPathTest, super = Class(Sprite)

function GMPathTest:init()
    super.init(self, "world/the_boy", 80, 120)
    self:setParallax(0, 0)
    self:setLayer(WORLD_LAYERS["above_soul"])
    self:setScale(2)
    self:setOrigin(0.5)

    ---@type GMPath
    self.path = GMPath({
        type = GMPath.Types.CURVED,
        closed = true,
        precision = 4
    })
    self.path:addPoint(-40, -60, 0.6)
    self.path:addPoint(0, 0, 1)
    self.path:addPoint(400, 0, 2)
    self.path:addPoint(400, 220, 1.5)
    self.path:addPoint(0, 220, 1.25)
    self.path:addPoint(200, 220, 1)

    self.progress = 0
    self.progress_speed_base = 0.1
end

function GMPathTest:update()
    local point = self.path:getPosition(self.progress)
    self.x = self.init_x + point.x
    self.y = self.init_y + point.y
    self.progress = Utils.approach(self.progress, 1, DT * self.progress_speed_base * point.speed)

    super.update(self)
end

return GMPathTest