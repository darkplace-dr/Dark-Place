return {

    connectiontransition = function(cutscene)
        if #Game.party == 2 and Game.party[1].id == "YOU" and Game.party[2].id == "susie" then
    	    Game.world:mapTransition("floor3/connection", "entryup")
        else
    	    Game.world:mapTransition("floor3/connection_fake", "entryup")
        end
    end,

    hole = function(cutscene)
        local YOU = cutscene:getCharacter("YOU")
        local Susie = cutscene:getCharacter("susie")

        Game.world.music:stop()

        cutscene:detachFollowers()
        
        if not YOU or not Susie then
            Game.lock_movement = true
            cutscene:wait(0.25)
            Game.world:loadMap("misc/dogcheck") --  Me when the:  
        end

        cutscene:walkTo(YOU, "yougo", 0.5, "down", true)
        cutscene:walkTo(Susie, "susiego", 0.5, "down", true)
        cutscene:wait(1.25)
        Assets.playSound("jump")
        YOU:setAnimation("jump_ball")
        Susie:setAnimation("jump_ball")
        cutscene:jumpTo(YOU, "yougo2", 10, 1)
        cutscene:wait(cutscene:jumpTo(Susie, "susiego2", 10, 1))
        YOU.y = YOU.y + 20
        Susie.y = Susie.y + 20
        YOU:setAnimation("slide")
        Susie:setAnimation("slide")
        YOU:slideToSpeed(YOU.x, YOU.y + 180, 1)
        Susie:slideToSpeed(Susie.x, Susie.y + 180, 1)
        cutscene:wait(1.25)
        cutscene:fadeOut(2.25)
        cutscene:wait(3.25)
        Assets.playSound("escaped")
        Game.world:loadMap("floor3/connection_2")
        Game.world.music:stop()
        Game.world.music.volume = 0
        cutscene:wait(5)
        YOU.x = 390
        YOU.y = 460
        Susie.x = 460
        Susie.y = 440
        YOU:setSprite("fell_serious")
        Susie:setSprite("fell")
        Game:setBorder("undertale/water")
        Game.world.music:play()
        Game.world.music:fade(1)
        cutscene:fadeIn(2)
        --cutscene:fadeOut()
        --YOU:resetSprite()
    end,

    fellsans = function(cutscene)
        local sans = cutscene:getCharacter("ausans")
        sans.visible = false
        cutscene:wait(2.5)
        cutscene:wait(cutscene:panToSpeed("campos", 1.5))
        cutscene:wait(1.25)
        sans.visible = true
        cutscene:wait(cutscene:setAnimation(sans, "grow"))
        cutscene:setSprite(sans, "idle")
        cutscene:wait(1.25)
        cutscene:text("[voice:flowey1]* Howdy!", {top = false})
        cutscene:wait(1)
        for _,chara in ipairs(Game.stage:getObjects(Character)) do
            if chara.actor.id == "ausans" then
                chara.no_shadow = true
                chara:removeFX("shadow")
            end
        end
        sans:resetSprite()
        Game.world.music:play("deltarune/muscle")

        pitch_timer = Game.world.timer:every(0.2, function()
            if Game.world.music and Game.world.music:isPlaying() then
                Game.world.music.pitch = Utils.random(0.9, 1.1)
            else
                return false
            end
        end)

        cutscene:text("[func:1]","neutral","ausans",
        {top = false, functions = {
            function()
                cutscene.textbox.text.wrap = false
                cutscene.textbox.text:setText("[voice:sans][font:sans]* i deltatalefellrunedustfell\ntaleredswapshifterror!sans\nhere.")
            end
        }}
        )
        cutscene:text("[font:sans]* hey, kid.", "holdup", "ausans", {top = false})
        cutscene:text("[font:sans]* welcome to the underground.", "neutral", "ausans", {top = false})
        cutscene:text("[font:sans]* how was the fall?", "wink", "ausans", {top = false})
        cutscene:text("[font:sans]* if you wanna look around,", "joking", "ausans", {top = false})
        cutscene:text("[font:sans]* give me a call.", "wink", "ausans", {top = false})
        cutscene:wait(0.04)
        cutscene:text("* (You got Sans' phone number.)", {top = false})
        cutscene:wait(0.04)
        cutscene:text("* さようなら。", "wink", "ausans", {top = false})
        Game.world.music:fade(0, 1)
        cutscene:wait(cutscene:setAnimation(sans, "transform"))
        cutscene:wait(1.5)
        cutscene:wait(cutscene:setAnimation(sans, "shrink"))
        cutscene:wait(0.1)
        sans:remove()
        Game:setFlag("CONNECTION.metsans", true)
        cutscene:wait(cutscene:panToSpeed(Game.world.player, 5))
        cutscene:attachCamera()
    end,

    ending = function(cutscene)
        cutscene:text("* (Ring... ring...)")
        cutscene:text("* hey,[wait:5] kris?")
        cutscene:text("* wait.[wait:5] i mean,[wait:5] YOU.[wait:10] YOU from ribbit,[wait:5]")
        cutscene:text("* i am...")
        cutscene:text("* deltatalefellrunedustfelltaleredswapshifterror!papyrus")
        cutscene:text("* i am calling to tell you , [wait:5] asgor e is gone")
        cutscene:text("* (he went on a vacation to the surface)")
        cutscene:text("* so, le barrier is disablesd")
        cutscene:text("* therefore, you cannot use the barrier to do the multiverse traveling thing you were gonna do,.")
        cutscene:wait(0.5)
        cutscene:text("* huh, what do you[wait:5] mean?")
        cutscene:text("* you weren't trying to travel through the multiverse using the barrier's magical power?")
        cutscene:text("* oh okay got it. well , if you and barney want to do that later when asgore's back, i'll call.")
        cutscene:text("* well, if it helps, here's an achievement")
        Kristal.callEvent("completeAchievement", "achievement")
        cutscene:wait(1.25)
        cutscene:text("* yure welcome")
        cutscene:text("* TLDR; i am papyru the undertale and this whole thing was pointless kinda.")
        cutscene:text("[font:wingdings][voice:wingding]* GO GO GADGET TELEPORTATION!")
        cutscene:wait(0.2)
        Game.world.music:stop()
        for key,_ in pairs(Assets.sound_instances) do
            Assets.stopSound(key, true)
        end
        cutscene:fadeOut(0)
        cutscene:playSound("impact")

        cutscene:wait(1)
        cutscene:loadMap("warphub", "spawn", "down")
        cutscene:fadeIn(0.25)
    end,
}
