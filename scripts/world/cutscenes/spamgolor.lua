return {
    intro = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local noel = cutscene:getCharacter("noel")
        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Hey uh...", "nervous_side", "susie")
            cutscene:text("* Has this alleyway always been here?", "nervous", "susie")
            if noel then
                local text = "* Why don't we ask that [color:yellow]fucker"
                local text2 = "* Why don't we ask that [color:yellow]funny lookin man[color:reset]?"  
                local speaker = "noel" 
                local texts = {"I'M", "NOT", "ALLOWED", "TO", "SWEAR"}                                     
                local faces = {"excusemebutwhatthefuck", "oh", "loud_2", "c_neutral", "madloud_1"}
                cutscene:setTextboxTop(true)
                cutscene:undoMyFuckup(text, text2, speaker, texts, faces)
                cutscene:setTextboxTop(false)
            else
                cutscene:text("* Wait,[wait:5] who's that guy over there?", "nervous_side", "susie")
            end
            cutscene:hideNametag()
        elseif noel then
            cutscene:showNametag("Noel")
            cutscene:text("* Wanna see somthin cool?", "bruh", "noel")
            cutscene:hideNametag()
        end

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
        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "suspicious", "susie")
        end

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

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Who?", "suspicious", "susie")
            cutscene:text("* Wait,[wait:5] are you talking about that Spamton guy?", "suspicious", "susie")
            if cutscene:getCharacter("dess") then 
                cutscene:showNametag("Dess")
                cutscene:text("[noskip]* oh yes,[wait:5] they must mean spamton,[wait:5] oh my![wait:5]", "wink", "dess", {auto = true})
                cutscene:text("[noskip]* he's the one with the sneaky eye.[wait:5]", "smug", "dess", {auto = true})
                if noel then
                    cutscene:showNametag("Noel")
                    cutscene:text("[noskip]* The Spamton guy?[wait:5]\n* Oh no,[wait:5] we don't speak of that Spamton guy.[wait:5]", "neutral", "noel", {auto = true})
                    cutscene:text("[noskip]* Only the man with the broken eye,[wait:5] ever dares to whisper 'Spamton' nearby.[wait:5]", "lookup", "noel", {auto = true})
                    cutscene:showNametag("Dess")
                    cutscene:text("[noskip]* it's true,[wait:5] it's true,[wait:5] i tell no lie,[wait:5] the tales i've heard will make you sigh.[wait:5]", "kind", "dess", {auto = true})
                    cutscene:showNametag("Noel")
                    cutscene:text("[noskip]* He's as sneaky as a cat,[wait:5] as sly as a fox,[wait:5] and his words are as tricky as paradox.[wait:5]", "neutral", "noel", {auto = true})
                    cutscene:text("[noskip]* They say he deals in deals and tricks,[wait:5] and his bargains can give you quite the fix.[wait:5]", "huh", "noel", {auto = true})
                    cutscene:showNametag("Dess")
                    cutscene:text("[noskip]* but beware,[wait:5] oh beware,[wait:5] of his shifty charm,[wait:5] for his promises might lead you to harm.[wait:5]", "kind", "dess", {auto = true})
                    cutscene:text("[noskip]* so heed this warning,[wait:5] my dear friend,[wait:5] with Spamton,[wait:5] there's no knowing how it'll end.[wait:5]", "calm", "dess", {auto = true})
                    cutscene:showNametag("Noel")
                    cutscene:text("[noskip]* You might think it's fun,[wait:5] you might think it's a GAME,[wait:5] but with Spamton,[wait:5] you'll never be the same.[wait:5]", "lookup", "noel", {auto = true})
                    cutscene:showNametag("Dess")
                    cutscene:text("[noskip]* yes,[wait:5] it's a story,[wait:5] a tale full of fright,[wait:5] so let's not discuss him,[wait:5] not day or night.[wait:5]", "wink", "dess", {auto = true})
                    cutscene:showNametag("Noel")
                    cutscene:text("[noskip]* Agreed,[wait:5] agreed,[wait:5] let's leave it be,[wait:5] and steer clear of that Spamton,[wait:5] just you and me--", "neutral", "noel", {auto = true})
                    cutscene:showNametag("Susie")
                    cutscene:text("[noskip]* Hey![wait:5] What the hell are you two doing!!!", "angry", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("[noskip]* chill,[wait:5] we just [color:yellow]DR.SEUSS[color:white]ing.", "wink", "dess")
                    cutscene:showNametag("Noel")
                    cutscene:text("[noskip]* sorry susie...", "oh", "noel")
                else
                    cutscene:showNametag("Susie")
                    cutscene:text("* no...", "angry", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("* what,[wait:5] can't handle some [color:yellow]DR.SEUSS[color:white]ing?", "wink", "dess")
                end
            end

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
        else
            spamgolor:setSprite("hurt")
            cutscene:text("* You forgot that Susie could never always exist [DEVELOPER].", "", "spamgolor")
            cutscene:text("* Shame on you.", "", "spamgolor")
            if cutscene:getCharacter("noel") then
                cutscene:showNametag("Noel")
                cutscene:text("* Player, tab out the game.", "...", "noel")
                cutscene:text("* Enter the Dark place discord.", "...", "noel")
                cutscene:text("* Tell brenda to fix that and replace this dialouge.", "...", "noel")
                cutscene:text("* I'm writing this instead of fixing it because im swag like that.", "...", "noel")
            end
            cutscene:hideNametag()
        end

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
        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "neutral_side", "susie")
            cutscene:text("* That was weird.", "annoyed", "susie")
            if noel then
                cutscene:text("* Shut up Susie.", "...", "noel")
                cutscene:text("* What did you say?", "teeth", "susie")
                cutscene:text("* n-nothing!", "oh", "noel")
            end
            if cutscene:getCharacter("brenda") then
                cutscene:showNametag("Brenda")
                cutscene:text("* Uh,[wait:5] yeah,[wait:5] you can say that again.", "neutral", "brenda")
            end
		if cutscene:getCharacter("jamm") then
			cutscene:showNametag("Jamm")
            cutscene:text("* No argument here.", "neutral", "jamm")
		end
        end
        cutscene:hideNametag()

        cutscene:attachCamera()
    end
}
