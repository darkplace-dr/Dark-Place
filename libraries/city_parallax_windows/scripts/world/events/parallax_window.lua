local ParallaxWindow, super = Class(Event)

function ParallaxWindow:init(data)
    super.init(self, data)

    local pr = data.properties or {}

    self.inverted       = pr.inverted or false
    self.bg_color       = pr.color and Utils.hexToRgb("#"..pr.color) or nil

    self.siner          = 0
    self.dontdraw       = 0
    self.sprite_path    = "world/events/parallax_window/".."window"..(self.inverted and "_inverted" or "")
end

function ParallaxWindow:draw()
    self.siner = self.siner + DTMULT

    local color = self.inverted and Utils.hexToRgb("#" .. Kristal.getLibConfig("city_parallax_windows", "windowBackgroundInverted")) or Utils.hexToRgb("#"..Kristal.getLibConfig("city_parallax_windows", "windowBackground"))
    if self.bg_color then
        color = self.bg_color
    end
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", 0, 0, 80, 80)

    if self.dontdraw == 1 then
        return
    end

    self:drawParallaxSpritesScale(self.siner / 8, self.siner / 8, self.siner / 8, 0.3, 3)
    self:drawParallaxSprites(self.siner / 8, self.siner / 3, self.siner / 6, 1)
end

function ParallaxWindow:drawParallaxSprites(frame, offset_x, offset_y, alpha)
    frame = math.floor(frame)

    local texture
    local _frames = Assets.getFrames(self.sprite_path)
    frame = Utils.clampWrap(frame, 1, #_frames)
    texture = _frames[frame]

    local width, height = texture:getWidth(), texture:getHeight()

    offset_x = offset_x % width
    offset_y = offset_y % height

    if offset_x < 0 then
        offset_x = offset_x + width
    end
    if offset_y < 0 then
        offset_y = offset_y + height
    end

    Draw.setColor(1, 1, 1, alpha)

    if offset_x == 0 and offset_y == 0 then
        Draw.draw(texture, 0, 0, 0, 2, 2)
        return
    end

    self:drawPartialSprite(texture, 0, 0, width - offset_x, height - offset_y, offset_x * 2, offset_y * 2, 2, 2)
    self:drawPartialSprite(texture, width - offset_x, height - offset_y, offset_x, offset_y, 0, 0, 2, 2)
    self:drawPartialSprite(texture, 0, height - offset_y, width - offset_x, offset_y, offset_x * 2, 0, 2, 2)
    self:drawPartialSprite(texture, width - offset_x, 0, offset_x, height - offset_y, 0 , offset_y * 2, 2, 2)
end

function ParallaxWindow:drawParallaxSpritesScale(frame, offset_x, offset_y, alpha, scale)
    frame = math.floor(frame)

    local texture
    local _frames = Assets.getFrames(self.sprite_path)
    frame = Utils.clampWrap(frame + 1, 1, #_frames)
    texture = _frames[frame]

    local width, height = texture:getWidth(), texture:getHeight()

    offset_x = offset_x % width
    offset_y = offset_y % height

    if offset_x < 0 then
        offset_x = offset_x + width
    end
    if offset_y < 0 then
        offset_y = offset_y + height
    end

    Draw.setColor(1, 1, 1, alpha)

    if offset_x == 0 and offset_y == 0 then
        Draw.draw(texture, 0, 0, 0, 2, 2)
        return
    end

    local maximum_x = width * (2 / scale)
    local maximum_y = height * (2 / scale)

    self:drawPartialSprite(texture, 0, 0, maximum_x - offset_x, maximum_y - offset_y, offset_x * scale, offset_y * scale, scale, scale)
    self:drawPartialSprite(texture, width - offset_x, height - offset_y, math.min(maximum_x, offset_x), math.min(maximum_y, offset_y), 0, 0, scale, scale)
    self:drawPartialSprite(texture, 0, maximum_y - offset_y, math.min(maximum_x, maximum_x - offset_x), math.min(maximum_y, offset_y), offset_x * scale, 0, scale, scale)
    self:drawPartialSprite(texture, maximum_x - offset_x, 0, math.min(maximum_x, offset_x), math.min(maximum_y, maximum_y - offset_y), 0, offset_y * scale, scale, scale)
end

function ParallaxWindow:drawPartialSprite(texture, left, top, width, height, x, y, scale_x, scale_y)
    Draw.drawPart(texture, x, y, left, top, width, height, 0, scale_x, scale_y)
end

return ParallaxWindow