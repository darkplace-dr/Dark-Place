return {
    amogus = function(cutscene, sus)
        if sus.interact_count == 1 then
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
	cungadero = function(cutscene, event)
		cutscene:showNametag("Cungadero Spamton")
		cutscene:text("* Take a ride around town on our special Cungadero!", "", "cungaderospamton")
		event:setSprite("smile")
		cutscene:text("* Hey everybody![wait:10]\n* It's me!", "", "cungaderospamton")
		event:setSprite("wink")
		cutscene:text("* Everybody's favorite salseman,[wait:5] Spamton G. Spamton!", "", "cungaderospamton")
		event:setSprite("neutral")
		if cutscene:getCharacter("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Uh,[wait:5] why is your car parked on the sidewalk?", "neutral", "susie")
			cutscene:showNametag("Cungadero Spamton")
			event:setSprite("wink")
			cutscene:text("* Why,[wait:5] to show it off,[wait:5] of course!", "", "cungaderospamton")
			event:setSprite("neutral")
			cutscene:text("* I would of gotten here sooner if I hadn't got into traffic.", "", "cungaderospamton")
			event:setSprite("angry")
			cutscene:text("* WHY WAS I STUCK IN TRAFFIC?![wait:10]\n* DON'T THEY KNOW?[wait:10]\n* DON'T THEY KNOW WHO I AM?!", "", "cungaderospamton")
			event:setSprite("sideeye")
			cutscene:text("[noskip][speed:0.3]* ...", "", "cungaderospamton")
			event:setSprite("wink")
			cutscene:text("* Spamton G. Spamton,[wait:5] that's who I am!", "", "cungaderospamton")
			event:setSprite("rage")
			cutscene:text("* AAAAAAAAAARGH!!!", "", "cungaderospamton")
			event:setSprite("neutral")
		end
		if cutscene:getCharacter("dess") then
			cutscene:showNametag("Dess")
			cutscene:text("* yooooo is that the uhhhhh big shot guy????", "neutral", "dess")
			cutscene:showNametag("Cungadero Spamton")
			event:setSprite("wink")
			cutscene:text("* Ah,[wait:5] a loyal fan I see.", "", "cungaderospamton")
			cutscene:showNametag("Dess")
			cutscene:text("* who said I actually liked you lmfao", "condescending", "dess")
			cutscene:showNametag("Cungadero Spamton")
			event:setSprite("shock")
			cutscene:text("[noskip][speed:0.3]* ...", "", "cungaderospamton")
			event:setSprite("neutral")
		end
		if cutscene:getCharacter("brandon") then
			cutscene:showNametag("Brandon")
			cutscene:text("* Woah,[wait:5] it's sureal seeing you before you lost your marbles.", "neutral", "brandon")
			cutscene:showNametag("Cungadero Spamton")
			event:setSprite("shock")
			cutscene:text("* Uh...[wait:10] what?", "", "cungaderospamton")
			cutscene:showNametag("Brandon")
			cutscene:text("* Oh,[wait:5] nothing,[wait:5] nothing!", "blush", "brandon")
			event:setSprite("neutral")
		end
		event:setSprite("happy")
		cutscene:hideNametag()
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

		cutscene:after(function()
			local menu = WarpBinInputMenu()
			-- I'm sorry
			menu.finish_cb = function(action)
				Game.world:startCutscene("spamroom", "warpbin_proc", action)
			end
			Game.world:openMenu(menu)
		end)
	end,

	warpbin_proc = function(cutscene, action)
		if not action then
			cutscene:text("* That doesn't seem to work.")
			return
		end

		if type(action.result) == "string" then
			if Game.world.map.id == action.result then
				cutscene:text("* But you're already there.")
				return
			end

			cutscene:wait(0.2)

			Game.world.music:stop()
			-- Hell naw is this the only way to stop all sounds?
			for key,_ in pairs(Assets.sound_instances) do
				Assets.stopSound(key, true)
			end
			Game.world.fader:fadeOut(nil, {
				speed = 0,
			})
			cutscene:playSound("impact")

			cutscene:wait(1)
			cutscene:loadMap(action.result, action.marker, "down")
			Game.world.fader:fadeIn(nil, {
				speed = 0.25,
			})
		else
			action.result(cutscene)
		end
    end,
}