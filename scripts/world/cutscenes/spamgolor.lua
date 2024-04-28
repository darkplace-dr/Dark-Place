return {
    intro = function(cutscene, event)
        cutscene:showNametag("Susie")
        cutscene:text("* Hey uh...", "nervous_side", "susie")
        cutscene:text("* Has this alleyway always been here?", "nervous", "susie")
        cutscene:text("* Wait,[wait:5] who's that guy over there?", "nervous_side", "susie")
        cutscene:hideNametag()

        cutscene:detachCamera()
        local x = event.x + event.width/2
        local y = event.y + event.height/2
        cutscene:wait(cutscene:panTo(x + 100, y))
        Game.world.music:play("spamgolor_heyevery", 1, 1)

        cutscene:showNametag("Spamgolor")
        cutscene:text("* WHY,[wait:5] HELLO THERE !!", "", "spamgolor")
        local spamgolor = cutscene:getEvent(13)
        spamgolor:setSprite("greeting")
        cutscene:text("* I'M YOUR FRIENDLY [[NumberOneRatedSalesman2011]]!", "", "spamgolor")
        spamgolor:shake(3)
        spamgolor:setSprite("hurt")
        cutscene:text("[noskip]* SPAM-", "", "spamgolor", {auto = true})
        spamgolor:setSprite("idle")
        spamgolor:slideTo(x + 300, y, 0.5)
        cutscene:text("* SPAMGOLOR M. SPAMGOLOR!", "", "spamgolor")

        Game.world.music:fade(0, 0.5)

        cutscene:showNametag("Susie")
        cutscene:text("* ...", "suspicious", "susie")

        Game.world.music:fade(1, 0)
        Game.world.music:play("spamgolor", 1, 1)

        cutscene:showNametag("Spamgolor")
        cutscene:text("* HAVE YOU COME TO [[Microtransaction]] ONE OF MY PRODUCTS?", "", "spamgolor")
        cutscene:text("* WAIT A MINUTE...", "", "spamgolor")
        spamgolor:setSprite("wowza")
        spamgolor:slideTo(x + 200, y, 0.5)
        cutscene:text("* IS THAT A [[HeartShapedObject]] YOU HAVE THERE?", "", "spamgolor")
        spamgolor:setAnimation("glitch")
        cutscene:text("* I MUST HAVE THAT [[Specil item]] AT ONCE!", "", "spamgolor")
        cutscene:text("* WITH IT,[wait:5] I BET I'LL BE ABLE TO SURPASS THAT [[Copyright Infringement]]!", "", "spamgolor")

        cutscene:showNametag("Susie")
        cutscene:text("* Who?", "suspicious", "susie")
        cutscene:text("* Wait,[wait:5] are you talking about that Spamton guy?", "suspicious", "susie")

        cutscene:showNametag("Spamgolor")
        spamgolor:setSprite("idle")
        cutscene:text("* EXACTLY!!!\n[wait:10]* THAT GUY'S A COMPLETE [[Ripoff]]!", "", "spamgolor")

        cutscene:showNametag("Susie")
        cutscene:text("* Honestly,[wait:5] you look like the ripoff here to me.", "annoyed", "susie")

        spamgolor:shake(3)
        cutscene:showNametag("Spamgolor")
        cutscene:text("* WHAT DID YOU JUST SAY!?", "", "spamgolor")
        cutscene:text("* AM I STILL...", "", "spamgolor")
        spamgolor:setSprite("hurt")
        cutscene:text("* Not big enough...?", "", "spamgolor")
        spamgolor:setAnimation("glitch")
        cutscene:text("* I'LL SHOW YOU WHAT I'VE GOT!", "", "spamgolor")

        cutscene:showNametag("Susie")
        cutscene:text("* Well,[wait:5] if it's a fight you want...", "teeth_smile", "susie")
        cutscene:text("* THEN IT'S A FIGHT YOU'LL GET!", "teeth_b", "susie")
        cutscene:hideNametag()

        cutscene:startEncounter("spamgolor", true, {{"spamgolor", spamgolor}})

        spamgolor:setSprite("idle")
        Game:setFlag("spamgolor_defeated", true)
        cutscene:showNametag("Spamgolor")
        cutscene:text("* WOW,[wait:5] THAT WAS CERTAINLY [[A fight to remember]]!", "", "spamgolor")
        cutscene:text("* HEY,[wait:5] I'VE ACTUALLY GOT A [[In-game store]] OF MY OWN.", "", "spamgolor")
        cutscene:text("* IT'S IN THE [[Warp Zone]].[wait:10]\n* FIRST DOOR ON THE LEFT.", "", "spamgolor")
        cutscene:text("* AND DON'T FORGET...", "", "spamgolor")
        spamgolor:setAnimation("glitch")
        cutscene:text("* TO [[Rate 5 stars]]!!", "", "spamgolor")
        cutscene:text("* EHAHAHAHA!", "", "spamgolor")
        cutscene:hideNametag()

        spamgolor:slideTo(x + 1000, y, 3)
        Game.world.music:fade(0, 1)
        cutscene:wait(2)

        cutscene:showNametag("Susie")
        cutscene:text("* ...", "neutral_side", "susie")
        cutscene:text("* That was weird.", "annoyed", "susie")
        if cutscene:getCharacter("brenda") then
            cutscene:showNametag("Brenda")
            cutscene:text("* Uh,[wait:5] yeah,[wait:5] you can say that again.", "neutral", "brenda")
        end
		if cutscene:getCharacter("jamm") then
			cutscene:showNametag("Jamm")
            cutscene:text("* No argument here.", "neutral", "jamm")
		end
        cutscene:hideNametag()

        cutscene:attachCamera()
    end
}
