return function (cutscene, event, self)

    local p1 = cutscene:getCharacter(Game.party[1].actor.id)
	local p2 if Game.party[2] then p2 = cutscene:getCharacter(Game.party[2].actor.id) end
	local p3 if Game.party[3] then p3 = cutscene:getCharacter(Game.party[3].actor.id) end
	local p4 if Game.party[4] then p4 = cutscene:getCharacter(Game.party[4].actor.id) end

    local hue = 0

    Assets.playSound("warp_future")
    cutscene:fadeOut(1, {color = {1, 1, 1}, music = 1, global = true, wait = true})
    cutscene:wait(3)
    local warpbg = Sprite("world/cutscenes/timewarp_og", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    warpbg:setScale(2)
    warpbg:setOrigin(0.5)
    Game.stage:addChild(warpbg)

    local bg_wave = ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 20,
        ["wave_height"] = 30,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    })
    warpbg:addFX(bg_wave, "funky_mode")

    -- Create fake players: Taken from LightTransition
    local fake_players = {}
    -- p1
    p1.visible = false
	fake_players[1] = Sprite("party/"..p1.actor.id:lower().."/dark_transition/dark", SCREEN_WIDTH/2 + 50, SCREEN_HEIGHT + 50)
	fake_players[1]:setAnimation{"party/"..p1.actor.id:lower().."/dark_transition/dark", 0.1, true}
	fake_players[1]:setScale(2)
	fake_players[1]:setOrigin(0.5)
	Game.stage:addChild(fake_players[1])



	-- p2
	if p2 then
		p2.visible = false
		fake_players[2] = Sprite("party/"..p2.actor.id:lower().."/dark_transition/dark", SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT + 50)
		fake_players[2]:setAnimation{"party/"..p2.actor.id:lower().."/dark_transition/dark", 0.1, true}
		fake_players[2]:setScale(2)
		fake_players[2]:setOrigin(0.5)
		Game.stage:addChild(fake_players[2])
	end



	-- p3
	if p3 then
		p3.visible = false
		fake_players[3] = Sprite("party/"..p3.actor.id:lower().."/dark_transition/dark", p3.x, p3.y)
		fake_players[3]:setAnimation{"party/"..p3.actor.id:lower().."/dark_transition/dark", 0.1, true}
		fake_players[3]:setScale(2)
		fake_players[3]:setOrigin(0.5)
		Game.stage:addChild(fake_players[3])
	end



	-- p4
	if p4 then
		p4.visible = false
		fake_players[4] = Sprite("party/"..p4.actor.id:lower().."/dark_transition/dark", p4.x, p4.y)
		fake_players[4]:setAnimation{"party/"..p4.actor.id:lower().."/dark_transition/dark", 0.1, true}
		fake_players[4]:setScale(2)
		fake_players[4]:setOrigin(0.5)
		Game.stage:addChild(fake_players[4])
	end


    cutscene:during(function ()
        if warpbg then
            hue = hue + DTMULT/128
            hue = Utils.clampWrap(hue, 150/360, 300/360)

            -- Just in case
            if hue > (300/360) then
                hue = hue - (300/360 - 150/360)
            end
            warpbg:setColor(Utils.hslToRgb(hue, 0.75, 0.8))

        end

        for i, _ in ipairs(fake_players) do
            local star = Sprite("effects/timewarp/particle", _.x, _.y + 20)
            star:play(1/30)
            star:setScale(2)
			star:setParallax(0, 0)
			star:setOrigin(0.5, 0.5)
			star.rotation = Utils.random(0, 12)
			star.graphics.spin = -1/30
			star.physics.speed_y = Utils.random(5, 10)
            star.physics.speed_x = Utils.random(-5, 5)
			star.physics.friction = 0.005
			star:fadeOutAndRemove(1)
			Game.stage:addChild(star)
        end



    end, false)


    
    
    local music = Music("TimeWarp", 0.5)
    music:play()
    music.source:setLooping(false)

    cutscene:fadeIn(1, {global = true})
    cutscene:wait(1)

    cutscene:slideTo(fake_players[1], SCREEN_WIDTH/2 + 50, SCREEN_HEIGHT/2, 1.5, "out-back")
    if fake_players[2] then
        cutscene:slideTo(fake_players[2], SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2, 1.5, "out-back")
    end

    cutscene:wait(3)

    cutscene:slideTo(fake_players[1], SCREEN_WIDTH/2 + 50, -50, 1.5, "in-back")
    if fake_players[2] then
        cutscene:slideTo(fake_players[2], SCREEN_WIDTH/2 - 50, -50, 1.5, "in-back")
    end

    cutscene:wait(1.5)

    cutscene:fadeOut(0.2, {color = {1, 1, 1}, global = true, wait = true})

    cutscene:wait(function ()
       return not music:isPlaying() 
    end)

    -- Cleanup
    warpbg:remove()
    for i in ipairs(Game.party) do
        fake_players[i]:remove()
    end

    p1.visible = true
    if p2 then p2.visible = true end
    if p3 then p3.visible = true end
    if p4 then p4.visible = true end

    cutscene:fadeIn(0.2, {music = true, global = true})

end