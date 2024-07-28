WeatherLib = {}

function WeatherLib:init()

    WeatherRegistry.init()

    Utils.hook(Stage, "setWeather", function(orig, self, typer, keep, sfx, addto)
        orig(self)
        --print(Game.world.player)
        local weather_type = {}
        local wrongtype = false
        local istable = false
        local nuh_uh = false
        local possible_types_a = {
            "rain",
            "thunder",
            "snow",
            "wind",
            "volcanic",
            "chilly",
            "cloudy",
            "overcast",
            "dark_overcast",
            "hot",
            "clear",
            "cd",
        }
        local possible_types = possible_types_a
        if Kristal.getLibConfig("weatherlib", "extraWeathers") then
            possible_types = Utils.merge(possible_types_a, Kristal.getLibConfig("weatherlib", "extraWeathers"))
        end

        if type(typer) == "string" then
            typer = {typer}
        end

        if typer and type(typer[2]) ~= "number" then
            for i, t in ipairs(typer) do
                if type(t) ~= "table" then
                    t = {t, 1}
                    table.remove(typer, i)
                    table.insert(typer, i, t)
                    --print(t[2])
                else
                    if #t < 2 then table.insert(t, 2, 1) end
                end
            end
            --print(typer[1])
        elseif typer and #typer == 2 and type(typer[2]) == "number" then
            typer = {typer}
        end

        if sfx == nil then sfx = true end

        if type(typer) == "table" then
            Utils.merge(weather_type, typer)
        end

        for i, symb in ipairs(weather_type) do
            for i, again in ipairs (symb) do if i == 1 then
                local number = 0
                for i, symb2 in ipairs(possible_types) do
                    if again == symb2 then number = number + 1 end
                end
                if number < 1 then wrongtype = true end
            end end
        end

        local haveoverlay = true
        if typer then for i, all in ipairs(typer) do
            --print(i, all[1])
            --print(all[i])
            if all[1] == "clear" then haveoverlay = false end
        end end

        if not typer or typer[1][1] == "none" then
            --if Game.stage.weathersounds then self.weathersounds:stop() end
            Game.stage.weather_type = nil
            Game.stage.keep_weather = nil
            if Game.stage.overlay then 
                if Game.stage.weather then
                    for i, o in ipairs(Game.stage.overlay) do
                        o[2]:remove()
                    end
                end
            end
            Game.stage.overlay = {}
            if Game.stage.weather then
                for i, weather in ipairs(Game.stage.weather) do
                    weather:remove()
                end
            end
            Game.stage.weather = {}
            Game.stage.weather_type = typer
            Game:setFlag("weather_save", false)

            --Game.stage.overlay = nil
            self.addto = nil
        elseif wrongtype then
            
            local first = typer[1][1]
            for i, ty in ipairs(typer) do
                if #typer > 1 and i > 1 then
                    first = first + " + " + ty[1]
                end
            end

            error("Attempt to set nonexistent weather \"" .. first .."\"")
        else
            
            --if Game.stage.weathersounds then self.weathersounds:stop() end
            Game.stage.weather_type = nil
            Game.stage.keep_weather = nil
            if Game.stage.overlay then 
                if Game.stage.weather then
                    for i, o in ipairs(Game.stage.overlay) do
                        o[2]:remove()
                    end
                end
            end
            if Game.stage.weather then
                for i, weather in ipairs(Game.stage.weather) do
                    weather:remove()
                end
            end
            self.weather = {}
            Game.stage.overlay = {}

            if keep then
                Game.stage.keep_weather = true
            end
            
            for i, typ in ipairs (typer) do
                --print(typ)
                local w
                local possible_types_again = {
                    "rain",
                    "thunder",
                    "snow",
                    "wind",
                    "volcanic",
                    "chilly",
                    "cloudy",
                    "overcast",
                    "dark_overcast",
                    "hot",
                    "clear",
                    "cd",
                }
                if Utils.containsValue(possible_types_again, typ[1]) then
                    w = Game.stage:addChild(WeatherHandler(typ[1], sfx, addto, typ[2], haveoverlay))
                    --print("A", typ[1])
                else
                    local b = WeatherRegistry.createWeatherData(typ[1], sfx, addto, typ[2], haveoverlay)

                    --print(b.type, "type")
                    w = Game.stage:addChild(b)
                    --print("B")]]
                end
                table.insert(self.weather, w)
            end

            local first = typer[1][1]
            for i, ty in ipairs(typer) do
                if #typer > 1 then
                    first = first + " + " + ty[1]
                end
            end
            Game.stage.weather_type = first
            Game.stage.last_weather = {typer, keep, sfx, addto}
            Game:setFlag("weather_save", {typer, keep, sfx})
            if Game.world.map.inside or Game.world.map.data.properties["inside"] then Game.stage:pauseWeather("inside") end
            --print(typer)
            self.addto = addto
        end
    end)

    Utils.hook(Stage, "hasWeather", function(orig, self, weather)
        orig(self)
        if Game.stage.weather then
            if not weather then
                return (#Game.stage.weather > 0)
            else
                for i, w in ipairs(Game.stage.weather) do
                    if w.type == weather then
                        return true
                    end
                end
            end
            return false
        end
    end)

    Utils.hook(Stage, "getWeatherParent", function(orig, self)
        if Game.battle then
            return Game.battle
        elseif Game.world then
            return Game.world
        end

        return false
    end)

    Utils.hook(Stage, "resetWeather", function(orig, self)
        self:setWeather()
    end)

    Utils.hook(Stage, "pauseWeather", function(orig, self, reason)
        if not self.wpaused then
            if Game.stage.overlay then 
                if Game.stage.weather then
                    for i, o in ipairs(Game.stage.overlay) do
                        o.paused = true
                    end
                end
            end
            if Game.stage.weather then
                for i, weather in ipairs(Game.stage.weather) do
                    weather.pause = true
                    weather.weathersounds.volume = weather.weathersounds.volume / 4
                    weather.weathersounds.pitch = weather.weathersounds.pitch - 0.09
                end
            end

            Game.stage.wpaused = true
            if reason then Game.stage.pause_reason = reason end
        end
    end)

    Utils.hook(Stage, "playWeather", function(orig, self)
        if not self.wpaused then
            error("WEATHERLIB: Attempt to play when not paused")
        else
            if Game.stage.overlay then 
                if Game.stage.weather then
                    for i, o in ipairs(Game.stage.overlay) do
                        o.paused = false
                    end
                end
            end
            if Game.stage.weather then
                for i, weather in ipairs(Game.stage.weather) do
                    weather.pause = false
                    weather.weathersounds.volume = weather.weathersounds.volume * 4
                    weather.weathersounds.pitch = weather.weathersounds.pitch + 0.09
                end
            end
        end

        Game.stage.wpaused = false
        Game.stage.pause_reason = nil
    end)

    Utils.hook(Stage, "keepWeather", function(orig, self, keep)
        if keep == nil then keep = true end
        
        if keep then self.keep_weather = true else self.keep_weather = false end
    end)

    Utils.hook(Stage,  "addWeatherOverlays", function(orig, self)
        orig(self)

        local possible_overlays = {
            "chilly",
            "overcast",
            "dark_overcast",
            "hot",
            "clear",
            "cd",
        }

        local number = 0
        if not Game.stage.weather or #Game.stage.weather < 1 then return end

        for i, weather in ipairs(Game.stage.weather) do
            if weather.type == "clear" then number = 1 return end
        end
        if number == 0 then for i, weather in ipairs(Game.stage.weather) do
            local overlay = weather:addOverlay()
            table.insert(Game.stage.overlay, overlay)
        end end
    end)

    Utils.hook(Sprite, "drawAlpha", function(orig, self, alpha)
        local r,g,b,a = self:getDrawColor()
        a = alpha
        local function drawSprite(...)
            if self.crossfade_alpha > 0 and self.crossfade_texture ~= nil then
                Draw.setColor(r, g, b, self.crossfade_out and Utils.lerp(a, 0, self.crossfade_alpha) or alpha)
                Draw.draw(self.texture, ...)
    
                Draw.setColor(r, g, b, Utils.lerp(0, a, self.crossfade_alpha))
                Draw.draw(self.crossfade_texture, ...)
            else
                Draw.setColor(r, g, b, alpha)
                Draw.draw(self.texture, ...)
            end
        end
        if self.texture then
            if self.wrap_texture_x or self.wrap_texture_y then
                local screen_l, screen_u = love.graphics.inverseTransformPoint(0, 0)
                local screen_r, screen_d = love.graphics.inverseTransformPoint(SCREEN_WIDTH, SCREEN_HEIGHT)
    
                local x1, y1 = math.min(screen_l, screen_r), math.min(screen_u, screen_d)
                local x2, y2 = math.max(screen_l, screen_r), math.max(screen_u, screen_d)
    
                local x_offset = math.floor(x1 / self.texture:getWidth()) * self.texture:getWidth()
                local y_offset = math.floor(y1 / self.texture:getHeight()) * self.texture:getHeight()
    
                local wrap_width = math.ceil((x2 - x_offset) / self.texture:getWidth())
                local wrap_height = math.ceil((y2 - y_offset) / self.texture:getHeight())
    
                if self.wrap_texture_x and self.wrap_texture_y then
                    for i = 1, wrap_width do
                        for j = 1, wrap_height do
                            drawSprite(x_offset + (i-1) * self.texture:getWidth(), y_offset + (j-1) * self.texture:getHeight())
                        end
                    end
                elseif self.wrap_texture_x then
                    for i = 1, wrap_width do
                        drawSprite(x_offset + (i-1) * self.texture:getWidth(), 0)
                    end
                elseif self.wrap_texture_y then
                    for j = 1, wrap_height do
                        drawSprite(0, y_offset + (j-1) * self.texture:getHeight())
                    end
                end
            else
                drawSprite()
            end
        end
    
        Object.draw(self)
    end)

    --[[Utils.hook(Map, "load", function(orig, self)
        orig(self)
        local weather = Game.stage.last_weather

        if not Game.stage.keep_weather then Game.stage:resetWeather() end

        if self.inside or self.data.properties["inside"] and Game.stage.keep_weather then
            Game.stage:pauseWeather("inside")
        else
            if Game.stage.keep_weather and Game.stage.pause_reason == "inside" then Game.stage:playWeather() end
        end
    end)]]

    Utils.hook(World, "setupMap", function(orig, self, map, ...)
        orig(self, map, ...)
        local weather = Game.stage.last_weather

        Game.stage.overlay = {}
        if Game.stage.keep_weather then
            if self.map.inside or self.map.data.properties["inside"] then
                Game.stage:pauseWeather("inside")
            else
                if Game.stage.pause_reason == "inside" then Game.stage:playWeather() end
            end
            --Game.stage:addWeatherOverlays()
        else
            Game.stage:resetWeather()
        end
    end)

    Utils.hook(Object, "onAddToStage", function(orig, self, stage)
        orig(self)

        if Game.stage then
            local NONONO = {
                LightMenu,
                LightItemMenu,
                LightCellMenu,
                LightStatMenu,
                BattleUI,
                TensionBar,
                Textbox,
                DustPiece
            }

            local number = 0
            for i, cc in ipairs(NONONO) do
                if self:includes(cc) then
                    number = number + 1
                    break
                end
            end

            local yes = true
            if number ~= 0 then yes = false end

            local yes2 = false
            if Game.stage:hasWeather("volcanic") or Game.stage:hasWeather("hot") then yes2 = true end

            local yes3 = false
            if not self:getFX("wave_fx") then yes3 = true end

            if Game.stage and Game.stage.weather and yes and yes2 and yes3 then

                local wave_shader = love.graphics.newShader([[
                    extern number wave_sine;
                    extern number wave_mag;
                    extern number wave_height;
                    extern vec2 texsize;
                    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
                    {
                        number i = texture_coords.x * texsize.x;
                        vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + 0.0)), max(0.0, min(1.0, texture_coords.y + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.y)));
                        return Texel(texture, coords) * color;
                    }
                ]])
                
                local wave_fx = ShaderFX(wave_shader, {
                    ["wave_sine"] = function() return Kristal.getTime() * 50 end,
                    ["wave_mag"] = function () return 0.5 end,
                    ["wave_height"] = function () return 8 end,
                    ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
                }, false, 10)

                self:addFX(wave_fx, "wave_fx")
            end
        end
    end)

    --[[Utils.hook(Stage, "update", function(orig, self)
        orig(self)
        if Game.stage.overlay and #Game.stage.overlay > 1 then
            local possible_types = {
                "rain",
                "thunder",
                "snow",
                "wind",
                "volcanic",
                "chilly",
                "cloudy",
                "overcast",
                "dark_overcast",
                "hot",
                "cd",
            }
            local tabler = {}
            for i = #possible_types, 1, -1 do
                table.insert(tabler, 0)
            end
            for i, o in ipairs(Game.stage.overlay) do
                for ir, pt in ipairs(possible_types) do
                    if o.type == pt then tabler[ir] = tabler[ir] + 1 end
                end
            end
            for i, numb in ipairs(tabler) do
                if numb > 1 then
                    for it, ov in ipairs(Game.stage.overlay) do
                        if ov.type == possible_types[i] then
                            ov:remove()
                            break
                        end
                    end
                end
            end
        end
    end)]]
    
    Utils.hook(Battle, "postInit", function(orig, self, state, encounter)
        orig(self, state, encounter)

        if not self.encounter.background then if #Game.stage.weather > 0 then
            for i, w in ipairs(Game.stage.weather) do
                w.addto = self end
            end
        end
    end)

    Utils.hook(Battle, "onStateChange", function(orig, self, old, new)
        orig(self, old, new)

        if new == "TRANSITIONOUT" then
            if not self.encounter.background then if #Game.stage.weather > 0 then
                for i, w in ipairs(Game.stage.weather) do
                    w.addto = Game.world end
                end
            end
        end
    end)
end

function WeatherLib:postInit()
    local weather = Game:getFlag("weather_save")
    --print(weather, " (this is the weather)")
    if weather and weather[1] then
        Game.stage:setWeather(weather[1], weather[2], weather[3], Game.stage:getWeatherParent())
    end
end

return WeatherLib