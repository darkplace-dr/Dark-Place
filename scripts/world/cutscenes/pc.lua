---@param cutscene WorldCutscene
return function(cutscene, event, chara)
	---@diagnostic disable-next-line: assign-type-mismatch
	local sprite = Game.world:getEvent(89) ---@type Sprite
	local t_c = "[color:#000099]"

	local function nothingText()
		if love.math.random(1, 10) == 1 then
			local nothing = Assets.playSound("nothing")
			Game.world.music:pause()
			cutscene:text(t_c.."[noskip]* [[speed:0.7]You get [wait:10]NOTHING!\n[wait:16]You lose![wait:30]\nGood day,[wait:2] sir!]",
				{advance = false, wait = false})
			cutscene:wait(function()
				return not cutscene.textbox:isTyping() and not nothing:isPlaying()
			end)
			Game.world.music:resume()
		else
			cutscene:text(t_c.."* [So you get nothing!]")
		end
	end

	sprite:setFrame(2)
	Assets.stopAndPlaySound("pc_on", 0.5)
	cutscene:text(t_c.."* [The PC is on!]")
	Assets.stopSound("pc_on")
	Assets.stopAndPlaySound("pc_enter", 0.5)
	cutscene:text(t_c.."* [What do you want to do?]")

	::choice::
	local c = cutscene:choicer({"Get Gifts", "What's that?", "Turn off"})

	if c == 1 then
		cutscene:text(t_c.."* [Alright,[wait:2] let's see what we have for you today...]")
		cutscene:text(t_c.."* [speed:0.1][...]")
		if love.system.getOS() == "Android" or love.system.getOS() == "iOS" then
			cutscene:text(t_c.."* [Unfortunately,[wait:2] I cannot check for save files on a "..love.system.getOS().." system.]")
			nothingText()
			goto turnoff
		end

		local gifts = Mod.pc_gifts_data
		local gift_status = Game:getFlag("pc_gifts_status")
		local new_gifts = {}
		for game,data in pairs(gifts) do
			if gift_status[game] then goto continue end

			local kristal, start = game:find("KR_")
			if kristal then
				if game == "KR_wii_bios"
					and Mod:hasWiiBIOS()
					or Mod:hasSaveFiles(game:sub(start+1), data.file or nil, data.fused_identify) then
					table.insert(new_gifts, game)
				end
			else
				local files = type(data.file) == "string" and {data.file} or data.file
				for _,file in ipairs(files) do
					if Mod:fileExists((data.prefix_os[love.system.getOS():gsub(" ", "_")] or "").."/"..file)
						or ((love.system.getOS() == "Linux" and data.prefix_os["Windows"])
						and Mod:fileExists(data.prefix_os["Windows"].."/"..file, true, data.wine_steam_appid)) then
						table.insert(new_gifts, game)
						break
					end
				end
			end

			::continue::
		end

		if #new_gifts <= 0 then
			cutscene:text(t_c.."* [Nope![wait:3] There's nothing new for you!]")
			nothingText()
			goto turnoff
		end
		for i,gift in ipairs(new_gifts) do
			local kristal, start = gift:find("KR_")
			local game_name = gifts[gift].name
			if not game_name then
				game_name = kristal and Utils.titleCase(gift:sub(start+1):gsub("_", " ")) or gift
			end
			local item = Registry.createItem(gifts[gift].item_id)
			local item_name = item:getName()
			cutscene:text(t_c.."* [Seems like you have played [color:yellow]"..game_name..t_c.."!]")
			cutscene:text(t_c.."* [A gift is registered for playing this game![wait:3]\nHere's your [color:yellow]"..item_name..t_c.."!]")
			if Game.inventory:addItem(item) then
				if item.id == "egg" then
					Assets.stopAndPlaySound("egg")
				else
					Assets.stopAndPlaySound("item")
				end
				gift_status[gift] = true
				cutscene:text("* You got the "..item_name..".")
				if i < #new_gifts then
					cutscene:text(t_c.."* [And we're not done yet!]")
				end
			else
				cutscene:text(t_c.."* [Oh but your inventory is full!]")
				nothingText()
				cutscene:text(t_c.."* [But no worries,[wait:2] I'll keep your gift with me until you can take it!]")
				cutscene:text(t_c.."* [So come back soon!]")
				break
			end
		end

		cutscene:text(t_c.."* [That's all for now!]")
		cutscene:text(t_c.."* [Thank you,[wait:2] come again soon!]")

	elseif c == 2 then
		cutscene:text(t_c.."* [You wonder what PC stands for?]")
		cutscene:text(t_c.."* [Yeah,[wait:2] me too.]")
		cutscene:text(t_c.."* [I'm not really a computer nor am I portable so what am I?]")
		cutscene:text(t_c.."* [BUT I can do one cool thing!]")
		cutscene:text(t_c.."* [If you have save data from certain games,[wait:2] I can give you gifts based on that!]")
		cutscene:text(t_c.."* [This can be related to Undertale,[wait:2] Deltarune or anything!]")
		cutscene:text(t_c.."* [Well at least as long as it stores data in your "..(love.system.getOS() == "Windows" and "AppData folder" or "Home directory")..".]")
		cutscene:text(t_c.."* [Do not ask me what an Undertale is,[wait:2] I'm just reading my internal manual.]")
		cutscene:text(t_c.."* [With that out of the way,[wait:2] what do you wanna do?]")

		goto choice
	end

	::turnoff::
	sprite:setFrame(1)
	Assets.stopAndPlaySound("pc_off", 0.5)
	cutscene:text(t_c.."* [The PC is off!]")
end