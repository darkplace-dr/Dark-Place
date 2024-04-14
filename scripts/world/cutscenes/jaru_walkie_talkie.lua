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
        Game:getFlag("jaruHasUsedWalkieTalkie", true)
	    cutscene:hideNametag()
	else
        Game:getFlag("jaruHasUsedWalkieTalkie", true)
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
            cutscene:text("* Just so we're on the same page here,[wait:5][facec:annoyed] I'm referring to Dess.", "default", "shadowsalesman")
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
			if Game:hasPartyMember("dess") then
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
		    local everhall_count = Game:getFlag("hallways") -- having trouble getting the value of the flag to display properly.
	        
            cutscene:showNametag("J.A.R.U.")
            cutscene:text("* So you're going through the whole hallway,[wait:5] eh?", "annoyed", "shadowsalesman")
            cutscene:text("* How many rooms have you gone through?", "default", "shadowsalesman")
            cutscene:text("* ...[wait:5][color:yellow]"..everhall_count.."[color:reset]?", "eye_closed", "shadowsalesman")
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
                Game:getFlag("jaruHasTalkedAboutAlexa", true)
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
