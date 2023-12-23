---@class DiscoBall : Object
local DiscoBall, super = Class(Object)

function DiscoBall:init()
    super.init(self)
    self.sprite = Sprite("battle/discoball")
    self.layer = BATTLE_LAYERS["below_battlers"]
    self.sprite:setScale(2)
    self.sprite:setOrigin(0.5, 0)
    self.sprite:play(1/5, true)
    self.x = SCREEN_WIDTH/2
    self.y = -120
    self:addChild(self.sprite)
    self.tweendir = 0
    self.lasttween = 0


    self.timer = Timer()
    self:addChild(self.timer)

    self.hue = math.random()

end

function DiscoBall:update()
    super.update(self)
        if self.tweendir == 1 and self.lasttween ~= 1 then
        self.timer:tween(1, self, {y = 0}, "out-expo")
        self.tweendir = 0
        self.lasttween = 1
        end
        if self.tweendir == -1 and self.lasttween ~= -1 then
        self.timer:tween(0.5, self, {y = -120}, "in-expo")
        self.tweendir = 0
        self.lasttween = -1
        end

    self.hue = self.hue + DTMULT/640
    if self.hue > 1 then
        self.hue = self.hue - 1
    end

end

function DiscoBall:draw()
    love.graphics.setColor(DiscoBall:HSV(self.hue, 1, 1))
    love.graphics.circle("fill", 0, 65, 55, 100)
    super.draw(self)

end


-- Function from the love2d wiki, converts HSV to RGB
function DiscoBall:HSV(h, s, v)
    if s <= 0 then return v,v,v end
    h = h*6
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0, 0, 0
    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    return r+m, g+m, b+m
end

return DiscoBall