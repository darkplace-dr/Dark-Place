return {
    board_1 = function(cutscene, event)
		cutscene:text("* Student Council:[wait:5] Festival planning today at 6!")
		cutscene:text("* As a reminder,[wait:5] we still need ideas for our stand at the festival.")
	end,
	
    board_2 = function(cutscene, event)
		cutscene:text("* Deoxynn victim assembly this coming Monday.")
		cutscene:text("* Please be respectful to your current students,[wait:5] even if they're lesser than you.")
	end,
	
    board_3 = function(cutscene, event)
		cutscene:text('* The "paper" on this board is painted on.')
		cutscene:text("* The board is painted directly to the wall.")
		cutscene:text("* Art teachers,[wait:5] right?")
	end,
	
    board_4 = function(cutscene, event)
		cutscene:text("* Free introductory classes at Kai's Dojo this week!")
		cutscene:text("* Learn self-defense and ensure your safety!")
	end,
	
    board_5 = function(cutscene, event)
		cutscene:text("* There seem to be grades on the board.")
		cutscene:text("* Everyone got A's,[wait:5] with the exception of one F.")
	end,
	
    board_6 = function(cutscene, event)
		cutscene:text("* The board seems untouched.")
	end,
	
    board_7 = function(cutscene, event)
		cutscene:text("* Beary the Bear tryouts this Saturday!")
		cutscene:text("* Please arrive before 4.30 to sign up!")
		cutscene:text("* There are also a bunch of sluzball games listed.")
	end,
	
    board_8 = function(cutscene, event)
		cutscene:text("* Today's special: Burgers with fries")
		cutscene:text("* The board seems untouched for a while.")
	end,
	
	bsink = function(cutscene, event)
		cutscene:text("* The sink seems damaged...")
	end,
	
    turlet = function(cutscene, event)
		cutscene:text("* The toilet has mold stains on it.")
	end,
	
    bathtub = function(cutscene, event)
		cutscene:text("* There are two bottles of shampoo and a bottle of body wash.")
	end,
	
	beach = function(cutscene, event)
		cutscene:text("* The beach's water seems unseasonally cold...")
	end,
	
	apartment = function(cutscene, event)
		cutscene:wait(cutscene:playSound("knock"))
		cutscene:text("* (No response.)")
	end,
	
	house_1 = function(cutscene, event)
		cutscene:wait(cutscene:playSound("knock"))
		cutscene:showNametag("???")
		cutscene:text("* Oh?\n[wait:5]* Is someone out there?")
		cutscene:text("* I'd normally open the door,[wait:5] but it's jammed.")
		cutscene:text("* ...")
		cutscene:text("* I guess not.")
		cutscene:hideNametag()
	end,
	
	house_2 = function(cutscene, event)
		if not Game:getFlag("battlecards_world_started") then
			cutscene:wait(cutscene:playSound("knock"))
			cutscene:text("* (No response.)")
			if Game:hasPartyMember("jamm") then
				if not Game:getFlag("dungeonkiller") then
					local jamm = cutscene:getCharacter("jamm")
					cutscene:detachFollowers()
					cutscene:detachCamera()
					cutscene:showNametag("Jamm")
					cutscene:text("* Wait a minute...", "stern", "jamm")
					
					local partyval = 1
					for k,v in ipairs(Game.party) do
						if v.id ~= "jamm" then
							partymem = Game.world:getPartyCharacter(v)
							cutscene:walkTo(partymem, "party_" + partyval, 1, "up")
							partyval = partyval + 1
						end
					end
					
					cutscene:panTo("lockpick")
					cutscene:hideNametag()
					cutscene:wait(cutscene:walkToSpeed(jamm, "jamm_to", 4, "up"))
					cutscene:wait(1)
					cutscene:look(jamm, "left")
					cutscene:showNametag("Jamm")
					cutscene:text("* This house isn't usually this dark inside.", "stern", "jamm")
					cutscene:text("* Even if the lights are off,[wait:5] you can still see something.", "worried", "jamm")
					
					if Game:hasPartyMember("mario") then
						cutscene:showNametag("Mario")
						cutscene:text("* Mario doesn't like dark rooms so much...", "main", "mario")
						cutscene:showNametag("Jamm")
						cutscene:text("* Then what were you doing in the Slider,[wait:5] Mario?", "neutral", "jamm")
						cutscene:showNametag("Mario")
						cutscene:text("* Pingas", "main", "mario")
						cutscene:showNametag("Jamm")
						cutscene:text("* ...Knowing you,[wait:5] Mario,[wait:5] that makes sense.", "stern", "jamm")
					end
					
					cutscene:text("* Frivatown gave me a 'master key' of sorts.[wait:5]\n* I can unlock the door.", "side_smile", "jamm")
					cutscene:text("* I have my doubts,[wait:5] though...", "worried", "jamm")
					
					if #Game.party == 1 then
						cutscene:text("* On second thought,[wait:5] I probably shouldn't go in alone.", "nervous", "jamm")
						cutscene:text("* The last time I did that,[wait:5] Jake had an anxiety attack, and...", "worried", "jamm")
						cutscene:text("* Well,[wait:5] that didn't end well.", "ouch", "jamm")
						cutscene:hideNametag()
						cutscene:wait(cutscene:attachCamera(1))
						cutscene:look(jamm, "down")
						return
					end
					
					cutscene:hideNametag()
					
					local choice = cutscene:choicer({"Unlock", "Not yet"})
					
					if choice == 1 then
						cutscene:wait(cutscene:walkToSpeed(jamm, "lockpick", 4, "up"))
						cutscene:showNametag("Jamm")
						cutscene:text("* It's for the best,[wait:5] right?", "worried", "jamm")
						cutscene:text("* Let me just find my key...", "look_left", "jamm")
						
						cutscene:hideNametag()
						
						local party_talk = false
						
						if Game:hasPartyMember("brenda") then
							party_talk = true
							cutscene:showNametag("Brenda")
							cutscene:text("* I don't know,[wait:5] Jamm...", "frown_side", "brenda")
							cutscene:text("* Are you sure Frivatown is fine with this?", "frown", "brenda")
							
							cutscene:showNametag("Jamm")
							cutscene:text("* They did say I could check in on them whenever.", "side_smile", "jamm")
							cutscene:text("* This seems like a good reason to do so,[wait:5] you know?", "smile", "jamm")
						end
						
						if not party_talk then cutscene:wait(2) end
						
						cutscene:showNametag("Jamm")
						cutscene:text("* And...[wait:5] Done!", "smile", "jamm")
						cutscene:hideNametag()
						
						local shape = Game.world.map:getImageLayer("card_door_remove")
						shape.visible = false
						Game.world.music:stop()
						Assets.playSound("locker")
						
						cutscene:wait(0.25)
						cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x, jamm.y + 40, 1, "up", true))
						cutscene:wait(1)
						
						cutscene:showNametag("Jamm")
						cutscene:text("* Wow...", "neutral", "jamm")
						cutscene:text("* I had no idea there was a dark world here.", "nervous", "jamm")
						
						if Game:hasPartyMember("susie") then
							cutscene:showNametag("Susie")
							cutscene:text("* ...Neither did I.", "nervous_side", "susie")
							cutscene:text("* I know I opened all of these dark worlds,[wait:5] but...", "nervous_side", "susie")
							cutscene:text("* This one's new to me.", "nervous", "susie")
							
							cutscene:showNametag("Jamm")
							cutscene:text("* You don't say...", "worried", "jamm")
						end
						cutscene:hideNametag()
						
						cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x, 220, 4, "up"))
						
						Game.stage.timer:tween(0.5, jamm, {alpha = 0}, "linear")
						
						cutscene:wait(0.5)
						
						if Game.party[1].id == "jamm" then
							Game.world:getPartyCharacter(Game.party[2]):convertToPlayer()
						end
						Game:removePartyMember("jamm")
						jamm:remove()
					
						shape.visible = true
						Assets.playSound("locker")
						cutscene:wait(1)
						
						if Game:hasPartyMember("susie") then
							cutscene:showNametag("Susie")
							if #Game.party == 1 then
								cutscene:text("* ...Should I go after him?", "nervous_side", "susie")
							else
								cutscene:text("* ...Should we go after him?", "nervous_side", "susie")
							end
							
							if Game:hasPartyMember("YOU") then
								cutscene:hideNametag()
								Assets.playSound("croak")
								cutscene:wait(1)
								cutscene:showNametag("Susie")
								cutscene:text("* Yeah,[wait:5] that's right,[wait:5] YOU!", "closed_grin", "susie")
								cutscene:text("* Let's do this!", "smile", "susie")
							elseif Game:hasPartyMember("brenda") then
								cutscene:showNametag("Brenda")
								cutscene:text("* Are you seriously questioning this,[wait:5] Susie?", "neutral", "brenda")
								cutscene:text("* Whatever happened to enjoying adventure?", "smug", "brenda")
								
								cutscene:showNametag("Susie")
								cutscene:text("* Yeah,[wait:5] you're right,[wait:5] Brenda!", "closed_grin", "susie")
								cutscene:text("* Let's do this!", "smile", "susie")
							else
								cutscene:text("* What am I saying!?", "closed_grin", "susie")
								cutscene:text("* When have I ever turned down adventure!?", "smile", "susie")
							end
						elseif Game:hasPartyMember("brenda") then
							cutscene:showNametag("Brenda")
							if #Game.party == 1 then
								cutscene:text("* Jamm,[wait:5] wait for me!", "neutral", "brenda")
							else
								cutscene:text("* Jamm,[wait:5] wait for us!", "neutral", "brenda")
							end
						end
						cutscene:hideNametag()
						
						Game.world.player.visible = false
						for k,v in pairs(Game.world.followers) do
							v.visible = false
						end
						
						transition = DarkTransition(280)
						transition.layer = 99999
						transition.rx1 = 144
						transition.rx2 = 176
						transition.ry1 = 68
						transition.ry2 = 112
						Game.world:addChild(transition)
					else
						cutscene:showNametag("Jamm")
						cutscene:text("* Probably best that we get prepared first.", "stern", "jamm")
						cutscene:text("* Who knows what lies beyond this door?", "worried", "jamm")
						cutscene:hideNametag()
						cutscene:attachFollowers(8)
						cutscene:wait(cutscene:attachCamera(1))
					end
				else
					local jamm = cutscene:getCharacter("jamm")
					cutscene:showNametag("Jamm")
					cutscene:text("* ...", "shaded_neutral", "jamm")
					cutscene:hideNametag()
					
					if #Game.party == 1 then
						cutscene:text("* (Can't go in alone.)", "shaded_neutral", "jamm")
						cutscene:hideNametag()
						return
					end
					
					cutscene:detachFollowers()
					cutscene:detachCamera()
					
					local partyval = 1
					for k,v in ipairs(Game.party) do
						if v.id ~= "jamm" then
							partymem = Game.world:getPartyCharacter(v)
							cutscene:walkTo(partymem, "party_" + partyval, 1, "up")
							partyval = partyval + 1
						end
					end
					
					cutscene:panTo("lockpick")
					cutscene:wait(cutscene:walkToSpeed(jamm, "lockpick", 4, "up"))
					
					local shape = Game.world.map:getImageLayer("card_door_remove")
					shape.visible = false
					Game.world.music:stop()
					Assets.playSound("locker")
					cutscene:wait(1)
					
					cutscene:showNametag("Jamm")
					cutscene:text("* (Maybe this will help me forget.)", "shaded_pissed", "jamm")
					cutscene:hideNametag()
					
					cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x, 220, 4, "up"))
						
					Game.stage.timer:tween(0.5, jamm, {alpha = 0}, "linear")
						
					cutscene:wait(0.5)
						
					if Game.party[1].id == "jamm" then
						Game.world:getPartyCharacter(Game.party[2]):convertToPlayer()
					end
					Game:removePartyMember("jamm")
					jamm:remove()
					
					shape.visible = true
					Assets.playSound("locker")
					cutscene:wait(1)
						
					if Game:hasPartyMember("susie") then
						cutscene:showNametag("Susie")
						if #Game.party == 1 then
							cutscene:text("* ...Should I go after him?", "nervous_side", "susie")
						else
							cutscene:text("* ...Should we go after him?", "nervous_side", "susie")
						end
						
						if Game:hasPartyMember("YOU") then
							cutscene:hideNametag()
							Assets.playSound("croak")
							cutscene:wait(1)
							cutscene:showNametag("Susie")
							cutscene:text("* Yeah,[wait:5] that's right,[wait:5] YOU,[wait:5] it's just...", "nervous_side", "susie")
							cutscene:text("* ...Whatever.[wait:5]\n* Let's do this!", "nervous", "susie")
						elseif Game:hasPartyMember("brenda") then
							cutscene:showNametag("Brenda")
							cutscene:text("* Are you seriously questioning this,[wait:5] Susie?", "neutral", "brenda")
							cutscene:text("* Whatever happened to enjoying adventure?", "smug", "brenda")
							
							cutscene:showNametag("Susie")
							cutscene:text("* Yeah,[wait:5] you're right,[wait:5] Brenda,[wait:5] it's just...", "nervous_side", "susie")
							cutscene:text("* ...Whatever.[wait:5]\n* Let's do this", "nervous", "susie")
						else
							cutscene:text("* ...I'm going to regret this.", "nervous_side", "susie")
						end
					elseif Game:hasPartyMember("brenda") then
						cutscene:showNametag("Brenda")
						if #Game.party == 1 then
							cutscene:text("* Jamm,[wait:5] wait for me!", "neutral", "brenda")
						else
							cutscene:text("* Jamm,[wait:5] wait for us!", "neutral", "brenda")
						end
					end
					cutscene:hideNametag()
						
					Game.world.player.visible = false
					for k,v in pairs(Game.world.followers) do
						v.visible = false
					end
					
					transition = DarkTransition(280)
					transition.layer = 99999
					transition.rx1 = 144
					transition.rx2 = 176
					transition.ry1 = 68
					transition.ry2 = 112
					Game.world:addChild(transition)
				end
			end
		end
		cutscene:hideNametag()
	end,
	
	truck = function(cutscene, event)
		cutscene:text("* The truck seems old...")
	end,
	
	store = function(cutscene, event)
		cutscene:text("* The store is closed.")
	end,
	
    counter = function(cutscene, event)
		cutscene:text("* (Check what?)")
		choice = cutscene:choicer({"Microwave", "Cabinet"})
		if choice == 1 then
			cutscene:text("* The microwave is clean and seems barely-used.")
		else
			cutscene:text("* Inside the cabinet,[wait:5] I see a set of knives.")
			cutscene:text("* The biggest knife is missing from the set.")
		end
	end,
	
	upper_shelf_1 = function(cutscene, event)
		cutscene:text("* Europan Origins[wait:5]\n* By Alex Wolfe")
		cutscene:text("* The first humans landed on Europa in a fleet of ships known as the Doomsday Fleet.")
		cutscene:text("* They went ahead and explored,[wait:5] and even went ahead and set up colonies.")
		cutscene:text("* These colonies were distant from each other and included our very own Frivatown.")
		cutscene:text("* Pretty soon,[wait:5] they were able to recreate a few inventions from Earth.")
		cutscene:text("* These inventions included computers,[wait:5] cars,[wait:5] and even the school bas.")
	end,
	
	upper_shelf_2 = function(cutscene, event)
		cutscene:text("* The bookshelf is full of sandwiches.")
	end,
	
	upper_shelf_3 = function(cutscene, event)
		cutscene:text("* You take a book out of the shelf.")
		cutscene:text("* You rip a page out and eat it.")
		cutscene:text('* This must be what they mean by "flavor text".')
		cutscene:text("* You put the book back on the shelf.")
	end,
	
	upper_shelf_4 = function(cutscene, event)
		cutscene:text("* Birds[wait:5]\n* By Birdman")
		cutscene:text("* BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS BIRDS")
		cutscene:text("* Well,[wait:5] the book wasn't lying.")
	end,
	
	lower_shelf_1 = function(cutscene, event)
		cutscene:text("* Known Earth History[wait:5]\n* By Doctor Hannah Friedman")
		cutscene:text("* Earth wasn't a planet that I'd want to visit.")
		cutscene:text("* After all,[wait:5] the planet was known for a world war,[wait:5] countries stealing from each other...")
		cutscene:text("* ...and governments being ruled by idiots.")
		cutscene:text("* Thankfully,[wait:5] us Europans learned from the mistakes that Earth dwellers made.")
	end,
	
	lower_shelf_2 = function(cutscene, event)
		cutscene:text("* Unbiased Earth History[wait:5]\n* By Henry Ciders")
		cutscene:text("* We do not have much information from the humans' time on Earth.")
		cutscene:text("* The information we have is inventions,[wait:5] concepts,[wait:5] and conflicts with resolutions.")
		cutscene:text("* Among those wars is the World War,[wait:5] a war against genocide.")
	end,
	
	lower_shelf_3 = function(cutscene, event)
		cutscene:text("* This shelf is full of facts...")
		cutscene:text("* However, it's labeled as the conspiracy shelf.")
	end,
	
	lower_shelf_4 = function(cutscene, event)
		cutscene:text("* Desperation[wait:5]\n* By Jake Xen")
		cutscene:text("* Please,[wait:5] Brittney,[wait:5] please take me back,[wait:5] I had this whole book published just for you.")
	end,
	
	lower_shelf_5 = function(cutscene, event)
		cutscene:text("* The books here seem to be painted on.")
		cutscene:text('* The shelves are fake,[wait:5] too.[wait:5]\n* The "shelf" is just a block of wood.')
	end,
	
	lower_shelf_6 = function(cutscene, event)
		cutscene:text("* This book is a book on leaves.")
		cutscene:text("* Inside,[wait:5] all the pages are made of various leaves.")
		cutscene:text("* The cover is leaves,[wait:5] too.")
	end,
	
	lower_shelf_7 = function(cutscene, event)
		cutscene:text("* Earth Holidays[wait:5]\n* By Nick Nack")
		cutscene:text("* Earth has holidays for every month of their year.")
		cutscene:text("* Though most of these holidays are minor,[wait:5] some of them were carried over to Europa.")
		cutscene:text("* Valentine's Day celebrates the love we have for other people.")
		cutscene:text("* Hallow Teen is a day where we get to scare kids and give them candy.")
		cutscene:text("* Christmas is all about giving gifts to others.")
		cutscene:text("* It may have been misinterpreted in translation,[wait:5] but we celebrate these days anyways.")
	end,
	
	lower_shelf_8 = function(cutscene, event)
		cutscene:text("* Frivatown Festival[wait:5]\n* By Gina Mends")
		cutscene:text("* The festival of Frivatown celebrates the anniversary of this town.")
		cutscene:text("* Every year,[wait:5] we decorate half of Frivatown and celebrate.")
		cutscene:text("* We have various foods to eat and a live concert to enjoy.")
		cutscene:text("* A lot of planning goes into this festival.")
	end,
	
	lower_shelf_9 = function(cutscene, event)
		cutscene:text("* Earth History Part 4")
		cutscene:text("* It's time for part 4!")
		cutscene:text("* Of my Earth History series!")
		cutscene:text("* So here is the fourth part")
		cutscene:text("* To my Earth History series!")
		cutscene:text("* benis")
	end,
	
	lower_shelf_10 = function(cutscene, event)
		cutscene:text("* Fleeing Dystopia[wait:5]\n* By Sergeant Monica Greene")
		cutscene:text("* It is my hope that this diary gets published once we arrive on Europa.")
		cutscene:text("* As I am writing this,[wait:5] my ship,[wait:5] ID 54,[wait:5] had just arrived to the ISS.")
		cutscene:text("* We had just learned that ship 23 went back to Earth.")
		cutscene:text("* Earth was already destroyed by the doomsday event.")
		cutscene:text("* If anyone is remaining on Earth,[wait:5] they must've been lucky to survive.")
		cutscene:text("* And for ship 23,[wait:5] I wish you luck in rebuilding Earth civilization.")
		cutscene:text("* As for us,[wait:5] we are currently preparing to head to Europa.")
		cutscene:text("* It is consensus that none of us will make it to Europa...")
		cutscene:text("* ...but if humans generations in the future can touch Europan soil...")
		cutscene:text("* ...then the mission will be a success.")
	end,
	
	lower_shelf_11 = function(cutscene, event)
		cutscene:text("* The War Between Humans & Beasts[wait:5]\n* By Adam Blight")
		cutscene:text("* Beast and man have been at war ever since we arrived.")
		cutscene:text("* Honestly,[wait:5] we don't know what we did wrong.")
		cutscene:text("* For all I know,[wait:5] we only made some space for ourselves,[wait:5] right?")
		cutscene:text("* So,[wait:5] what went wrong?[wait:5]\n* What caused these creatures to be hostile?")
		cutscene:text("* And why us?[wait:5]\n* Why are they attacking only us?")
		cutscene:text("* From what I understand,[wait:5] the deoxynn were here longer,[wait:5] right?")
		cutscene:text("* There is a lot I still don't understand about the war.")
		cutscene:text("* However,[wait:5] when I understand more,[wait:5] I will make a volume 2.")
	end,
	
	lower_shelf_12 = function(cutscene, event)
		cutscene:text("* This whole shelf is filled with programming guides.")
	end,
	
	lower_shelf_13 = function(cutscene, event)
		cutscene:text("* Weather Hurts[wait:5]\n* By Jet Wethermen")
		cutscene:text("* We all know that weather is a constant on Europa.")
		cutscene:text("* We have sun and rain,[wait:5] sometimes thunder or snow,[wait:5] or maybe just clouds.")
		cutscene:text("* But when it comes to rain,[wait:5] how is it that we get hurt by it?")
		cutscene:text("* How is it that the tiny drops of water hurt us when we stand out in the rain?")
		cutscene:text("* Scientists have recently (year 153) figured out the answer.")
		cutscene:text("* (And then it's a bunch of science stuff...)")
	end,
	
	lower_shelf_14 = function(cutscene, event)
		cutscene:text("* Game review: Hats of Legend")
		cutscene:text("* This game is the story of a little boy who has magic hats.")
		cutscene:text("* These hats would give him different abilities to help him.")
		cutscene:text("* His adventure is all about collecting pieces of energy.")
		cutscene:text("* The story started to build when your friend betrays you.")
		cutscene:text("* I was shocked when I saw him at first.")
		cutscene:text("* I mean,[wait:5] how often is it that you see a kid with a beard?")
		cutscene:text("* It shocked me when the final boss was against him.")
		cutscene:text("* The mechanics are great,[wait:5] too.[wait:5] You have a variety of abilities from the start.")
		cutscene:text("* However,[wait:5] the whole \"friendship is power\" thing they tried...")
		cutscene:text("* It doesn't work when they suddenly turn to your side all at once.")
		cutscene:text("* Overall,[wait:5] 6/10.")
	end,
	
	computer_1 = function(cutscene, event)
		cutscene:text("* The computer is open to a flight simulator game.")
		cutscene:text("* In the game,[wait:5] the plane seems to be flying itself.")
		cutscene:text("* This must be an Auto-Pilot Interface.")
	end,
	
	bz = function(cutscene, event)
		cutscene:text("* The theme for the festival this year has been revealed!")
		cutscene:text("* The theme is:[wait:5] Flowers")
		cutscene:text("* Humans on Europa look to flowers for decoration, as did those on Earth!")
		cutscene:text("* This year, we look forward to your outfits and booths...")
		cutscene:text("* ...decorated with beautiful flower patterns and arrangements!")
	end,
	
	computer_2 = function(cutscene, event)
		cutscene:text("* There are a bunch of ants crawling over the screen.")
		cutscene:text("* The ants seem to only be crawling over a text document.")
		cutscene:text("* Something tells me that this program needs debugging.")
	end,
	
	computer_3 = function(cutscene, event)
		cutscene:text("* This computer seems to be running Windows 11.")
		cutscene:text("* After all,[wait:5] that's the maximum number of windows that fit onscreen.")
	end,
	
	computer_4 = function(cutscene, event)
		cutscene:text("* The background of this computer is a picture with a small cloud.")
		cutscene:text('* Inside the cloud is a single folder named "STORAGE".')
		cutscene:text("* Inside the folder reside a lot of files.")
	end,
	
	computer_5 = function(cutscene, event)
		Game:setFlag("deox_spam", Game:getFlag("deox_spam", 72) + 1)
		if Game:getFlag("deox_spam") > 65535 then
			cutscene:text("* You crashed the computer at the 16-bit integer limit.")
		elseif Game:getFlag("deox_spam") == 1997 then
			cutscene:text("* This computer has [1997] tabs open to an image of canned spam.")
		else
			cutscene:text("* This computer has " ..Game:getFlag("deox_spam").. " tabs open to an image of canned spam.")
		end
	end,
	
	computer_6 = function(cutscene, event)
		cutscene:text("* Ah,[wait:5] this computer has a cool desktop background.")
		cutscene:text("* Oh,[wait:5] wait.[wait:5]\n* Someone just raged when they were playing Geometry Dash.")
	end,
	
    tv = function(cutscene, event)
		cutscene:text("* In the TV cabinet lies a lot of TV remotes.")
	end,
	
    police_door = function(cutscene, event)
		cutscene:text("* The door is locked.")
		cutscene:text("* Through the door,[wait:5] you see a man typing on a laptop.")
		cutscene:text("* His hand is on the charging port,[wait:5] and it's somehow charging?")
		if Game:hasPartyMember("jamm") then
			cutscene:showNametag("Jamm")
			cutscene:text("* The heck...?[wait:5]\n* Is that...[wait:5] Me...?", "stern", "jamm")
		end
		cutscene:hideNametag()
	end,
}