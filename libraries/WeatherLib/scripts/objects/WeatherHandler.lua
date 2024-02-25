--99, 126, 135

local WeatherHandler, super = Class(Object)

function WeatherHandler:init(typer, sfx, child, intensity, overlay)
    super.init(self)
    self.parallax_x, self.parallax_y = 0, 0
    self.type = typer
    self:setLayer(WORLD_LAYERS["below_ui"])

    self.raintimer = 0
    self.raintimerthres = 0
    self.rainnumber = ""
    self.raintimerreset = true

    self.snowtimer = 0
    self.snowtimerthres = 0
    self.snownumber = ""
    self.snowtimerreset = true
    self.snowcount = 0

    self.thundertimer = 150
    self.thundertimerreset = false

    self.windtimer = 120
    self.windtimerreset = true

    self.dusttimer = 0
    self.dusttimerthres = 0
    self.dustnumber = ""
    self.dusttimerreset = true

    self.sfx = sfx

    self.addto = child or Game.stage:getWeatherParent()
    --if type(self.type) == "table" then self.both = true end
    self.weathersounds = Music()
    if self.type == "thunder" then
       if self.sfx then self.weathersounds:play("heavy_rain", 2, 1) end
    end
    if self.type == "rain" then if self.sfx then self.weathersounds:play("light_rain", 2, 1) end end
    
    self.intensity = intensity or 1

    self.pause = false

    self.haveoverlay = overlay
    if self.haveoverlay and not self.skip then self:postInit() end
end

function WeatherHandler:postInit() self:addOverlay() end

