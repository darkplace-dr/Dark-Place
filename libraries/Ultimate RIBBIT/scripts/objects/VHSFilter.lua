local VHSFilter, super = Class(FXBase)

function VHSFilter:init(priority)
    super.init(self, priority)

    --self.transformed = true

    self.time = 0

    self.filter = Assets.getFrames("objects/overlays/vhsfilter")
    self.filter_frame = 1

    self.vhslines = Assets.getTexture("objects/overlays/vhslines")
    self.vhslines_x = -350

    local mix_amt = 0.05
    self.color1 = Utils.mergeColor(COLORS.white, COLORS.red, mix_amt)
    self.color2 = Utils.mergeColor(COLORS.white, COLORS.blue, mix_amt)
    self.color3 = Utils.mergeColor(COLORS.white, COLORS.green, mix_amt)
end

function VHSFilter:update()
    super.update(self)

    self.time = self.time + 0.8 * DTMULT
    self.filter_frame = Utils.clampWrap(math.floor(self.time) + 1, 1, #self.filter)

    self.vhslines_x = Utils.clampWrap(self.vhslines_x + 80 * DTMULT, -350, 100)
end

---@param texture love.Canvas
function VHSFilter:draw(texture, object)
    love.graphics.setColor(1, 1, 1)
    local ox, oy, _, _ = self:getObjectBounds()
    local w, h = texture:getWidth(), texture:getHeight()
    local canvas = love.graphics.getCanvas()
    local blend_mode, alpha_mode = love.graphics.getBlendMode()

    love.graphics.setCanvas(texture)

    --[[staticnoise = scr_dark_marker(0, 0, spr_staticnoise)
    staticnoise.image_xscale = 8
    staticnoise.image_yscale = 8
    staticnoise.image_alpha = 0.015
    staticnoise.image_speed = 0.6]]

    love.graphics.setBlendMode("add")
    love.graphics.setColor(1, 1, 1, 0.125)
    love.graphics.draw(self.filter[self.filter_frame], 0, 0, nil, w / 600, h / 450)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode(blend_mode, alpha_mode)

    love.graphics.draw(self.vhslines, self.vhslines_x, math.max(0, h - 17))

    love.graphics.setCanvas(canvas)

    local part_alpha = 0.8
    love.graphics.setBlendMode("alpha", "alphamultiply")
    love.graphics.setColor(self.color3[1], self.color3[2], self.color3[3], self.color3[4] * part_alpha)
    love.graphics.draw(texture, ox, oy, nil, 1, 1, ox, oy)
    love.graphics.setColor(self.color1[1], self.color1[2], self.color1[3], self.color1[4] * part_alpha)
    love.graphics.draw(texture, ox + 1, oy, nil, 1, 1, ox, oy)
    love.graphics.setColor(self.color2[1], self.color2[2], self.color2[3], self.color2[4] * part_alpha)
    love.graphics.draw(texture, ox - 1, oy, nil, 1, 1, ox, oy)
    love.graphics.setColor(COLORS.white)
    love.graphics.setBlendMode(blend_mode, alpha_mode)

    love.graphics.setColor(0, 0, 0, 0.035)
    love.graphics.rectangle("fill", ox, oy, w, h)
    love.graphics.setColor(COLORS.white)
end

--[[function VHSFilter:getObjectBounds(shader)
    if self.parent ~= Game.stage then
        return super.getObjectBounds(self, shader)
    end
    local w_bak, h_bak = self.parent.width, self.parent.height
    self.parent.width, self.parent.height = SCREEN_WIDTH, SCREEN_HEIGHT
    local ret = {super.getObjectBounds(self, shader)}
    self.parent.width, self.parent.height = w_bak, h_bak
    return unpack(ret)
end]]

return VHSFilter