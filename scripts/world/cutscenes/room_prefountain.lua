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
		cutscene:playSound("moss_fanfare")
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
		local function textFinish(text)
			return function() return text.done end
		end
		local function showText(obj, tbl, prefix)
			prefix = prefix or "[noskip][speed:0.3][spacing:1.75]"
			local _tbl
			if type(tbl) ~= "table" then
				_tbl = {tbl}
			else
				_tbl = Utils.copy(tbl)
			end
			for i, v in ipairs(_tbl) do
				_tbl[i] = prefix .. v
			end
			obj:setText(_tbl)
			return textFinish(obj)
		end

		local used_fountain_once = Game:getFlag("used_fountain_once", false)

		cutscene:detachFollowers()
		cutscene:wait(cutscene:fadeOut(0)) -- remove fadein
		cutscene:fadeIn(3)

		local members = {}
		local party_poss = {
			{ initial = {320, 600}, walk_up = {380, 10} },
			{ initial = {250, 640}, walk_up = {420, 10} },
			{ initial = {380, 680}, walk_up = {460, 10} },
		}
		local party_walk_up_wait = nil
		for i, member in ipairs(Game.party) do
			local me_actor = cutscene:getCharacter(member.id)
			table.insert(members, me_actor)
			local pos = party_poss[i]
			me_actor:setPosition(unpack(pos.initial))
			party_walk_up_wait = cutscene:walkTo(me_actor, me_actor.x, unpack(pos.walk_up))
		end
		local leader = members[1]
		local fountain = Game.world:getEvent(2)

		cutscene:wait(party_walk_up_wait)
		cutscene:wait(3)

		local text = DialogueText({"ass"}, 100, 80, (SCREEN_WIDTH - 100 * 2) + 14, SCREEN_HEIGHT, nil, "dark")
		text:setLayer(WORLD_LAYERS["textbox"])
		Game.world:addChild(text)

		local first_diag = {
			"[voice:susie]So here's the fountain of this place...",
			"It feels... so different from the previous ones.",
			"Like it's way more powerful... and stable.",
			"Is it what [color:blue]PURE DARKNESS[color:reset] is like?",
			"...",
			"Something tells me we might not be able to seal it.",
			members[1].id == "kris"
				and "But I guess we can still try.\nRight, Kris?"
				or string.format("Actually, %s... Can you even seal one?", members[1].actor.name)
		}
		if used_fountain_once then
			first_diag = {"[voice:nil](Do you want to return to the Light World?)"}
		end
		cutscene:wait(showText(text, first_diag))
		text.alpha = 0 -- hide

		if cutscene:choicer({"Yes", "No"}) == 1 then
			cutscene:wait(cutscene:walkTo(leader, leader.x, 330, 2))
			cutscene:wait(2)

			text.alpha = 1 -- show
			cutscene:wait(showText(text, "[voice:nil](It was as if your very SOUL was glowing...)"))
			text:remove()

			Game.world.music:stop()

			local soul = Sprite("player/heart", leader.x, (leader.y - leader.height / 2) - 8)
			soul.color = {1, 0, 0}
			soul.layer = WORLD_LAYERS["top"]
			soul:setOrigin(0.5, 0.5)
			Game.world:addChild(soul)
			local function generateSoulAfterimage()
				Game.world.timer:everyInstant(0.1, function()
					local image = AfterImage(soul, 0.5)
					image.graphics.grow = 0.3
					Game.world:addChild(image)
				end, 3)
			end
			generateSoulAfterimage()
			cutscene:playSound("snd_great_shine")
			cutscene:wait(1)

			cutscene:playSound("snd_usefountain")
			cutscene:wait(50/30)
			fountain.adjust = 1
			Game.world.timer:tween(170/30, soul, {y = 160})
			Game.world.timer:everyInstant(1/30, function()
				fountain.eyebody = fountain.eyebody * 0.98
			end, 170/30)
			cutscene:wait(170/30)
			fountain.adjust = 2

			cutscene:wait(3)
			cutscene:playSound("revival")
			generateSoulAfterimage()
			local flash_parts = {}
			local flash_part_num = 11
			for i = 1, flash_part_num do
				local part = Rectangle(SCREEN_WIDTH / 2, 0, i*i, 500)
				part:setOrigin(0.5, 0)
				part.color = {1, 1, 1}
				part.layer = soul.layer - i
				part.graphics.grow_x = 0.5*i / 4
				part.alpha = 0
				part.graphics.fade = (0.5 / 16) / 2
				part.graphics.fade_to = 1 - (i / 12)
				table.insert(flash_parts, part)
				Game.world:addChild(part)
			end
			cutscene:wait(50/30)
			local hider = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			hider:setColor(1, 1, 1, 0)
			hider.graphics.fade = 0.02
			hider.graphics.fade_to = 1
			hider:setLayer(soul.layer + 50)
			Game.world:addChild(hider)
			cutscene:wait(70/30)
			local hider2 = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			hider2:setColor(0, 0, 0, 0)
			hider2.graphics.fade = 0.01
			hider2.graphics.fade_to = 1
			hider2:setLayer(soul.layer + 50)
			Game.world:addChild(hider2)

			cutscene:wait(130/30)
			cutscene:wait(cutscene:fadeOut(1, {color = {1, 1, 1}}))
			Game:setFlag("used_fountain_once", true)
			cutscene:mapTransition("warphub") -- temporary
			cutscene:fadeIn(1)
			Kristal.showBorder(1)
		else
			cutscene:wait(2)

			if not used_fountain_once then
				text.alpha = 1
				cutscene:wait(showText(text, {
					"It may be better this way.",
					"After all, our adventures here aren't over yet."
				}))
			end
			text:remove()

			local walk_down_wait = nil
			for _, member in ipairs(members) do
				walk_down_wait = cutscene:walkTo(member, member.x, 600, not used_fountain_once and 10 or 5)
			end
			cutscene:wait(walk_down_wait)
			cutscene:wait(not used_fountain_once and 2 or 0.5)
			cutscene:wait(cutscene:fadeOut(not used_fountain_once and 3 or 2))
			cutscene:mapTransition("room_prefountain", "entry_fountain", "down")
			cutscene:fadeIn(0.5)
			Kristal.showBorder(0.5)
		end
	end,
}
