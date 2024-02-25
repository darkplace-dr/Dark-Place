-- CUSTOM WEATHER TUTORIAL


local FlippedRain, super = Class("CustomWeatherHandler", "flipped_rain") -- the id ("flipped-rain") MUST be the type of weather defined in lib.json!

function FlippedRain:init(sfx, child, intensity, overlay)

    super.init(self, self.id, sfx, child, intensity, overlay, FlippedRainOverlay(self))

    self.thres = {1, 6}
    if self.sfx then self.weathersounds:play("light_rain", 2, 1) end
    
end

function FlippedRain:onThreshold()

    local amount = self.intensity

    local speedmult = self.intensity

    for _ = amount, 1, -1 do

        for i = 6, 1, -1 do

            local a = 0.25 * (i - 1)
            local b = 0.25 * i

            local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
            local x = math.random(SCREEN_WIDTH * a, SCREEN_WIDTH * b)
            local y = math.random(0, 40)
            local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
            local rain = FlippedRainPiece("world/flippedrain", number, worldx - SCREEN_WIDTH/2, worldy, speedmult * 20, self)
            if self:getPieceAmount(rain) < 45 then self:addPiece(rain) end -- controls how many pieces can be on the screen at once
        end
    end
end

return FlippedRain