local Light, super = Class(Object)

function Light:init(x, y, radius, color)
    super:init(self, x, y)
    self.radius = radius
    self.color = color or {1,1,1}
    self.alpha = 1
    self.inherit_color = false
    self.style = Kristal.getLibConfig("darkness", "style")
    -- don't allow debug selecting
    self.debug_select = false
end

function Light:getRadius()
    if type(self.radius) == "function" then
        return self:radius()
    else
        return self.radius
    end
end

return Light