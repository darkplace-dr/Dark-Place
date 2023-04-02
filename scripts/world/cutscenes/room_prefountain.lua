return {
	moss = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local susie_party = Game:getPartyMember("susie")
		local fstmem = Game.party[1]

		if Game:getFlag("globalEatenMossFlag") then
			cutscene:text("* (Moss. There's not enough to eat.)")
			return
		end

		Game.world.music:fade(0, 0.05)
		Game.world.music:pause()
		Assets.playSound("moss_fanfare")
		cutscene:text("[noskip]* You found the [color:green][Moss][color:white]![wait:3s]")
		Game.world.music:resume()
		Game.world.music:fade(1, 1)

		if fstmem.id == "kris" or fstmem.id == "YOU" or fstmem.id == "susie" then
			cutscene:text("* Your title was upgraded to [Moss Finder].")
			fstmem.title = "Moss Finder\nBasic moss-finding\nabilities."
		end

		if susie and susie_party then
			if fstmem.id ~= "susie" then
				susie_party.title = "Moss Enjoyer\nSupports those that\nfind moss."
			end

			cutscene:showNametag("Susie")
			cutscene:setSpeaker("susie")
			cutscene:text("* Heck yeah, more moss!", "surprise_smile")
			cutscene:hideNametag()
		end

		Game.world.map:getEvent(37):remove() -- remove shine
		Game:setFlag("globalEatenMossFlag", true)
	end,

	moss2 = function(cutscene, event)
		cutscene:text("* (Moss. There's not enough to eat.)")
	end,

	prefountain1 = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")

		if not susie then
			return
		end

		cutscene:showNametag("Susie")
		cutscene:setSpeaker("susie")
		local fstmem = Game.party[1]
		if fstmem.id == "kris" then
			cutscene:text("* Hey, Kris, there's a... fountain, over there? Let's go seal it.", "smirk")
		elseif fstmem.id == "YOU" then
			cutscene:text("* Hey, Kr-[wait:3]YOU, there's a... fountain, over there? Let's go seal it. ", "smirk")
		else
			cutscene:text("* Hey, there's a... fountain, over there? Let's go seal it.", "smirk")
		end
		cutscene:hideNametag()

		Game:setFlag("seenPreFountain1Event1", true)
	end,

	fountain1 = function(cutscene, event)
		cutscene:detachFollowers()
		cutscene:wait(cutscene:fadeOut(0))
		cutscene:fadeIn(3)
		local members = {}
		for i=1,#Game.party do
			members[i] = cutscene:getCharacter(Game.party[i].id)
		end

		local pos = {}
		pos[1] = {320, 600}
		if #members==2 then
			pos[2] = {250, 640}
		end
		if #members==3 then
			pos[3] = {380, 680}
		end

		for i,member in ipairs(members) do
			member:setPosition(pos[i][1], pos[i][2])
		end

		if #members==1 then
			cutscene:wait(cutscene:walkTo(members[1], members[1].x, 380, 10))
		elseif #members==2 then
			cutscene:walkTo(members[1], members[1].x, 380, 10)
			cutscene:wait(cutscene:walkTo(members[2], members[2].x, 420, 10))
		elseif #members==3 then
			cutscene:walkTo(members[1], members[1].x, 380, 10)
			cutscene:walkTo(members[2], members[2].x, 420, 10)
			cutscene:wait(cutscene:walkTo(members[3], members[3].x, 460, 10))
		end

		cutscene:wait(3)

		local text = DialogueText({"ass"}, 70, 70, 500, 100, nil, "dark")
		if not Game:getFlag("used_fountain_once", false) then
			if members[1].id=="kris" then
				text:setText({
					"[noskip][voice:none][speed:0.3][spacing:3]So here's the fountain of\nthis place...",
					"[noskip][voice:none][speed:0.3][spacing:3]It feels... so different\nfrom the previous ones.",
					"[noskip][voice:none][speed:0.3][spacing:3]Like it's way more powerful...\nAnd stable.",
					"[noskip][voice:none][speed:0.3][spacing:3]Is it what [color:blue]PURE DARKNESS[color:reset] is like?",
					"[noskip][voice:none][speed:0.3][spacing:3]...",
					"[noskip][voice:none][speed:0.3][spacing:3]Something tells me we might\nnot even be able to seal it.",
					"[noskip][voice:none][speed:0.3][spacing:3]But I guess we can still try.\nRight, Kris?",
					--"Actually, YOU... Can you even seal one?"
				})
			else
				text:setText({
					"[noskip][voice:none][speed:0.3][spacing:3]So here's the fountain of\nthis place...",
					"[noskip][voice:none][speed:0.3][spacing:3]It feels... so different\nfrom the previous ones.",
					"[noskip][voice:none][speed:0.3][spacing:3]Like it's way more powerful... And stable.",
					"[noskip][voice:none][speed:0.3][spacing:3]Is it what [color:blue]PURE DARKNESS[color:reset] is like?",
					"[noskip][voice:none][speed:0.3][spacing:3]...",
					"[noskip][voice:none][speed:0.3][spacing:3]Something tells me we might not be able to seal it.",
					"[noskip][voice:none][speed:0.3][spacing:3]Actually, "..members[1].actor.name.."... Can you even seal one?"
				})
			end
		else
			text:setText("[noskip][voice:none][speed:0.3][spacing:3](Do you want to return to the Light World?)")
		end
		--text.state["speed"] = 0.3
		--text.state["spacing"] = 3
		--text.state["noskip"] = true
		text:setLayer(WORLD_LAYERS["top"])
		Game.world:addChild(text)

		cutscene:wait(function()
			return text.done
		end)

		text.alpha = 0

		local response = cutscene:choicer({"Yes", "No"})
		if response == 1 then
			local kris = members[1]
			cutscene:wait(cutscene:walkTo(kris, kris.x, 330, 2))
			cutscene:wait(2)
			text.alpha = 1
			text:setText("[noskip][voice:none][speed:0.3][spacing:3](It was as if your very SOUL was glowing...)")
			cutscene:wait(function()
				return text.done
			end)
			text:remove()
			Game.world.music:stop()


			local soul = Sprite("player/heart", kris.x, (kris.y-kris.height/2)-8)
	        soul.color={1, 0, 0}
	        --soul.rotation=math.rad(180)
	        soul.layer=WORLD_LAYERS["top"]+10
	        soul:setOrigin(0.5, 0.5)
	        Game.world:addChild(soul)
	        Game.world.timer:everyInstant(0.1, function()
	            local image=AfterImage(soul, 0.5)
	            image.graphics.grow=0.3
	            Game.world:addChild(image)
	        end, 3)
	        Assets.playSound("snd_great_shine")
	        cutscene:wait(2)
	        Assets.playSound("snd_usefountain")
	        cutscene:wait(0.5)
	        Game.world.timer:after(5, function()
	        	Game.world:getEvent(2).adjust = 1
	        end)
	        Game.world.timer:tween(7, soul, {y=130})
	        cutscene:wait(10)
	        Assets.playSound("revival")
	        Game.world.timer:everyInstant(0.1, function()
	            local image=AfterImage(soul, 0.5)
	            image.graphics.grow=0.3
	            Game.world:addChild(image)
	        end, 3)
	        local tab={}
	        for i=0, 4 do
	            local s=Rectangle(soul.x, soul.y, 1, 999)
	            s:setOrigin(0.5, 0.5)
	            s.color={1-0.1*i, 1-0.1*i, 1-0.1*i}
	            s.layer=soul.layer-(1+i)
	            s.graphics.grow=7+4*i
	            tab[i+1]=s
	            Game.world:addChild(s)
	        end
	        cutscene:wait(2)
	        local h_layer = soul.layer - 5
	        Game.world.timer:tween(1, soul, {alpha=0}, "linear", function()
	            soul:remove()
	        end)
	        cutscene:wait(1)
	        local hider=Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	        hider:setColor(0, 0, 0, 1)
	        hider:setLayer(h_layer)
	        Game.world:addChild(hider)
	        for i=1, 5 do
	            Game.world.timer:tween(4.5, tab[i], {alpha=0}, "linear", function()
	                tab[i]:remove()
	            end)
	        end

	        cutscene:wait(6)
	        cutscene:wait(cutscene:fadeOut(1, {color={1, 1, 1}}))
	        cutscene:mapTransition("warphub") -- "warphub" is temporary.
	        cutscene:fadeIn(1)
	        Kristal.showBorder(1)

	        Game:setFlag("used_fountain_once", true)
	        cutscene:endCutscene()
	    else
	    	cutscene:wait(2)
	    	if not Game:getFlag("used_fountain_once", false) then
		    	text.alpha = 1
				text:setText({
					"[noskip][voice:none][speed:0.3][spacing:3]It may be better this way.",
					"[noskip][voice:none][speed:0.3][spacing:3]After all, our adventures here aren't over yet."
				})

				cutscene:wait(function()
					return text.done
				end)
				text:remove()

				if #members==1 then
					cutscene:wait(cutscene:walkTo(members[1], members[1].x, 600, 10))
				elseif #members==2 then
					cutscene:walkTo(members[1], members[1].x, 600, 10)
					cutscene:wait(cutscene:walkTo(members[2], members[2].x, 600, 10))
				elseif #members==3 then
					cutscene:walkTo(members[1], members[1].x, 600, 10)
					cutscene:walkTo(members[2], members[2].x, 600, 10)
					cutscene:wait(cutscene:walkTo(members[3], members[3].x, 600, 10))
				end
				cutscene:wait(2)
				cutscene:wait(cutscene:fadeOut(3))
				cutscene:mapTransition("room_prefountain", "entry_fountain", "down")
				cutscene:fadeIn(0.5)
			else
				text:remove()

				if #members==1 then
					cutscene:wait(cutscene:walkTo(members[1], members[1].x, 600, 5))
				elseif #members==2 then
					cutscene:walkTo(members[1], members[1].x, 600, 5)
					cutscene:wait(cutscene:walkTo(members[2], members[2].x, 600, 5))
				elseif #members==3 then
					cutscene:walkTo(members[1], members[1].x, 600, 5)
					cutscene:walkTo(members[2], members[2].x, 600, 5)
					cutscene:wait(cutscene:walkTo(members[3], members[3].x, 600, 5))
				end
				cutscene:wait(0.5)
				cutscene:wait(cutscene:fadeOut(2))
				cutscene:wait(cutscene:mapTransition("room_prefountain", "entry_fountain", "down"))
				cutscene:fadeIn(0.5)
			end
		end
		
		--[[cutscene:text("* (As this is a fountain of [color:blue]PURE DARKNESS[color:white], it cannot be sealed.)")
		cutscene:text("* (Would you like to return to the LIGHT WORLD? You will be able to come back later.)")
		local response = cutscene:choicer({"Yes", "No"})
		if response == 1 then
			Assets.playSound("snd_great_shine")
			Assets.playSound("snd_usefountain")
			cutscene:fadeOut(5, {color={1,1,1}})
		else
			cutscene:endCutscene()
		end]]
	end,
}
