
-- CUSTOM WEATHER PIECE "TUTORIAL"

local FlippedRainPiece, super = Class("WeatherPiece")

function FlippedRainPiece:init(path, sprite, x, y, speed, handler)
    super.init(self, path, sprite, x, y, speed, handler)
    --super.init()

    self.sprite = Sprite(path.."/"..sprite)
    self.sprite:setScale(2)
    self.sprite.inherit_color = true

    self:setPosition(self.x, self.y - (self.sprite.height * 2))
    
    self.blend_mode = "add"
    self.alpha = 0.4

    self.offscreen_sides = {"bottom", "left"} -- the sides of the screen where the weather piece is considered "offscreen"
end

function FlippedRainPiece:handleMovement()
    self.x, self.y = self.x + self.speed * 0.5 * DTMULT, self.y + self.speed * DTMULT

    if self.y - self.inity > (Game.world.map.height * Game.world.map.tile_height) + 120 then
        Utils.approach(self.alpha, 0, DTMULT)
        if self.alpha < 0.5 then self:remove() end
    end
end

function FlippedRainPiece:onOffscreen()
    self:remove()
end

return FlippedRainPiece