local AfterImageCut, super = Class(Object)

function AfterImageCut:init(texture, x, y, after)
    super.init(self, x, y)

    if type(texture) == "string" then
        texture = Assets.getTexture(texture) or (Assets.getFrames(texture)[1])
    end
    self.texture = texture

    self.start_color = {1, 1, 1}

    self.done = false
    self.after_func = after

    self.width, self.height = texture:getWidth(), texture:getHeight()
    self.xo, self.yo = self:getOrigin()
	
    self.spr_alpha = 1.5
    self.faderate = 0.1
    self.siner = 0
    
    self.flash = true
	
    self.flash_timer = Timer()
    self:addChild(self.flash_timer)
end

function AfterImageCut:onAdd(parent)
    super.onAdd(parent)

    self.start_color = self.color
end

function AfterImageCut:update()
    self.siner = self.siner + DTMULT
    self.spr_alpha = self.spr_alpha - self.faderate * DTMULT
	
    if self.spr_alpha <= 0 then
        self.done = true
        if self.after_func then
            self.after_func()
        end
        self:remove()
    end

    super.update(self)
end

function AfterImageCut:draw()
    if self.flash then
        self.highlight = self:addFX(ColorMaskFX())
        self.highlight.color = {1, 1, 1}
        self.highlight.amount = 1
        self.flash_timer:tween(0.2, self.highlight, { amount = 0 })
		
        self.flash = false
    end

    local r, g, b, a = self:getDrawColor()
	
    local hw = self.width/2
    local hh = self.height/2

    local m = Utils.ease(0, hh, (self.siner + 2)/10, "out-sine")
    love.graphics.setColor(r, g, b, self.spr_alpha)
	
    Draw.drawPart(self.texture, (self.x - m - self.xo * self.scale_x / 2), (self.y - m - self.yo * self.scale_y / 2), 0, 0, hw, hh)
    Draw.drawPart(self.texture, (self.x + m - self.xo * self.scale_x / 2), (self.y - m - self.yo * self.scale_y / 2), hw, 0, hw, hh)
    Draw.drawPart(self.texture, (self.x - m - self.xo * self.scale_x / 2), (self.y + m - self.yo * self.scale_y / 2), 0, hh, hw, hh)
    Draw.drawPart(self.texture, (self.x + m - self.xo * self.scale_x / 2), (self.y + m - self.yo * self.scale_y / 2), hw, hh, hw, hh)

    super.draw(self)
end

return AfterImageCut