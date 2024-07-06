---@class OutlineFX_V2 : FXBase
---@overload fun(...) : OutlineFX_V2
local OutlineFX_V2, super = Class(FXBase)

function OutlineFX_V2:init(color, settings, priority)
    super.init(self, priority or 0)

    settings = settings or {}

    self.color = color or {1, 1, 1, 1}
    self.thickness = settings["thickness"] or 1
    self.amount = settings["amount"] or 1
    self.cutout = settings["cutout"]

    self.cutout_shader = Kristal.Shaders["Mask"]
end

function OutlineFX_V2:setColor(r, g, b, a)
    self.color = {r, g, b, a}
end

function OutlineFX_V2:getColor()
    return self.color[1], self.color[2], self.color[3]
end

function OutlineFX_V2:isActive()
    return super.isActive(self) and self.amount > 0
end

function OutlineFX_V2:draw(texture)
    local last_shader = love.graphics.getShader()

    local object = self.parent

    local mult_x, mult_y = object:getFullScale()
    mult_x = mult_x * self.thickness
    mult_y = mult_y * self.thickness

    local outline = Draw.pushCanvas(texture:getWidth(), texture:getHeight())

    if self.cutout then
        love.graphics.stencil((function()
            love.graphics.setShader(self.cutout_shader)
            Draw.drawCanvas(texture)
            love.graphics.setShader()
        end), "replace", 1)

        love.graphics.setStencilTest("less", 1)
    end

    local shader = Kristal.Shaders["AddColor"]
    love.graphics.setShader(shader)

    shader:send("inputcolor", {self:getColor()})
    shader:send("amount", self.amount)
    --[[local din = 1.10966881
        {-1 * din, 0}, {1 * din, 0}, {0, -1 * din}, {0, 1 * din},
        {-1 * din, -1 * din}, {1 * din, -1 * din}, {-1 * din, 1 * din}, {1 * din, 1 * din}]]
    local directions = {
        {-1, 0}, {1, 0}, {0, -1}, {0, 1},
        {-1, -1}, {1, -1}, {-1, 1}, {1, 1}
    }
    for _, dir in ipairs(directions) do
        love.graphics.translate(dir[1] * mult_x, dir[2] * mult_y)
        Draw.drawCanvas(texture)
        love.graphics.translate(-dir[1] * mult_x, -dir[2] * mult_y)
    end

    -- Center
    if self.cutout then
        love.graphics.setShader(last_shader)
        Draw.drawCanvas(texture)
        love.graphics.setStencilTest()
    end

    Draw.popCanvas()

    Draw.setColor(1, 1, 1, self.color[4])
    Draw.drawCanvas(outline)
    Draw.setColor(1, 1, 1, 1)

    -- Center
    if not self.cutout then
        love.graphics.setShader(last_shader)
        Draw.drawCanvas(texture)
    end
end

return OutlineFX_V2