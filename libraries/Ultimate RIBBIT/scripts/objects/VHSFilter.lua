local VHSFilter, super = Class(FXBase)
 
function VHSFilter:init(priority)
    super.init(self, priority)
 
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
 
function VHSFilter:draw(texture, object)
    local canvas = love.graphics.getCanvas()
    Draw.setCanvas(texture)
 
    -- this probably looks good enough
    local blend_mode, alpha_mode = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add")
    love.graphics.setColor(1, 1, 1, 0.125)
    love.graphics.draw(self.filter[self.filter_frame], 0, 0, 0, 1.2, 1.2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode(blend_mode, alpha_mode)
 
    --[[staticnoise = scr_dark_marker(0, 0, spr_staticnoise)
    staticnoise.image_xscale = 8
    staticnoise.image_yscale = 8
    staticnoise.image_alpha = 0.015
    staticnoise.image_speed = 0.6]]
 
    love.graphics.setColor(0, 0, 0, 0.035)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(COLORS.white)
 
    love.graphics.draw(self.vhslines, self.vhslines_x, 463)
 
    Draw.setCanvas(canvas)
 
    -- (Rs, Gs, Bs, As) + (1-Rs, 1-Gs, 1-Bs, 1-As)
    love.graphics.setBlendMode("alpha", "alphamultiply")
    local part_alpha = 0.8
    love.graphics.setColor(self.color3[1], self.color3[2], self.color3[3], self.color3[4] * part_alpha)
    Draw.drawCanvas(texture)
    love.graphics.setColor(self.color1[1], self.color1[2], self.color1[3], self.color1[4] * part_alpha)
    Draw.drawCanvas(texture, 1, 0)
    love.graphics.setColor(self.color2[1], self.color2[2], self.color2[3], self.color2[4] * part_alpha)
    Draw.drawCanvas(texture, -1, 0)
    love.graphics.setColor(COLORS.white)
    love.graphics.setBlendMode(blend_mode, alpha_mode)
 
    -- noop? this only makes sense in object space
    ---@param mode love.DrawMode
    local function rectAxis1toAxis2(mode, x1, y1, x2, y2)
        if x1 > x2 then x1, x2 = x2, x1 end
        if y1 > y2 then y1, y2 = y2, y1 end
        love.graphics.rectangle(mode, x1, y1, x2-x1, y2-y1)
    end
    love.graphics.setColor(COLORS.black)
    rectAxis1toAxis2("fill", -SCREEN_WIDTH, 0, -1, SCREEN_HEIGHT)
    rectAxis1toAxis2("fill", SCREEN_WIDTH, 0, 1000, SCREEN_HEIGHT)
    love.graphics.setColor(COLORS.white)
end
 
return VHSFilter