function WeatherHandler:update()
    super.update(self)
    --[[if #Game.stage.overlay > 0 then for i, o in ipairs(Game.stage.overlay) do
        print(o.type, (o.handler.addto == Game.world and "World" or "Battle"))
    end end]]

    if not self.pause then
        if self.type == "rain" or self.type == "thunder" or self.type == "cd" then
            if self.raintimerreset then
                self.raintimerreset = false
                self.raintimerthres = math.random(1, 6)
            elseif self.raintimer >= self.raintimerthres then

                local amount = self.intensity
                if self.type == "thunder" then amount = amount + 1 end

                local speedmult = self.intensity
                if self.type == "thunder" then speedmult = speedmult + 1 end

                for i = amount, 1, -1 do
                    self.raintimer = 0
                    self.raintimerreset = true
                    local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
                    if self.type == "cd" then number = Utils.pick({"cat", "dog"}) end
                    local x = math.random(SCREEN_WIDTH * 0, SCREEN_WIDTH/4)
                    local y = math.random(0, 40)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local rain = RainPiece(number, worldx, worldy, 20 * speedmult, self)

                    self.addto:addChild(rain)

                    self.raintimer = 0
                    self.raintimerreset = true
                    local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
                    if self.type == "cd" then number = Utils.pick({"cat", "dog"}) end
                    local x = math.random(SCREEN_WIDTH * 0.25, SCREEN_WIDTH * 0.5)
                    local y = math.random(0, 40)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local rain = RainPiece(number, worldx, worldy, 20 * speedmult, self)

                    self.addto:addChild(rain)

                    self.raintimer = 0
                    self.raintimerreset = true
                    local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
                    if self.type == "cd" then number = Utils.pick({"cat", "dog"}) end
                    local x = math.random(SCREEN_WIDTH * 0.5, SCREEN_WIDTH * 0.75)
                    local y = math.random(0, 40)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local rain = RainPiece(number, worldx, worldy, 20 * speedmult, self)

                    self.addto:addChild(rain)

                    self.raintimer = 0
                    self.raintimerreset = true
                    local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
                    if self.type == "cd" then number = Utils.pick({"cat", "dog"}) end
                    local x = math.random(SCREEN_WIDTH * 0.75, SCREEN_WIDTH)
                    local y = math.random(0, 40)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local rain = RainPiece(number, worldx, worldy, 20 * speedmult, self)

                    self.addto:addChild(rain)

                    self.raintimer = 0
                    self.raintimerreset = true
                    local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
                    if self.type == "cd" then number = Utils.pick({"cat", "dog"}) end
                    local x = math.random(SCREEN_WIDTH, SCREEN_WIDTH * 1.25)
                    local y = math.random(0, 40)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local rain = RainPiece(number, worldx, worldy, 20 * speedmult, self)

                    self.addto:addChild(rain)

                    self.raintimer = 0
                    self.raintimerreset = true
                    local number = Utils.pick({"three", "five", "six", "nine", "nine_alt"})
                    if self.type == "cd" then number = Utils.pick({"cat", "dog"}) end
                    local x = math.random(SCREEN_WIDTH * 1.25, SCREEN_WIDTH * 1.5)
                    local y = math.random(0, 40)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local rain = RainPiece(number, worldx, worldy, 20 * speedmult, self)
                    self.addto:addChild(rain)
                end

            end
            self.raintimer = self.raintimer + 1 * DTMULT
            --print(self.raintimer, self.raintimerthres)
        end

        if self.type == "snow" then
            if self.snowtimerreset then
                self.snowtimerreset = false
                self.snowtimerthres = math.random(5, 10)
                self.snowcount = Utils.clamp(math.random(Utils.round(2 * self.intensity), Utils.round(4 * self.intensity)), 2, 20)

            elseif self.snowtimer >= self.snowtimerthres then

                self.snowtimer = 0
                self.snowtimerreset = true

                for i = self.snowcount, 1, -1 do
                    local number = Utils.pick({"a", "b", "c", "d", "e"})
                    local speed = Utils.clamp(Utils.random(Utils.round(3 * self.intensity), Utils.round(6 * self.intensity)), 3, 14)
                    local rotspeed = Utils.random(0.5, 6)
                    local sinerspeed = Utils.random(0.6, 4)
                    local lifespan = Utils.random(70, 120)
                    local x = math.random(SCREEN_WIDTH * - 0.25, SCREEN_WIDTH * 1.25)
                    local y = math.random(40, 60)
                    local worldx, worldy = self:getRelativePos(x, 0 - y, self.addto)
                    local snow = SnowPiece(number, worldx, worldy, speed, rotspeed, sinerspeed, lifespan, self)
                    self.addto:addChild(snow)
                end

            end
            self.snowtimer = self.snowtimer + 1 * DTMULT
            --print(self.raintimer, self.raintimerthres)
        end

        if self.type == "thunder" then
            if self.thundertimerreset == true then
                self.thundertimerreset = false
                if self.intensity == 1 then 
                    self.thundertimer = 30 * math.random(8, 11)
                else
                    self.thundertimer = 30 * math.random(8 - self.intensity, 11 - self.intensity)
                end
            end

            if self.thundertimer <= 0 then
                Game.stage.timer:script(function(wait)

                    local first = self.addto:addChild(ThunderFlash(self))
                    wait(0.4)
                    first:remove()

                    self.addto:addChild(ThunderFlash(self))
                    wait(0.5)
                    Assets.stopAndPlaySound("thunder", 0.5, 0.6)
                end)
                --self.addto:addChild(ThunderFlash())
                self.thundertimerreset = true
            end

            self.thundertimer = self.thundertimer - DTMULT
        end

        if self.type == "wind" then
            --print("its going to wind in".. self.windtimer)
            if self.windtimerreset == true then
                self.windtimerreset = false

                if self.intensity == 1 then 
                    self.windtimer = 30 * math.random(6, 14)
                else
                    self.windtimer = 30 * math.random(6 - self.intensity, 14 - self.intensity)
                end
            end

            if self.windtimer <= 0 then
                self.windtimerreset = true
                --print("WOO OHOOO WIND YESS!! IM SO HAPPY")
                local ammount = math.random(1, 7)
                for i = ammount, 1, -1 do
                    Assets.stopAndPlaySound("wind", 0.8, 1.2)
                    Game.stage.timer:script(function(wait)
                        wait(1.5)
                        local speed = Utils.random(15, 19)
                        local y = math.random(SCREEN_HEIGHT * - 0.5, SCREEN_HEIGHT * 0.25)
                        local x = math.random(40, 60) + (i * 120)
                        local worldx, worldy = self:getRelativePos(SCREEN_WIDTH + x, y, self.addto)
                        local leaf = LeafPiece(worldx, worldy, speed, self)
                        self.addto:addChild(leaf)

                    end)
                end
            end

            self.windtimer = self.windtimer - 1 * DTMULT
        end

        if self.type == "volcanic" then
            if self.dusttimerreset then
                self.dusttimerreset = false
                self.dusttimer = math.random(5, 6)
            elseif self.dusttimer <= 0 then

                self.dusttimerreset = true
                local ammount = math.random(3, 5)
                for i = ammount, 1, -1 do

                    local letter = Utils.pick({"a", "b", "c", "d", "e"})
                    local speed = Utils.random(15, 19)
                    local y = math.random(0, SCREEN_HEIGHT)
                    local x = math.random(40, 60) + (i * 120)
                    local worldx, worldy = self:getRelativePos(SCREEN_WIDTH + x, y, self.addto)
                    local dust = DustPiece(letter, worldx, worldy, speed, self)
                    self.addto:addChild(dust)

                end

            end
            self.dusttimer = self.dusttimer - 1 * DTMULT
            --print(self.raintimer, self.raintimerthres)
        end


    else
        if self.type == "thunder" then
            if self.thundertimerreset == true then
                self.thundertimerreset = false
                if self.intensity == 1 then 
                    self.thundertimer = 30 * math.random(8, 11)
                else
                    self.thundertimer = 30 * math.random(8 - self.intensity, 11 - self.intensity)
                end
            end

            if self.thundertimer <= 0 then
                Game.stage.timer:script(function(wait)

                    Assets.stopAndPlaySound("thunder", 0.2, 0.3)
                end)
                --self.addto:addChild(ThunderFlash())
                self.thundertimerreset = true
            end

            self.thundertimer = self.thundertimer - 1 * DTMULT
        end
    end

    if self.haveoverlay then
        local number = 0
        for i, overlay in ipairs(Game.stage.overlay) do
            if overlay[1] == self then number = 1 end
        end
        if number == 0 then self:addOverlay() end
    end
end 

function WeatherHandler:onRemove()
    self.weathersounds:stop()
    self.weathersounds = nil
    for i, child in ipairs(self.addto.children) do
        child:removeFX("wave_fx")
    end
end

function WeatherHandler:addOverlay()
    local overlay = self.addto:addChild(WeatherOverlay(self.type, self))
    table.insert(Game.stage.overlay, {self, overlay})
    return overlay
end

return WeatherHandler