return {
    brandon = function(cutscene, event)
        cutscene:showNametag("Brandon")
        if not Game:getFlag("brandon_talkedto") then
            if cutscene:getCharacter("kris") then
                cutscene:text("* Well,[wait:5] if it isn't Kris Deltarune themself.", "happy", "brandon")
                cutscene:showNametag("Susie")
                cutscene:text("* Okay,[wait:5] first of all,[wait:5] that isn't their last name.", "annoyed", "susie")
                cutscene:text("* Second of all,[wait:5] how the hell do you know their name?", "sus_nervous", "susie")
                cutscene:showNametag("Brandon")
                cutscene:text("* Eh,[wait:5] that isn't really important.", "happy", "brandon")
                cutscene:text("* Anyways...", "neutral", "brandon")
            end
            cutscene:text("* It's so cool that you guys showed up here.", "happy", "brandon")
            if cutscene:getCharacter("dess") then
                cutscene:text("* ... Minus one of you...", "miffed", "brandon")
                cutscene:showNametag("Dess")
                cutscene:text("* Gee I wonder who that could be lol", "condescending", "dess")
                cutscene:showNametag("Brandon")
            end
            cutscene:text("* Hey,[wait:5] could I join the party?", "happy", "brandon")
        else
            cutscene:text("* So,[wait:5] did you change your mind?", "happy", "brandon")
        end
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Yes", "No"})
        if opinion == 1 then
            cutscene:showNametag("Brandon")
            cutscene:text("* Nice,[wait:5] thanks!", "happy", "brandon")
            if #Game.party >= 4 then
                cutscene:text("* Hold on,[wait:5] it looks like you've got a full party.", "neutral", "brandon")
                cutscene:text("* Well,[wait:5] I'll still be in your party.", "happy", "brandon")
                cutscene:text("* Just in the \"reserves\",[wait:5] so to speak.", "neutral", "brandon")
                cutscene:text("* If you want me to help in battles,[wait:5] head to the Party Room.", "happy", "brandon")
                event:setFacing("right")
                cutscene:text("* Go straight that way,[wait:5] it should be the first door on your left.", "happy", "brandon")
                event:setFacing("down")
                cutscene:text("* Cya!", "happy", "brandon")
                cutscene:hideNametag()
                cutscene:walkTo(event, -100, event.y + 50, 3, "left")
                cutscene:wait(2)
            else
                Game:addPartyMember("brandon")
                if #Game.party >= 3 then
                    event:convertToFollower(3)
                elseif #Game.party == 2 then
                    event:convertToFollower(2)
                else
                    event:convertToFollower(1)
                end
                cutscene:hideNametag()
                cutscene:attachFollowers()
                cutscene:text("* Brandon joined the party.")
                cutscene:wait(0.5)
            end
            Game:setFlag("brandon_inparty", true)
            table.insert(Game:getFlag("party"), "brandon")
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Ah,[wait:5] okay then.", "frown", "brandon")
            cutscene:text("* Well,[wait:5] I'm always here if you change your mind.", "happy", "brandon")
            Game:setFlag("brandon_talkedto", true)
        end
        cutscene:hideNametag()
    end,
	charshop = function(cutscene, event)
	
		if Game.inventory:hasItem("mistcard") then
			cutscene:showNametag("Char")
			cutscene:text("* Thank you lots.")
		else
		
			if not Game:getFlag("gotCharQuest1") then
				cutscene:showNametag("Char")
				cutscene:text("* Heya there.")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* So uhh...", "neutral_side", "susie")
					cutscene:text("* Who are you?", "neutral", "susie")
				else
					cutscene:hideNametag()
					cutscene:text("* (You ask him who he is.)")
				end
				
				cutscene:showNametag("Char")
				cutscene:text("* Oh, I'm Char.[wait:10]\n* Got kicked out of the main area so now I'm in the party room.")
				
				if cutscene:getCharacter("dess") then
					cutscene:showNametag("Dess")
					cutscene:text("* Oh yo me too", "condescending", "dess")
					cutscene:showNametag("Char")
					cutscene:text("* ...")
				end
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* So why did you get kicked out?", "neutral", "susie")
				else
					cutscene:hideNametag()
					cutscene:text("* (You asked why he got kicked out.)")
				end
				
				cutscene:showNametag("Char")
				cutscene:text("* Oh,[wait:5] I set fire to a table by accident.")
				cutscene:text("* But to be honest...")
				cutscene:text("* I think the decision to outright ban me was due to my part in helping to create Dess.")
				
				if cutscene:getCharacter("dess") then
					cutscene:showNametag("Dess")
					cutscene:text("* Thank ya for that", "heckyeah", "dess")
					cutscene:showNametag("Char")
					cutscene:text("* Yeah,[wait:5] sure,[wait:5] whatever.")
				end
				
				cutscene:text("* Also by the way I'm not technically supposed to be here either.")
				cutscene:text("* Please don't tell them I'm here.")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* Uhh,[wait:5] sure alright.", "nervous", "susie")
					cutscene:showNametag("Char")
				end
				
				
				cutscene:text("* Anyways...")
				
				cutscene:text("* That reminds me.[wait:10]\n* Trouble's afoot.")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* Hm?", "neutral", "susie")
					cutscene:showNametag("Char")
				end
				
				cutscene:text("* So like... there's this big forest right?")
				cutscene:text("* An uh,[wait:5] I was kinda just walking around in it when the fog suddenly got real dense.")
				cutscene:text("* Then the locals started to freak the heck out,[wait:5] so I took off.")
				cutscene:text("* I had a friend over there,[wait:5] and I don't quite like the thought of them being hurt.")
				cutscene:text("* You guys are like,[wait:5] heroes right?[wait:10]\n* Can you go take a look at it?")
				
				if cutscene:getCharacter("susie") then
					cutscene:showNametag("Susie")
					cutscene:text("* I guess we'll see what we can do??", "neutral_side", "susie")
				else
					cutscene:hideNametag()
					cutscene:text("* (You agreed without thinking about it for some reason.)")
				end
				
				cutscene:showNametag("Char")
				cutscene:text("* Great,[wait:10] you're the best.")
				
				cutscene:text("* Oh yeah, and [color:yellow]the code to get there is [color:blue]UWFOREST[color:reset].")
				
				cutscene:hideNametag()
				Game:setFlag("gotCharQuest1", true)
			else
				cutscene:showNametag("Char")
				cutscene:text("* Any updates yet?")
				
				if not Game:getFlag("finishedCharQuest1") then
					
					if cutscene:getCharacter("susie") then
						cutscene:showNametag("Susie")
						cutscene:text("* Nope.", "neutral", "susie")
					else
						cutscene:hideNametag()
						cutscene:text("* (You explain the current status.")
					end
					
					cutscene:showNametag("Char")
					cutscene:text("* Oh,[wait:10] dang.")
					
				else
					if cutscene:getCharacter("susie") then
						cutscene:showNametag("Susie")
						cutscene:text("* Yeah![wait:10] We fought a big ghost thing!", "surprise_smile", "susie")
					else
						cutscene:hideNametag()
						cutscene:text("* (You explain the current status.")
					end
					
					cutscene:showNametag("Char")
					cutscene:text("* Oh,[wait:5] sick.")
					cutscene:text("* Oh man,[wait:5] that must've been a lot of trouble though.")
					cutscene:text("* Lemmie see if I have anything on me...")
					cutscene:text("* ...[wait:10] oh,[wait:5] I see.")
					cutscene:text("* Here, take this.")
					
					local canTakeCard = Game.inventory:addItem("mistcard")
					
					if canTakeCard then
						cutscene:hideNametag()
						Assets:playSound("item")
						cutscene:text("* (You got the MistCard.)")
						cutscene:showNametag("Char")
						cutscene:text("* Thank you lots.")
					else
						cutscene:text("* ...")
						cutscene:text("* You don't have any more room for key items??")
						cutscene:text("* Man,[wait:5] what the hell even is this mod anymore if you accidentally see this text in-game.")
					end
				end
				
				
			end
		
		end
			
		cutscene:hideNametag()
	end,
	velvet = function(cutscene, event)
        if event.interact_count == 1 then
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "looking_down", "velvet")
            cutscene:hideNametag()
            cutscene:wait(1)
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* ...?", "default", "velvet")
            cutscene:setSpeaker(velvet)
            cutscene:text("* Sup!", "pissed_b", "velvet")
            cutscene:hideNametag()
            velvet:resetSprite()
        
        elseif event.interact_count == 2 then
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "looking_down", "velvet")
            cutscene:hideNametag()
            cutscene:wait(1)
            velvet:setAnimation("phone_look_up")
            cutscene:wait(1)
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:showNametag("Velvet")
            cutscene:text("* How can I help?", "default", "velvet")
            velvet:setAnimation("phone_look_up")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Dunno... you just look like a Maus.", "neutral")
                cutscene:text("* Except all depressed and gray-looking.", "nervous")
                cutscene:hideNametag()
            end

            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "surprised", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* Okay then?", "surprised_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 3 then
            local velvet = cutscene:getCharacter("velvet")
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* What?", "pissed", "velvet")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Stop looking at your phone!", "annoyed")
                cutscene:hideNametag()
            end

            cutscene:showNametag("Velvet")
            velvet:setAnimation("pissed_talk")
            cutscene:setSpeaker(velvet)
            cutscene:text("* So?", "pissed", "velvet")
            cutscene:text("* I get to decide if I want to ignore people...", "pissed_b", "velvet")
            cutscene:text("* That includes rude purple dinosaurs!", "smile_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* ...... ", "shy_b")
                cutscene:text("* Geez that rat is feisty...", "shy_b")
                cutscene:hideNametag()
            end

        elseif event.interact_count == 4 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Hey YOU watch this...\n * This is gonna make her talk for sure!", "smile")
                cutscene:text("* You're the one who gave Spamton a blanket, right?", "sincere_smile")
                cutscene:hideNametag()
            end
            
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            velvet:setAnimation("smile_look_up")
            cutscene:text("* !!!", "shock", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("smile_talk")
            cutscene:text("* Did I hear that right?\n * You said Spamton with a blanket?", "surprised_b", "velvet")
            velvet:setAnimation("smile_look_up")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Absolutely! Is that really you?", "sincere_smile")
                cutscene:hideNametag()
            end
           
            velvet:setAnimation("smile_no_phone")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            cutscene:text("* Glad you asked! I am the creator!", "smile_b", "velvet")
            cutscene:text("* Wanna hear more about him?", "smile", "velvet")
            velvet:setAnimation("idle_smile_no_phone")
            cutscene:hideNametag()

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* ......", "sus_nervous")
                cutscene:text("* Actually, nevermind. I don't wanna hear it...", "nervous")
                cutscene:hideNametag()
            end

            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("smile_no_phone")
            cutscene:text("* Oh it's fine... No hard feelings!", "smile_b", "velvet")
            velvet:setAnimation("pissed_no_phone")
            cutscene:text("* After all... I don't talk to mean purple lizards...", "pissed_b", "velvet")
            cutscene:hideNametag()
            velvet:setAnimation("idle_pissed_no_phone")

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* ...... ", "surprise")
                cutscene:text("* What did I even say? ", "surprise_frown")
                cutscene:hideNametag()
            end

            velvet:resetSprite()

        elseif event.interact_count == 5 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Hey if you're a Maus, can you squeak?", "nervous_side")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "surprised", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* Say what now?", "surprised_b", "velvet")
            cutscene:hideNametag()
            velvet:setAnimation("phone_look_up")

            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* If you can squeak like a Maus?", "nervous_side")
                cutscene:hideNametag()
            end

            velvet:setAnimation("phone_look_up")
            cutscene:showNametag("Velvet")
            cutscene:text("* .....", "pissed", "velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("pissed_talk")
            cutscene:text("* Yea no... Fat chance!", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 6 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 7 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 8 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 9 then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:setSpeaker(susie)
                cutscene:text("* Squeak...", "smile")
                cutscene:hideNametag()
            end

            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* No...", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()

        elseif event.interact_count == 10 then
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* Okay fine, you wanna to hear it so you can shut up?", "pissed", "velvet")
            cutscene:text("* Well, here it is...", "pissed_b", "velvet")
            cutscene:hideNametag()

            Game.world.music:pause()
            cutscene:wait(2.5)
            Assets.playSound("velvetsqueak")
            cutscene:setSpeaker(default)
            cutscene:showNametag("Velvet")
            cutscene:text("* Squeak!", "smile_b", "velvet")
            cutscene:hideNametag()

            cutscene:wait(1)

            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            cutscene:text("* There I squeaked!\n * Never going to do that again!", "default", "velvet")
            cutscene:hideNametag()

            velvet:resetSprite()
            Game.world.music:resume()

            Kristal.callEvent("completeAchievement", "velvetsqueak")

        else
            local velvet = cutscene:getCharacter("velvet")
            cutscene:showNametag("Velvet")
            cutscene:setSpeaker(velvet)
            velvet:setAnimation("phone_look_up")
            cutscene:text("* Stop bothering me...\n * I squeaked once and I am not gonna do it again!", "pissed_b", "velvet")
            velvet:resetSprite()
            cutscene:hideNametag()
	    end
    end,
    wardrobe = function(cutscene, event)
        cutscene:text("* (It's a wardrobe.)\n* (What drawer would you like to open?)")

        local menu = cutscene:choicer({ "Party", "Costumes" })

        if menu == 1 then
            cutscene:after(function()
                Game.world:openMenu(DarkPartyMenu())
            end)
        else
            cutscene:after(function()
                Game.world:openMenu(Costumes())
            end)
        end
    end,
	  dumbie = function(cutscene, event)
        if not Game:getFlag("dumbie_talkedto") then
            local dumbie = cutscene:getCharacter("dumbie")
            cutscene:showNametag("Dummy?")
            cutscene:text("* I'm a Dummy.", "fear", "dumbie")
			cutscene:showNametag("Susie")
			cutscene:text("* Uh, no you're not?", "sus_annoyed", "susie")
			cutscene:showNametag("Dumbie")
			cutscene:text("* Well, your mom didn't say that!", "angryforward", "dumbie")
			cutscene:text("* ...", "confused", "dumbie")
			cutscene:text("* I'm a Dummy.", "fear", "dumbie")
			cutscene:hideNametag()
            Game:setFlag("dumbie_talkedto", true)
        elseif Game:getFlag("dumbie_talkedto") then
            local dumbie = cutscene:getCharacter("dumbie")
            cutscene:showNametag("Dumbie")
            cutscene:text("* Hey, your party is a bit, empty, do you want me to enter?", "eyeshappy", "dumbie")
            cutscene:hideNametag("Dumbie")
	        local opinion = cutscene:choicer({"Yes", "No"})
			if opinion == 1 then
			    cutscene:showNametag("Dumbie")
			    cutscene:text("* Heck yeah!", "veryhappy", "dumbie")
			    Game:addPartyMember("dumbie")
			    if cutscene:getCharacter("dess") then
			        event:convertToFollower(3)
			    else
			        event:convertToFollower(2)
			    end
			    cutscene:hideNametag()
			    cutscene:attachFollowers()
			    cutscene:text("* Dumbie joined the party.")
			    cutscene:wait(0.5)
			    Game:setFlag("dumbie_inparty", true)
                table.insert(Game:getFlag("party"), "dumbie")
            else
			    cutscene:showNametag("Dumbie")
			    cutscene:text("* So, go to penis!", "angryforward", "dumbie")
			    cutscene:text("* But, i'm here if you change your mind.", "normal", "dumbie")
			    cutscene:hideNametag()
            end
		    end
    end,
    shadowshop = function(cutscene, event)
        Game:enterShop("shadowsalesman")
    end,
}
