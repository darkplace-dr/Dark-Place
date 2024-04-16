return {
    b = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")

        -- You killed them, didn't you?
        cutscene:wait(2)

        Game.world.music:fade(0, 0.5)

        cutscene:showNametag("Brandon")
        cutscene:text("[speed:0.2]* ...", "frown_side", "brandon")
        cutscene:text("* What...[wait:5] the hell was that?", "frown_side", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Hm?", "neutral_side", "susie")
        end

        cutscene:hideNametag()
        -- You claim you're a good person and yet...
        cutscene:wait(2)

        cutscene:showNametag("Brandon")
        cutscene:text("* I...[wait:5] I think?", "neutral_side", "brandon")
        cutscene:text("* What the hell are you talking about?", "frown", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* You okay dude?", "neutral", "susie")
        end

        cutscene:hideNametag()
        -- Good people don't kill other people.
        -- What about their families?
        -- What will they think about you slaughtering their own kin?
        cutscene:wait(4)

        cutscene:showNametag("Brandon")
        cutscene:text("* I...[wait:10]\n* I just...", "sad", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Uh...", "sad", "susie")
        end

        cutscene:hideNametag()
        -- You just what? Getting stronger?
        cutscene:wait(2)

        cutscene:showNametag("Brandon")
        cutscene:text("* N-no it's not that!", "sad_b", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Okay you're starting to scare me.", "shock_nervous", "susie")
        end

        cutscene:hideNametag()
        -- Don't lie to yourself, you could have stopped at any time.
        -- But you just complied with Them
        cutscene:wait(3)

        cutscene:showNametag("Brandon")
        cutscene:text("* W-who are you talking about?", "sad", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Brandon...?", "sad", "susie")
        end

        cutscene:hideNametag()
        -- The Player. You are complicite with Their actions.
        -- Be honest, you just want to see your stats increase.
        cutscene:wait(3)

        cutscene:showNametag("Brandon")
        cutscene:text("* N-no...", "sad_b", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Y-you good dude?", "sad_frown", "susie")
        end

        cutscene:hideNametag()
        -- You are nothing more than a monster
        -- You think you are above consequences just because you helped create this place?
        cutscene:wait(3)

        cutscene:showNametag("Brandon")
        cutscene:text("* Shut up...", "mad", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "shock", "susie")
        end

        cutscene:hideNametag()
        -- You think that you can toy with this world?
        cutscene:wait(2)

        cutscene:showNametag("Brandon")
        cutscene:text("* Shut up.", "livid_b", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Hey uh,[wait:5] calm down.", "shock_nervous", "susie")
        end

        cutscene:hideNametag()
        -- What would your friends think if they knew how horrible you really are?
        cutscene:wait(2)

        cutscene:showNametag("Brandon")
        cutscene:text("* SHUT UP!", "livid", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Dude,[wait:5] just take some deep breaths.", "sad_frown", "susie")
        end

        cutscene:hideNametag()
        -- You're nothing but filth
        cutscene:wait(2)

        cutscene:showNametag("Brandon")
        cutscene:text("* SHUT UP SHUT UP SHUT UP!!", "crying_b", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Please,[wait:5] we're here for you man.", "sad_frown", "susie")
        end

        cutscene:hideNametag()
        -- I think we are done here.
        -- I hope you're happy with what you're doing.
        cutscene:wait(3)

        cutscene:showNametag("Brandon")
        cutscene:text("* ...", "sad", "brandon")
        cutscene:text("* Sorry,[wait:5] I...", "frown_side", "brandon")
        cutscene:text("* Look,[wait:5] just forget that ever happened,[wait:5] okay?", "frown", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Uh,[wait:5] okay?", "sus_nervous", "susie")
        end

        cutscene:showNametag("Brandon")
        cutscene:text("* I'm fine.", "happy", "brandon")
        cutscene:text("* ...", "frown_side", "brandon")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "sus_nervous", "susie")
        end

        cutscene:hideNametag()

        Game:setFlag("thoughts", "true")
    end,

    entrance = function(cutscene, event)
        local x,y = event.x + event.width/2, event.y + event.height/2
        cutscene:detachCamera()
        cutscene:wait(cutscene:panTo(x, y-30))
        cutscene:showNametag("Susie")
        cutscene:text("* Hey,[wait:5] isn't that Brandon?", "surprise", "susie")
        cutscene:hideNametag()
        local brandon = cutscene:getCharacter("brandon")
        brandon:walkTo(x, -60, 2, "up")
        cutscene:wait(1.5)
        cutscene:showNametag("Susie")
        cutscene:text("* Hey![wait:10] Brandon,[wait:5] wait up!", "surprise_frown", "susie")
        cutscene:hideNametag()
        local susie = cutscene:getCharacter("susie")
        cutscene:wait(cutscene:attachCamera())
        Game:setFlag("b_entrance", true)
    end,

    voidremark = function(cutscene, event)
        cutscene:showNametag("Susie")
        cutscene:text("* Man,[wait:5] just what the heck ARE those black orb things?", "nervous", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* idk but maybe they're related to shade enemies?", "eyebrow", "dess")
        cutscene:showNametag("Jamm")
        cutscene:text("* I highly doubt that.", "look_left", "jamm")
        cutscene:text("* They're completely black,[wait:5] instead of being shades of blue.", "neutral", "jamm")
        cutscene:showNametag("Susie")
        cutscene:text("* Well,[wait:5] whatever they are,[wait:5] they give me the creeps.", "nervous", "susie")
        cutscene:showNametag("Jamm")
        cutscene:text("* You can say that again.", "nervous", "jamm")
        cutscene:showNametag("Susie")
        cutscene:text("* I don't think I've ever seen an enemy that refuses mercy.", "nervous_side", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* does that mean we can beat the shit out of them?", "challenging", "dess")
        cutscene:showNametag("Susie")
        cutscene:text("* Heh,[wait:5] now we're talking!", "smile", "susie")
        cutscene:showNametag("Jamm")
        cutscene:text("* Or,[wait:5] we can try and tire them out and pacify them.", "smirk", "jamm")
        cutscene:showNametag("Susie")
        cutscene:text("* I guess that works too.", "small_smile", "susie")
        cutscene:text("* Let's get going,[wait:5] guys.", "smile", "susie")
        cutscene:hideNametag()
    end,

    susiespell = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local jamm = cutscene:getCharacter("jamm")
        local x,y = event.x + event.width/2, event.y + event.height/2
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo(x,y)
        susie:walkTo(x, y + 50, 2, "down")
        dess:walkTo(x - 40, y - 20, 2, "down")
        jamm:walkTo(x + 40, y - 20, 2, "down")
        cutscene:wait(2)
        cutscene:showNametag("Susie")
        cutscene:text("* Jeez,[wait:5] these orb things are pretty tough...", "nervous_side", "susie")
        cutscene:showNametag("Jamm")
        cutscene:text("* Yeah,[wait:5] if this keeps up...", "nervous", "jamm")
        cutscene:text("* ... I feel like we're gonna have to spam healing items.", "nervous_left", "jamm")
        cutscene:showNametag("Dess")
        cutscene:text("* hey susie don't you have a healing spell", "neutral", "dess")
        susie:setFacing("up")
        cutscene:showNametag("Susie")
        cutscene:text("* I mean yeah I do-", "nervous", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* oh wait i just remembered it sucks ass", "genuine", "dess")
        cutscene:showNametag("Susie")
        cutscene:text("* Wh-", "shock", "susie")
        cutscene:text("* HEY!!!", "teeth_b", "susie")
        jamm:setFacing("left")
        cutscene:showNametag("Jamm")
        cutscene:text("* I mean...[wait:10] she DOES have a point.", "look_left", "jamm")
        jamm:setFacing("down")
        cutscene:text("* Are you like,[wait:5] unable to use Heal Prayer?", "stern", "jamm")
        susie:setFacing("right")
        cutscene:showNametag("Susie")
        cutscene:text("* Uhh...", "sus_nervous", "susie")
        susie:setFacing("up")
        cutscene:showNametag("Dess")
        cutscene:text("* yeah susie you gotta pray to Jesus Christ", "heckyeah", "dess")
        cutscene:showNametag("Susie")
        cutscene:text("* ...", "nervous", "susie")
        cutscene:text("* Who the hell is THAT?", "nervous_side", "susie")
        jamm:setFacing("left")
        cutscene:showNametag("Jamm")
        cutscene:text("* No not THAT kind of prayer,[wait:5] Dess!", "determined", "jamm")
        jamm:setFacing("down")
        cutscene:text("* Look,[wait:5] just do what Ralsei does.", "stern", "jamm")
        cutscene:text("* I'm sure you've seen him use that spell lots of times.", "neutral", "jamm")
        cutscene:showNametag("Susie")
        cutscene:text("* Hmm...", "neutral_side", "susie")
        cutscene:text("* I dunno if I'll be AS good as him,[wait:5] but...", "small_smile", "susie")
        cutscene:text("* I'll try my best.", "sincere_smile", "susie")
        susie:setFacing("down")
        cutscene:hideNametag()
        local sus_party = Game:getPartyMember("susie")
        sus_party:removeSpell("ultimate_heal")
        sus_party:addSpell("ultimate_heal_ex")
        cutscene:text("* Susie's ULTIMATEHEAL spell got upgraded!")
        cutscene:text("* It now costs less TP and heals for more.")
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end,
}