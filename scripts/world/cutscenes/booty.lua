return {
    bootleg = function(cutscene, event)
		local fade_rect = Rectangle(0, 0, Game.world.width, Game.world.height)
		fade_rect:setColor(COLORS.black)
		local oldborder = Game.world.map.border
		Game:setBorder("none")
		Game.world:spawnObject(fade_rect, "below_ui")
		
		local booty = Sprite("battle/enemies/booty/idle", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
		booty:setOrigin(0.5,0.5)
		booty:setScale(2,2)
		Game.world:spawnObject(booty, "ui")
		
		Game.world.music:pause()
		
		local booty_music = Music()
		booty_music:play("booty")
		
		cutscene:wait(1)
		
		cutscene:showNametag("Booty")
        cutscene:text("* Howdy!")
        cutscene:text("* I'm Booty")
        cutscene:text("* Booty The Bootleg")
        cutscene:text("* ...")
        cutscene:text("* I see that you're not new here")
        cutscene:text("* You've been here a few times,[wait:5] haven't you?")
		if Game:hasPartyMember("jamm") then
			cutscene:showNametag("Jamm")
			cutscene:text("* I feel like I know you from somewhere...", "neutral", "jamm")
			cutscene:text("* Aren't you...[wait:5]\n* That Flowey ripoff?", "nervous", "jamm")
			
			cutscene:showNametag("Booty")
			cutscene:text("* Ripoff?[wait:5] Wow![wait:5]\n* You must be so confused!")
		end
		
		if Game:hasPartyMember("brenda") then
			cutscene:showNametag("Brenda")
			if Game:hasPartyMember("jamm") then
				cutscene:text("* Wow,[wait:5] Jamm...[wait:5]\n* You were right about this guy.", "frown", "brenda")
				cutscene:text("* He's really...[wait:5]\n* Uh...", "frown", "brenda")
				
				cutscene:showNametag("Jamm")
				cutscene:text("* Weird?[wait:5]\n* Yeah,[wait:5] I know.", "stern", "jamm")
			else
				cutscene:text("* Wow,[wait:5] Jamm was right about this guy.", "frown", "brenda")
				cutscene:text("* He's really...[wait:5]\n* Uh...", "frown", "brenda")
				cutscene:text("* Weird...", "frown_side", "brenda")
			end
			cutscene:showNametag("Booty")
		end
		
		cutscene:text("* Listen,[wait:5] I'll be brief")
		cutscene:text("* I could use some score points")
		cutscene:text("* You see,[wait:5] my family has been suffering for a while")
		cutscene:text("* I'm part of the royal family of Bootland,[wait:5] and...")
		cutscene:text("* Recently,[wait:5] the king's counselor has been trying to take us down")
		cutscene:text("* The counselor froze our account of at least a BILLION score points")
		cutscene:text("* I know a guy who can unfreeze the account,[wait:5] but I need to bribe him")
		cutscene:text("* He said he won't do it unless for a bribe of the amount of score points...")
		cutscene:text("* [color:yellow]The amount that you have")
		cutscene:text("* Please![wait:5]\n* I'll pay you back!")
		cutscene:text("* What?[wait:5]\n* You don't use score points?")
		cutscene:text("* D$?[wait:5]\n* Yeah,[wait:5] sure,[wait:5] that'll work")
		cutscene:text("* Just hurry up and give me the money")
		cutscene:text("* Remember,[wait:5] [color:yellow]all of your D$")
		cutscene:hideNametag()
		
		local choice = cutscene:choicer({"Pay", "Don't pay", "Fight"})
		if choice == 1 then
			Game.money = 0
			
			cutscene:showNametag("Booty")
			cutscene:text("* Pleasure doing business with you,[wait:5][wait:5] kiddo")
			cutscene:text("* And remember:[wait:5] I'll pay you back!")
			cutscene:text("* That's a promise!")
			cutscene:hideNametag()
			
			Game.world.timer:tween(1, booty, {alpha = 0}, "linear")
			booty_music:fade(0,1)
			cutscene:wait(1)
		elseif choice == 2 then
			cutscene:showNametag("Booty")
			cutscene:text("* No?")
			cutscene:text("* Alright,[wait:5] then")
			cutscene:text("* Kiddo,[wait:5] it's either pay me,[wait:5] or stay out")
			cutscene:text("* See ya next time!")
			
			Game:returnToMenu()
		else
			booty_music:pause(0,0)
			cutscene:showNametag("Booty")
			cutscene:text("* ...")
			cutscene:text("* Y-you want to fight?")
			cutscene:text("* Sure[wait:5]\n* I'll fight you!")
			cutscene:text("* I'll rip that wallet from your cold,[wait:5] dead hands!")
			cutscene:text("* HAHAHAHAHAHAHAHAHAHAHA")
			cutscene:hideNametag()
			
			Game.world.timer:tween(1, booty, {alpha = 0}, "linear")
			
			cutscene:wait(1)
			
			cutscene:text("* (A star-shaped power awakens from your SOUL.)")
			cutscene:text("* (To start aiming,[wait:5] press [bind:confirm].)")
			cutscene:text("* (You can press [bind:cancel] to back out and move,[wait:5] or...)")
			cutscene:text("* (Hold a direction and press [bind:confirm] to throw a star.)")
			
			Game:setBorder("battle")
			cutscene:startEncounter("big_booty")
			
			Game:setFlag("booty_finished", true)
		end
        
		cutscene:hideNametag()
		
		fade_rect:fadeOutAndRemove(1)
		Game:setBorder(oldborder)
		cutscene:wait(1)
		
		Game.world.music:resume()
    end
}
