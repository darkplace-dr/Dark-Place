local FlippedRainOverlay, super = Class("CustomWeatherOverlay")

function FlippedRainOverlay:draw()
    super.draw(self)
    local dark = 20

    if not self.paused then
        Draw.setColor((99 - dark)/255, (126 - dark)/255, (135 - dark)/255, 55/255)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    end
    
end

return FlippedRainOverlay