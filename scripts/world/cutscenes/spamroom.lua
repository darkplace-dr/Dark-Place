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
			menu.finish_cb = function(_action)
				-- I'm sorry
				Game.world:startCutscene("spamroom", "warpbin_proc")
			end
			Game.world:openMenu(menu)
		end)
	end,

	warpbin_proc = function(cutscene, action)
		if action then
			if type(action.result) == "string" then
				if Game.world.map.id == action.result then
					cutscene:text("* But you're already there.")
				else
					cutscene:wait(0.2)

					Game.world.music:stop()
					-- Hell naw is this the only way to stop all sounds
					-- for now?
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
				end
			else
				action.result(cutscene)
			end
		else
			cutscene:text("* That doesn't seem to work.")
		end
    end,
}