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
    end
}