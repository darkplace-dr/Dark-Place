return {
    chan = function(cutscene, event)
        cutscene:showNametag("Kris-Chan")
        cutscene:text("* Go! Sonichu! Go out and zap to the extreme!")
        cutscene:text("* Sonichu! Use EXPLOSION!!!")
        cutscene:hideNametag()

        event:explode()

        local susie = cutscene:getCharacter("susie")
        if susie then
            cutscene:wait(3)

            cutscene:setSpeaker(susie)
            cutscene:showNametag("Susie")
            cutscene:text("* What?", "shock")
            cutscene:hideNametag()
        end
    end,

    toriel3d = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:setSpeaker(susie)
            cutscene:text("* Hey, isn't that Kris's mom?", "suspicious")
            cutscene:hideNametag()
        end

        cutscene:setSpeaker(nil)
        cutscene:showNametag("3D Toriel")
        cutscene:text("* Silence my child")
        cutscene:hideNametag()

        event:explode()

        if susie then
            cutscene:wait(3)

            cutscene:setSpeaker(susie)
            cutscene:showNametag("Susie")
            cutscene:text("* What the fu-", "shock")
            cutscene:hideNametag()
        end
    end,

    poseur = function(cutscene, event)
        cutscene:text("* It's a mannequin.[wait:10] Do you want to fight it?")

        if cutscene:choicer({"Yes", "No"}) == 2 then
            return
        end

        local encounter = cutscene:startEncounter("poseur", true, {{"poseur", event}})

        if encounter:getDefeatedEnemies()[1].done_state == "KILLED" then
            event:remove()
            Game:setFlag("poseur_killed", true)

            Game.world.music:fade(0, 0.5)
            cutscene:wait(2)

            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "neutral_side", "susie")
                cutscene:text("* This feels...", "annoyed_down", "susie")
                cutscene:text("* Not right at all...", "shy_down", "susie")

                if cutscene:getCharacter("dess") then
                    cutscene:showNametag("Dess")
                    cutscene:text("* idk what your talking about this feels just fine", "kind", "dess")
                    cutscene:text("* I mean sure we just killed someone", "neutral", "dess")
                    cutscene:text("* But they deserved it", "condescending", "dess")
                    cutscene:text("* probably", "calm", "dess")
                    cutscene:text("* If God wanted him to live He would not have created me", "condescending", "dess")
                end

                if cutscene:getCharacter("brenda") then
                    cutscene:showNametag("Brenda")
                    cutscene:text("* Um...[wait:5] alright then.", "frown", "brenda")
                end

                cutscene:hideNametag()

                Assets.playSound("ominous")
            end
        else
            cutscene:wait(2)
            event:explode()
            cutscene:wait(5)

            if cutscene:getCharacter("susie") then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "nervous_side", "susie")
                cutscene:text("* That was weird.", "nervous", "susie")
                cutscene:hideNametag()
            end
        end
    end,

    grimkris = function(cutscene, event)
        cutscene:showNametag("Kris")
        cutscene:text("* Man, I don't know why people don't like Grimace Shake!", nil, "grimkris")
        cutscene:text("* It's so go-", nil, "grimkris", {auto = true})
        cutscene:hideNametag()
        Game.world.music:fade(0, 0.5)
        cutscene:playSound("screenshake")
        cutscene:shakeCharacter("grimkris", 3, 0)
        cutscene:setSprite("grimkris", "grimacing", 0)
        cutscene:wait(4)
        cutscene:playSound("screenshake")
        cutscene:shakeCharacter("grimkris", 3, 0)
        cutscene:setSprite("grimkris", "grimace", 0)
        cutscene:wait(4)
        cutscene:playSound("screenshake")
        cutscene:shakeCharacter("grimkris", 4, 0)
        cutscene:setSprite("grimkris", "grimaced", 0)
        cutscene:wait(4)

        event:explode()

        local susie = cutscene:getCharacter("susie")
        if susie then
            cutscene:wait(3)

            cutscene:setSpeaker(susie)
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "shock_down")
            cutscene:text("* Well,[wait:5] uh[speed:0.25]...", "shock_nervous")
            cutscene:text("* I'm glad that wasn't the ACTUAL Kris!", "shy")
            cutscene:hideNametag()
        end
    end,
	
	transition = function()
        if love.math.random(1, 100) <= 5 then
            Game.world:mapTransition("deltagaster/susie_hall", "entry")
        else
            Game.world:mapTransition("room4", "entry")
        end
    end,
}
