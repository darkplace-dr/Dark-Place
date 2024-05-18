---@class AngryBirdsUIBox : UIBox
local AngryBirdsUIBox, super = Class(Object)

function AngryBirdsUIBox:init(x, y, width, height, skin, fill_color)
    super.init(self, x, y, width, height)

    self.left_frame         = 0
    self.top_frame          = 0
    self.bottom_frame       = 0
    self.right_frame        = 0
    self.top_left_frame     = 0
    self.top_right_frame    = 0
    self.bottom_left_frame  = 0
    self.bottom_right_frame = 0

    self.skin = skin
    self.fill_color = fill_color or {98/255, 212/255, 187/255}

    self.left               = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/left")
    self.top                = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/top")
    self.bottom             = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/bottom")
    self.right              = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/right")
    self.top_left           = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/top_left")
    self.top_right          = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/top_right")
    self.bottom_left        = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/bottom_left")
    self.bottom_right       = Assets.getFramesOrTexture("minigames/ab/ui/box/" .. self.skin .. "/bottom_right")

    self.speed = 10
end

function AngryBirdsUIBox:getBorder()
    return self.left[1]:getWidth()*2, self.top[1]:getHeight()*2
end

function AngryBirdsUIBox:getDebugRectangle()
    if not self.debug_rect then
        local bw, bh = self:getBorder()
        return {-bw, -bh, self.width + bw*2, self.height + bh*2}
    end
    return super.getDebugRectangle(self)
end

function AngryBirdsUIBox:draw()
    self.left_frame           = ((self.left_frame         + (DTMULT / self.speed)) - 1) % #self.left         + 1
    self.top_frame            = ((self.top_frame          + (DTMULT / self.speed)) - 1) % #self.top          + 1
    self.bottom_frame         = ((self.bottom_frame       + (DTMULT / self.speed)) - 1) % #self.bottom       + 1
    self.right_frame          = ((self.right_frame        + (DTMULT / self.speed)) - 1) % #self.right        + 1
    self.top_left_frame       = ((self.top_left_frame     + (DTMULT / self.speed)) - 1) % #self.top_left     + 1
    self.top_right_frame      = ((self.top_right_frame    + (DTMULT / self.speed)) - 1) % #self.top_right    + 1
    self.bottom_left_frame    = ((self.bottom_left_frame  + (DTMULT / self.speed)) - 1) % #self.bottom_left  + 1
    self.bottom_right_frame   = ((self.bottom_right_frame + (DTMULT / self.speed)) - 1) % #self.bottom_right + 1

    local left_width          = self.left[1]:getWidth()
    local left_height         = self.left[1]:getHeight()
    local top_width           = self.top[1]:getWidth()
    local top_height          = self.top[1]:getHeight()
    local bottom_width        = self.bottom[1]:getWidth()
    local bottom_height       = self.bottom[1]:getHeight()
    local right_width         = self.right[1]:getWidth()
    local right_height        = self.right[1]:getHeight()

    local top_left_width      = self.top_left[1]:getWidth()
    local top_left_height     = self.top_left[1]:getHeight()
    local top_right_width     = self.top_right[1]:getWidth()
    local top_right_height    = self.top_right[1]:getHeight()

    local bottom_left_width   = self.bottom_left[1]:getWidth()
    local bottom_left_height  = self.bottom_left[1]:getHeight()
    local bottom_right_width  = self.bottom_right[1]:getWidth()
    local bottom_right_height = self.bottom_right[1]:getHeight()

    local  r, g, b,a = self:getDrawColor()
    local fr,fg,fb   = unpack(self.fill_color)
    Draw.setColor(fr,fg,fb,a)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    Draw.setColor(r, g, b, a)

    Draw.draw(self.left[math.floor(self.left_frame)], 0, 0, 0, 1, self.height / left_height, left_width, 0)
    Draw.draw(self.right[math.floor(self.right_frame)], self.width + right_width, 0, 0, 1, self.height / right_height, right_width, 0)

    Draw.draw(self.top[math.floor(self.top_frame)], 0, 0, 0, self.width / top_width, 1, 0, top_height)
    Draw.draw(self.bottom[math.floor(self.bottom_frame)], 0, self.height + bottom_height, 0, self.width / bottom_width, 1, 0, bottom_height)
	
	--corners
    Draw.draw(self.top_left[math.floor(self.top_left_frame)], 0, 0, 0, 1, 1, top_left_width, top_left_height)
    Draw.draw(self.top_right[math.floor(self.top_right_frame)], self.width + right_width, 0, 0, 1, 1, top_right_width, top_right_height)
	
    Draw.draw(self.bottom_left[math.floor(self.bottom_left_frame)], 0, self.height + bottom_left_height, 0, 1, 1, bottom_left_width, bottom_left_height)
    Draw.draw(self.bottom_right[math.floor(self.bottom_right_frame)], self.width + right_width, self.height + bottom_right_height, 0, 1, 1, bottom_right_width, bottom_right_height)

    super.draw(self)
end

return AngryBirdsUIBox