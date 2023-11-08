return function (cutscene, event, self)

    local hue = 0

    Assets.playSound("warp_future")
    cutscene:fadeOut(1, {color = {1, 1, 1}, music = 1, global = true, wait = true})
    cutscene:wait(3)
    local warpbg = Sprite("world/cutscenes/timewarp_og", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    warpbg:setScale(2)
    warpbg:setOrigin(0.5)
    Game.stage:addChild(warpbg)

    local bg_wave = ShaderFX(Mod.wave_shader, {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 20,
        ["wave_height"] = 30,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    })
    warpbg:addFX(bg_wave, "funky_mode")

    cutscene:during(function ()
        if warpbg then
            hue = hue + DTMULT/128
            hue = Utils.clampWrap(hue, 150/360, 300/360)

            -- Just in case
            if hue > (300/360) then
                hue = hue - (300/360 - 150/360)
            end
            
            Log:print(hue)
            warpbg:setColor(Utils.hslToRgb(hue, 0.75, 0.8))

        end

    end, false)
    
    local music = Music("TimeWarp")
    music:play()
    music.source:setLooping(false)

    cutscene:fadeIn(0.2, {global = true})

    cutscene:wait(5.5)

    cutscene:fadeOut(0.2, {color = {1, 1, 1}, global = true, wait = true})

    cutscene:wait(function ()
       return not music:isPlaying() 
    end)

    warpbg:remove()
    cutscene:fadeIn(0.2, {music = true, global = true})

end