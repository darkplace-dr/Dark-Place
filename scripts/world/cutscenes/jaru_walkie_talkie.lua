return function(cutscene, event_override)
    cutscene:text("* You turn on the walkie talkie...")
	
    local jaru_talked_first_time = Game:getFlag("jaruHasUsedWalkieTalkie", false)
	local jaru_talked_in_devroom = Game:getFlag("jaruCommunicationTest", false)
	
    if Game.world.map.id == "devhotel/devdiner/devroom" and jaru_talked_in_devroom == false and jaru_talked_first_time == false then
	    cutscene:showNametag("J.A.R.U.")
        cutscene:text("* Kid, didn't I tell ya to get movin'? What's the damn holdup?!", "visible_confusion", "shadowsalesman")
        cutscene:text("* ...", "default", "shadowsalesman")
        cutscene:text("* Oh,[wait:5] you're uh...", "default", "shadowsalesman")
        cutscene:text("* ...just the testing the thing out?", "default", "shadowsalesman")
        cutscene:text("* Ah, I see.[wait:5]\n* Sorry 'bout my outburst then.", "default", "shadowsalesman")
        cutscene:text("* Well, since we're both talkin' right now,[wait:5] whaddya wanna know?", "default", "shadowsalesman")
		Game:setFlag("jaruCommunicationTest", true)
        Game:setFlag("jaruHasUsedWalkieTalkie", true)
	    cutscene:hideNametag()
	else
        Game:setFlag("jaruHasUsedWalkieTalkie", true)
	    cutscene:showNametag("J.A.R.U.")
        cutscene:text("* Hey kid, whaddya wanna know?", "default", "shadowsalesman")
	    cutscene:hideNametag()
	end
	
	local opinion = cutscene:choicer({"Current Area", "Party"}) -- Only "Current Area" is functional.
	
    if opinion == 1 then
        if Game.world.map.id == "devhotel/devdiner/devroom" then
	        cutscene:showNametag("J.A.R.U.")
            cutscene:text("* You want to know more about the Diner?", "default", "shadowsalesman")
            cutscene:text("* Well,[wait:5] I'm not sure what else there is to say about it...", "default", "shadowsalesman")
            cutscene:text("* It's essentially just where me and my friends like to hang out.", "default", "shadowsalesman")
            cutscene:text("* If the purple color wasn't obvious enough,[wait:5] I run this joint.", "default", "shadowsalesman")
            cutscene:text("* I'll admit.\n[wait:5]* It is a simple,[wait:5] yet tedious job.", "eye_closed", "shadowsalesman")
            cutscene:text("* Cause you gotta keep your eyes peeled for any trouble.", "suspicious", "shadowsalesman")
            cutscene:text("* Especially when a certain deer tries to wreak havoc here.", "annoyed", "shadowsalesman")
            cutscene:text("* ...", "default", "shadowsalesman")
            cutscene:text("* Just so we're on the same page here,[wait:5][face:annoyed] I'm referring to Dess.", "default", "shadowsalesman")
			if Game:hasPartyMember("dess") then
                cutscene:showNametag("Dess")
                cutscene:text("* Still waiting on my lifetime supply of soda, purple man.", "condescending", "dess")
	            cutscene:showNametag("J.A.R.U.")
                cutscene:text("* NOT ON YOUR DAMN LIFE,[wait:5] YOU DOE.", "pissed", "shadowsalesman")
                cutscene:text("* Especially after THAT blunder you pulled last week.", "annoyed", "shadowsalesman")
                cutscene:showNametag("Dess")
                cutscene:text("* Ahhh, good times...", "kind", "dess")
			end
	        cutscene:hideNametag()
        elseif Game.world.map.id == "everhall_entry" then
	        cutscene:showNametag("J.A.R.U.")
            cutscene:text("* Oh yeaaahh,[wait:5] THIS hallway...", "annoyed", "shadowsalesman")
            cutscene:text("* I have absolutely no idea why this hallway is here.", "default", "shadowsalesman")
            cutscene:text("* It just sorta appeared one day when I was working a late shift.", "annoyed", "shadowsalesman")
            cutscene:text("* Folks around here call it the \"Everhall\",[wait:5] for whatever reason.", "default", "shadowsalesman")
            cutscene:text("* Come to think of it...", "annoyed", "shadowsalesman")
            cutscene:text("* It kinda reminds of this other hallway I found in a universe I visited.", "default", "shadowsalesman")
            cutscene:text("* It strectched on for miles and miles just like this one...", "default", "shadowsalesman")
            cutscene:text("* But instead of tally marks, there was Bible-\nsized lore on the walls.", "default", "shadowsalesman")
            cutscene:text("* Strange stuff,[wait:5] dontcha think?", "annoyed", "shadowsalesman")
			if Game:hasPartyMember("jamm") then
                cutscene:showNametag("Jamm")
                cutscene:text("* I think it's called the \"Everhall\" because of Everhood?", "neutral", "jamm")
                cutscene:text("* Green has a hall just like this in their basement, so...", "neutral", "jamm")
                cutscene:text("* And it has all these tally marks on there too.", "neutral", "jamm")
                cutscene:text("* Plus,[wait:5] the signifigance of the tally marks is that--", "neutral", "jamm", {auto=true})
				cutscene:showNametag("J.A.R.U.")
				cutscene:text("* We get it,[wait:5] Jamm.[wait:5]\n* You play Everhood.", "annoyed", "shadowsalesman")
			end
	        cutscene:hideNametag()
        elseif Game.world.map.id == "everhall" then
		    local everhall_count = Game:getFlag("hallways") or 0 -- having trouble getting the value of the flag to display properly.
	        
            cutscene:showNametag("J.A.R.U.")
            cutscene:text("* So you're going through the whole hallway,[wait:5] eh?", "annoyed", "shadowsalesman")
            cutscene:text("* How many rooms have you gone through?", "default", "shadowsalesman")
            cutscene:text("* ...[wait:5][color:yellow]"..tostring(everhall_count).."[color:reset]?", "eye_closed", "shadowsalesman")
            cutscene:text("* Well good frickin' luck,[wait:5] pal.", "annoyed", "shadowsalesman")
            cutscene:text("* I heard this hallway's like a [color:red]MILLION ROOMS[color:reset] long.", "annoyed", "shadowsalesman")
            cutscene:text("* So it's gonna take you a LOOONG time to reach the end.", "default", "shadowsalesman")
	        cutscene:hideNametag()
        elseif Game.world.map.id == "devhotel/fakehallway" then
	        cutscene:showNametag("J.A.R.U.")
            cutscene:text("* ...[wait:10]\"Room 269\"?", "default", "shadowsalesman")
            cutscene:text("* There isn't \"Room 269\" in this hotel.\n[wait:5]* What are ya on about, kid??", "annoyed", "shadowsalesman")
            cutscene:text("* Where even ARE you???", "visible_confusion", "shadowsalesman")
            cutscene:text("* ...", "default", "shadowsalesman")
            cutscene:text("* Wait a minute...", "annoyed", "shadowsalesman")
            cutscene:text("* ...you're in one of those\n\"fake rooms\",[wait:5] arentcha?", "suspicious", "shadowsalesman")
            cutscene:text("* Yeeaah,[wait:5] I've gotten several complaints about those from customers.", "annoyed", "shadowsalesman")
            cutscene:text("* Not sure what the deal those places are...", "suspicious", "shadowsalesman")
            cutscene:text("* Though I'd suggest not stickin' around in there for too long.", "annoyed", "shadowsalesman")
            cutscene:text("* Be careful, kid.", "default", "shadowsalesman")
	        cutscene:hideNametag()
        elseif Game.world.map.id == "starbeans" then
            local jaru_alexa_discussion = Game:getFlag("jaruHasTalkedAboutAlexa")

            cutscene:showNametag("J.A.R.U.")
            cutscene:text("* This is the Starbeans section of the Diner.", "default", "shadowsalesman")
            cutscene:text("* And at the counter over there is Alexa, who works as our barista.", "default", "shadowsalesman")
            cutscene:text("* Jamm brought her here one day and told me she needed a job.", "default", "shadowsalesman")
            cutscene:text("* So I offered her one, and she happily accepted it!", "default", "shadowsalesman")
            cutscene:text("* Now to be honest, I don't know much about where she came from.", "default", "shadowsalesman")
            cutscene:text("* (Jamm would actually know more about that than I would, heh.)", "default", "shadowsalesman")
            cutscene:text("* Maybe you could try asking him about it, whenever you can.", "default", "shadowsalesman")
            cutscene:hideNametag()

            if jaru_alexa_discussion == false then
                Game:setFlag("jaruHasTalkedAboutAlexa", true)
			end
        elseif Game.world.map.id == "spamroom" then
            -- WIP
	        cutscene:showNametag("J.A.R.U.")
            cutscene:text("* A room full of short salespersons?", "default", "shadowsalesman")
            cutscene:text("* Ah, you must be in the \"Spamroom\" then...", "annoyed", "shadowsalesman")
	        cutscene:hideNametag()
        elseif Game.world.map.id == "familymap" then
	        cutscene:showNametag("J.A.R.U.")
            cutscene:text("* ...", "oh", "shadowsalesman")
            cutscene:text("* What.[wait:20]\n* In God's name.[wait:20]\n* Am I listening to?", "oh", "shadowsalesman")
            cutscene:text("* ...", "oh", "shadowsalesman")
            cutscene:text("* ...", "annoyed", "shadowsalesman")
            cutscene:text("* Okay,[wait:5] correct me if I'm wrong...", "eye_closed", "shadowsalesman")
            cutscene:text("* But is that Peter Griffin singing that weird song Bor likes?", "suspicious", "shadowsalesman")
            cutscene:text("* ...", "annoyed", "shadowsalesman")
            cutscene:text("* (Sigh...)", "eye_closed", "shadowsalesman")
            cutscene:text("* (Kid, I suggest you should probably get outta there.)", "annoyed", "shadowsalesman")
            cutscene:text("* (Before you loose your sanity or something.)", "suspicious", "shadowsalesman")
	        cutscene:hideNametag()
        elseif Game.world.map.id == "spamgolorneo_save" then
            if not Game:hasPartyMember("susie") then
                if not Game:getFlag("jaruSpamgolorNeoRooms") then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Uh,[wait:5] so me and Susie may or may not be currently trapped...", "frown", "brenda")
                    cutscene:text("* ... in an area that's like that basement in Queen's mansion.", "frown_side", "brenda")
                    cutscene:showNametag("J.A.R.U.")
                    cutscene:text("* ...[wait:10]\n* Oh,[wait:5] that ain't good.", "oh", "shadowsalesman")
                    cutscene:text("* Listen,[wait:5] just try and find a way outta there.", "default", "shadowsalesman")
                    cutscene:text("* And for God's sake,[wait:5] whatever you do...", "annoyed", "shadowsalesman")
                    cutscene:text("* Do [color:red]NOT[color:white] touch any weird body-shaped junk you might find.", "annoyed", "shadowsalesman")
                    cutscene:text("* I'm sure you're well aware of what happens when you do that.", "suspicious", "shadowsalesman")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Uh,[wait:5] got it,[wait:5] yeah.", "neutral_side", "brenda")
                    Game:setFlag("jaruSpamgolorNeoRooms", true)
                    cutscene:hideNametag()
                else
                    cutscene:showNametag("Brenda")
                    cutscene:text("* There's like an electric barrier blocking the way out.", "neutral_side", "brenda")
                    cutscene:showNametag("J.A.R.U.")
                    cutscene:text("* Hmm...", "eye_closed", "shadowsalesman")
                    cutscene:text("* I'm sure there's a way to turn it off somewhere.", "default", "shadowsalesman")
                    cutscene:hideNametag()
                end
            end
        elseif Game.world.map.id == "spamgolorneo_hallway" then
            if not Game:hasPartyMember("susie") then
                if not Game:getFlag("jaruSpamgolorNeoRooms") then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Uh,[wait:5] so me and Susie may or may not be currently trapped...", "frown", "brenda")
                    cutscene:text("* ... in an area that's like that basement in Queen's mansion.", "frown_side", "brenda")
                    cutscene:showNametag("J.A.R.U.")
                    cutscene:text("* ...[wait:10]\n* Oh,[wait:5] that ain't good.", "oh", "shadowsalesman")
                    cutscene:text("* Listen,[wait:5] just try and find a way outta there.", "default", "shadowsalesman")
                    cutscene:text("* And for God's sake,[wait:5] whatever you do...", "annoyed", "shadowsalesman")
                    cutscene:text("* Do [color:red]NOT[color:white] touch any weird body-shaped junk you might find.", "annoyed", "shadowsalesman")
                    cutscene:text("* I'm sure you're well aware of what happens when you do that.", "suspicious", "shadowsalesman")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Uh,[wait:5] got it,[wait:5] yeah.", "neutral_side", "brenda")
                    Game:setFlag("jaruSpamgolorNeoRooms", true)
                    cutscene:hideNametag()
                else
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Okay so now I'm in a hallway.", "neutral", "brenda")
                    cutscene:text("* There's two doors,[wait:5] one of them's closed...", "neutral_side", "brenda")
                    cutscene:text("* I'm fairly certain that's where Susie is.", "neutral", "brenda")
                    cutscene:text("* So I'm gonna go into the door that's open.", "neutral_side", "brenda")
                    cutscene:showNametag("J.A.R.U.")
                    cutscene:text("* Alright then.[wait:10]\n* Stay safe in there,[wait:5] got it, Brenda?", "default", "shadowsalesman")
                    cutscene:hideNametag()
                end
            end
        elseif Game.world.map.id == "spamgolorneo_body" then
            if not Game:hasPartyMember("susie") then
                if not Game:getFlag("jaruSpamgolorNeoRooms") then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Uh,[wait:5] so me and Susie may or may not be currently trapped...", "frown", "brenda")
                    cutscene:text("* ... in an area that's like that basement in Queen's mansion.", "frown_side", "brenda")
                    cutscene:showNametag("J.A.R.U.")
                    cutscene:text("* ...[wait:10]\n* Oh,[wait:5] that ain't good.", "oh", "shadowsalesman")
                    cutscene:text("* Listen,[wait:5] just try and find a way outta there.", "default", "shadowsalesman")
                    cutscene:text("* And for God's sake,[wait:5] whatever you do...", "annoyed", "shadowsalesman")
                    cutscene:text("* Do [color:red]NOT[color:white] touch any weird body-shaped junk you might find.", "annoyed", "shadowsalesman")
                    cutscene:text("* I'm sure you're well aware of what happens when you do that.", "suspicious", "shadowsalesman")
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Uh,[wait:5] got it,[wait:5] yeah.", "neutral_side", "brenda")
                    Game:setFlag("jaruSpamgolorNeoRooms", true)
                    cutscene:hideNametag()
                else
                    if not Game:getFlag("spamgolorneo_activate") then
                        cutscene:showNametag("Brenda")
                        cutscene:text("* Okay so I think this room's a dead-end.", "suspicious", "brenda")
                        cutscene:text("* However,[wait:5] I'm pretty sure there's something at the end of it.", "happy", "brenda")
                        cutscene:text("* So Imma see what's up.", "neutral_side", "brenda")
                        cutscene:showNametag("J.A.R.U.")
                        cutscene:text("* Alright,[wait:5] just...[wait:10] don't do anything stupid.", "annoyed", "shadowsalesman")
                        cutscene:text("* I've got a bad feeling about this...", "default", "shadowsalesman")
                        cutscene:hideNametag()
                    else
                        cutscene:showNametag("Brenda")
                        cutscene:text("* So uh,[wait:5] found the thing Spamgolor told us to find.", "neutral_side", "brenda")
                        cutscene:text("* And I have absolutely ZERO clue what I'm supposed to do with it.", "suspicious", "brenda")
                        cutscene:text("[noskip]* So I think I'm gonna go find Susie and", "neutral", "brenda", {auto = true})
                        cutscene:showNametag("J.A.R.U.")
                        cutscene:text("* Hold on,[wait:5] did you just say \"Spamgolor\"?", "annoyed", "shadowsalesman")
                        cutscene:text("* HE told you to go here?", "visible_confusion", "shadowsalesman")
                        cutscene:showNametag("Brenda")
                        cutscene:text("* I mean,[wait:5] yeah I guess.", "neutral_side", "brenda")
                        cutscene:showNametag("J.A.R.U.")
                        cutscene:text("* Brenda,[wait:5] go find Susie and find a way out as fast as you can.", "annoyed", "shadowsalesman")
                        cutscene:text("* I've got a really bad feeling about this.", "eye_closed", "shadowsalesman")
                        cutscene:hideNametag()
                    end
                end
            end
        elseif Game.world.map.id == "devhotel/rooms/room_001/entrance" then
            cutscene:showNametag("J.A.R.U.")
            cutscene:text("* Yeah,[wait:5] that's Brenda's room.", "default", "shadowsalesman")
            cutscene:text("* Why are you askin' ME about it?[wait:10] It ain't my room.", "annoyed", "shadowsalesman")
            cutscene:hideNametag()
        elseif Game.world.map.id == "devhotel/rooms/room_001/bedroom" then
            cutscene:showNametag("J.A.R.U.")
            cutscene:text("* ...", "annoyed", "shadowsalesman")
            cutscene:text("* Why the HELL are you asking me about Brenda's bedroom?", "annoyed", "shadowsalesman")
            cutscene:text("* Listen pal,[wait:5] it's a bedroom,[wait:5] ain't anything special about it.", "default", "shadowsalesman")
            cutscene:text("* Well I suppose it IS one of the only rooms in this hotel...", "default", "shadowsalesman")
            cutscene:text("* ... that has a seperate bedroom.", "default", "shadowsalesman")
            cutscene:text("* But other than that,[wait:5] I dunno what else you want from me.", "annoyed", "shadowsalesman")
            cutscene:hideNametag()
        elseif Game.world.map.id == "floor2/lounge" then
            cutscene:showNametag("J.A.R.U.")
            cutscene:text("* Oh you're in the lounge on Floor 2,[wait:5] eh?", "default", "shadowsalesman")
            cutscene:text("* On your left and right, you can find a bunch of doors.", "default", "shadowsalesman")
            cutscene:text("* Some of these are rooms for a few specific people...", "default", "shadowsalesman")
            cutscene:text("* While others will take you different areas in this Dark World.", "default", "shadowsalesman")
            cutscene:text("* Have a look around.[wait:5]\n* You may find some familiar faces here!", "default", "shadowsalesman")
            cutscene:text("* (Oh,[wait:5] and uh,[wait:5] one more thing...)", "suspicious", "shadowsalesman")
            cutscene:text("* (I strongly recommend NOT reading the sign on the right.)", "annoyed", "shadowsalesman")
            cutscene:text("* (Trust me,[wait:5] you won't like what'll happen next.)", "suspicious", "shadowsalesman")
            cutscene:hideNametag()
		else
            -- Default message when a room doesn't have any specific dialogue for it.
	        cutscene:showNametag("J.A.R.U.")
            cutscene:text("* Ehhh, sorry kid. I got nothin' special to say about this place.", "default", "shadowsalesman")
            cutscene:text("* Maybe try lookin' elsewhere?", "default", "shadowsalesman")
	        cutscene:hideNametag()
        end
    else
    end
    cutscene:text("* (Click.)")
end
