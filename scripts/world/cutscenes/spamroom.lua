return {
    amogus = function(cutscene, event)
    	local sus = cutscene:getCharacter("spamongus")
        if sus.interact_count == 0 then
            sus:setAnimation("dead")
            Assets.playSound("amoguskill", 0.7, 1)
		else
            cutscene:text("* Spamongus was the imposter.")
        end
    end,
    mandela = function(cutscene, event)
        cutscene:showNametag("Alternate Spamton")
        cutscene:text("* REMEMB3R TO FOLLOW THE [T.H.I.N.K] PRINCIPLE, YOU [Little Sponge]!!", "", "alternatespam")
        cutscene:hideNametag()
    end,
    soapton = function(cutscene, event)
        cutscene:text("* There's a tagline written on the soap bar here...")
        cutscene:text("* SPAMTON [Rank A] CLEANING SOAP\n* PERFECT FOR WASHING YOUR [Sorry @$$] AWAY!!")
    end,
    poster = function(cutscene, event)
        cutscene:text("* (The poster is torn,[wait:5] revealing\na faded one underneath.)")
        cutscene:text("* BIG SHOT AUTOS![wait:5] TAKE A RIDE\nAROUND TOWN IN OUR SPECIAL")
        cutscene:text("* (The rest is cut off.)")
    end,

	-- ┌───────────────────────┐ --
	-- │     The Warp Bin      │ --
	-- └───────────────────────┘ --
	warpbin = function(cutscene, event)
        cutscene:text("* It's the warp bin.")
        cutscene:text("* Would you like to warp?[wait:10]\n* You only need the code.")
		
		if cutscene:choicer({"Sure", "Nope"}) == 2 then
			return
		end

		local binBox = UIBox((SCREEN_WIDTH / 2) - 64, 256, 128, 32)
		binBox.parallax_x = 0
		binBox.parallax_y = 0
		Game.world:addChild(binBox)
		local binInputDisp = Text("", (SCREEN_WIDTH / 2) - 64, 256, 640, 480)
		binInputDisp.parallax_x = 0
		binInputDisp.parallax_y = 0
		Game.world:addChild(binInputDisp)

		local binInput = {""}
		local inputDone = false
		TextInput.attachInput(binInput, {
			multiline = false,
			enter_submits = true,
			clear_after_submit = false,
			x = 0,
			y = 0,
		})
		TextInput.text_callback = function()
			if #binInput[1] > 8 then -- Limit the Bin's Digits
				binInput[1] = string.sub(binInput[1], 1, 8)
			end
			-- only lowercase letters
			binInput[1] = string.lower(binInput[1])
		end
		cutscene:during(function()
			if not inputDone then
				if #binInput[1] < 8 then
					binInputDisp:setText(binInput[1].."_")
				else
					binInputDisp:setText(binInput[1])
				end
			end
		end)
		TextInput.submit_callback = function()
			inputDone = true
		end
		
		cutscene:wait(function() return inputDone end)
		binInputDisp:remove()
		binBox:remove()
		TextInput.endInput()
		
		local result = Mod:getBinCode(Game.binInput[1])
		if result then
			if type(result[2]) == "string" then
				if Game.world.map.id == result[2] then
					cutscene:text("* But you're already there.")
					break
				end
			
				cutscene:wait(0.2)
				-- Hell naw is this the only way to stop all sounds
				-- for now?
				for key,_ in pairs(Assets.sound_instances) do
					Assets.stopSound(key, true)
				end
				Assets.playSound("impact")
				Game.world.music:stop()

				Game.world.fader:fadeOut(nil, {
					speed = 0,
				})
				cutscene:wait(1)
				cutscene:loadMap(result[2], result[3], "down")
				Game.world.fader:fadeIn(nil, {
					speed = 0.25,
				})
			else
				cutscene:after(result[2])
			end
		else
			cutscene:text("* That doesn't seem to work.")
		end
    end,
}