return {
    amogus = function(cutscene, event)
    local sus = cutscene:getCharacter("spamongus")
        if sus.interacted then
            cutscene:text("* Spamongus was the imposter.")
        end
        if not sus.interacted then
            sus:setAnimation("dead")
            Assets.playSound("amoguskill", 0.7, 1)
            sus.interacted = true
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
		cutscene:choicer({"Sure", "Nope"})
		
		if cutscene.choice == 1 then
			
			
			
			local afterCode = false
			BinText.visible = true
			BinRect.visible = true
			Game.binInput[1] = ""
			
			TextInput.attachInput(Game.binInput, {
				multiline = false,
				enter_submits = true,
				clear_after_submit = false,
				x = 0,
				y = 0,
			})
			TextInput.submit_callback = function()
				afterCode = true
			end
			TextInput.text_callback = function()
				if #Game.binInput[1] > 8 then -- Limit the Bin's Digits
					Game.binInput[1] = string.sub(Game.binInput[1], 1, 8)
				end
				-- only lowercase letters
				Game.binInput[1] = string.lower(Game.binInput[1])
			end
			
			
			
			cutscene:wait(function() return afterCode end)
			BinText.visible = false
			BinRect.visible = false
			local gotCode = false
			TextInput.endInput()
			
			for i=1,#binCodes do
				if binCodes[i][1] == Game.binInput[1] then
					
					gotCode = true
					
					
					if type(binCodes[i][2]) == "string" then
					
						if Game.world.map.id == binCodes[i][2] then
							cutscene:text("* But you're already there.")
							break
						end
					
						cutscene:wait(0.2)
						for key,_ in pairs(Assets.sound_instances) do
							Assets.stopSound(key, true)
						end
						Assets.playSound("impact")
						Game.world.music:stop()
						Game.world.fader:fadeOut(nil, {
							speed = 0,
						})
						cutscene:wait(1)
						cutscene:loadMap(binCodes[i][2], binCodes[i][3] or "spawn", "down")
						Game.world.fader:fadeIn(nil, {
							speed = 0.25,
						})
					else
						cutscene.finished_callback = binCodes[i][2]
					end
					
					
				end
			end
			
			if not gotCode then
				cutscene:text("* That doesn't seem to work.")
			end
			
		
		end
		
    end,
}