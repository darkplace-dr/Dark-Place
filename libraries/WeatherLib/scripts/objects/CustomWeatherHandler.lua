local CustomWeatherHandler, super = Class("WeatherHandler")

function CustomWeatherHandler:init(type, sfx, parent, intensity, overlay, obj)
    self.skip = true
    super.init(self, type, sfx, parent, intensity, overlay)
    -- INITIAL STUFF
    self.type = self.id

    -- TIMERS
    self.timer = 0
    self.thres = {0, 0}
    self.multiplier = intensity
    self.overlay = obj
    --print('child', parent)
    --print("ov", self.overlay)
    if self.overlay then self:addOverlay() end

    -- MUSIC
    if self.sfx then self.weathersounds:play("light_rain", 2, 1) end
end

function CustomWeatherHandler:update()
    super.super.update(self)

    if not self.pause then -- for general purposes, it's "if not indoors then"
        if self.type == self.id then

            if self.timer <= 0 then

                self.timer = math.random(self.thres[1], self.thres[2])
                self:onThreshold()

            end
            self.timer = self.timer - 1 * DTMULT * self.multiplier
            --print(self.fraintimer, self.fraintimerthres)
        end
    end

    if self.haveoverlay then
        local number = 0
        for i, overlay in ipairs(Game.stage.overlay) do
            if overlay[1] == self then number = 1 end
        end
        if number == 0 and self.overlay then self:addOverlay() end
    end
end

function CustomWeatherHandler:onThreshold() end

function CustomWeatherHandler:onRemove()
    self.weathersounds:stop()
    self.weathersounds = nil
end

function CustomWeatherHandler:addOverlay()
    local overlay = self.addto:addChild(self.overlay) 
    --print("this is the overlay:", self.overlay)
    table.insert(Game.stage.overlay, {self, overlay})
    return overlay
end

function CustomWeatherHandler:addPiece(piece)
    self.addto:addChild(piece)
end

function CustomWeatherHandler:getPieceAmount(piece)
    local number = 0
    for i, child in ipairs(self.addto.children) do
        if child:includes(piece) and child.handler == self then number = number + 1 end
    end
    return number
end

return CustomWeatherHandler