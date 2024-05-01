return function(cutscene, event, chara)

	local function nothingText()
		if love.math.random(1, 10) == 1 then
			local nothing = Assets.playSound("nothing")
			Game.world.music:pause()
			cutscene:text("[noskip][color:#000099]* [[speed:0.7]You get [wait:10]NOTHING!\n[wait:16]You lose![wait:30]\nGood day,[wait:2] sir!]", {skip=false, advance=false, wait=false})
			cutscene:wait(function()
				return not cutscene.textbox:isTyping() and not nothing:isPlaying()
			end)
			Game.world.music:resume()
		else
			cutscene:text("[color:#000099]* [So you get nothing!]")
		end
	end

	Game.world:getEvent(89):setSprite("world/maps/devroom/pc_2")
	local sound = Assets.stopAndPlaySound("pc_on", 0.5)
	cutscene:text("[color:#000099]* [The PC is on!]")
	Assets.stopSound("pc_on")
	Assets.stopAndPlaySound("pc_enter", 0.5)
	cutscene:text("[color:#000099]* [What do you want to do?]")
	local c
	while true do
		c = cutscene:choicer({"Get Gifts", "What's that?", "Turn off"})
		if c == 1 then
			cutscene:text("[color:#000099]* [Alright,[wait:2] let's see what we have for you today...]")
			cutscene:text("[color:#000099]* [speed:0.1][...]")
			if not (love.system.getOS() == "Android" or love.system.getOS() == "iOS") then
				local gifts = Mod.pc_gifts_data
				local gift_status = Game:getFlag("pc_gifts_status")
				local new_gifts = {}
				for game,data in pairs(gifts) do
					local kristal, start = game:find("KR_")
					if kristal then
						if not gift_status[game] then
							if game == "KR_wii_bios" then
								if Mod:hasWiiBIOS() then
									table.insert(new_gifts, game)
								end
							else
								if Mod:hasSaveFiles(game:sub(start+1)) then
									table.insert(new_gifts, game)
								end
							end
						end
					else
						if not gift_status[game] then
							if type(data.file) == "string" then
								if Mod:fileExists((data.prefix_os[love.system.getOS():gsub(" ", "_")] or "").."/"..data.file) then
									table.insert(new_gifts, game)
								elseif love.system.getOS() == "Linux" and data.prefix_os["Windows"] then
									if Mod:fileExists(data.prefix_os["Windows"].."/"..data.file, true, data.wine_steam_appid) then
										table.insert(new_gifts, game)
									end
								end
							elseif type(data.file) == "table" then
								for i,file in ipairs(data.file) do
									if Mod:fileExists((data.prefix_os[love.system.getOS():gsub(" ", "_")] or "").."/"..file) then
										table.insert(new_gifts, game)
										break
									elseif love.system.getOS() == "Linux" and data.prefix_os["Windows"] then
										if Mod:fileExists(data.prefix_os["Windows"].."/"..file, true, data.wine_steam_appid) then
											table.insert(new_gifts, game)
										end
									end
								end
							end
						end
					end
				end
				if #new_gifts > 0 then
					for i,gift in ipairs(new_gifts) do
						local kristal, start = gift:find("KR_")
						local item = Registry.createItem(gifts[gift].item_id)
						cutscene:text("[color:#000099]* [Seems like you have played [color:yellow]"..(gifts[gift].name and gifts[gift].name or (kristal and Utils.titleCase(gift:sub(start+1):gsub("_", " ")) or gift)).."[color:#000099]!]")
						cutscene:text("[color:#000099]* [A gift is registered for playing this game![wait:3]\nHere's your [color:yellow]"..item:getName().."[color:#000099]!]")
						if Game.inventory:addItem(item) then
							if item.id == "egg" then
								Assets.stopAndPlaySound("egg")
							else
								Assets.stopAndPlaySound("item")
							end
							gift_status[gift] = true
							cutscene:text("* You got the "..item:getName()..".")
							if i < #new_gifts then
								cutscene:text("[color:#000099]* [And we're not done yet!]")
							end
						else
							cutscene:text("[color:#000099]* [Oh but your inventory is full!]")
							nothingText()
							cutscene:text("[color:#000099]* [But no worries,[wait:2] I'll keep your gift with me until you can take it!]")
							cutscene:text("[color:#000099]* [So come back soon!]")
						end
					end
					cutscene:text("[color:#000099]* [That's all for now!]")
					cutscene:text("[color:#000099]* [Thank you,[wait:2] come again soon!]")
				else
					cutscene:text("[color:#000099]* [Nope![wait:3] There's nothing new for you!]")
					nothingText()
				end
				--cutscene:text("[color:#000099]* [nothing you fucking son of a respectable woman go annoy someone else before i call the ltg mods]")
			else
				cutscene:text("[color:#000099]* [Unfortunately,[wait:2] I cannot check for save files on a "..love.system.getOS().." system.]")
				nothingText()
			end
			break
		elseif c == 2 then
			cutscene:text("[color:#000099]* [You wonder what PC stands for?]")
			cutscene:text("[color:#000099]* [Yeah,[wait:2] me too.]")
			cutscene:text("[color:#000099]* [I'm not really a computer nor am I portable so what am I?]")
			cutscene:text("[color:#000099]* [BUT I can do one cool thing!]")
			cutscene:text("[color:#000099]* [If you have save data from certain games,[wait:2] I can give you gifts based on that!]")
			cutscene:text("[color:#000099]* [This can be related to Undertale,[wait:2] Deltarune or anything!]")
			cutscene:text("[color:#000099]* [Well at least as long as it stores data in your "..(love.system.getOS() == "Windows" and "AppData folder" or "Home directory")..".]")
			cutscene:text("[color:#000099]* [Do not ask me what an Undertale is,[wait:2] I'm just reading my internal manual.]")
			cutscene:text("[color:#000099]* [With that out of the way,[wait:2] what do you wanna do?]")
		elseif c == 3 then
			break
		end
	end
	Game.world:getEvent(89):setSprite("world/maps/devroom/pc_1")
	Assets.stopAndPlaySound("pc_off", 0.5)
	cutscene:text("[color:#000099]* [The PC is off!]")
end