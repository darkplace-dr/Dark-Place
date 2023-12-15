---@param cutscene WorldCutscene
return function(cutscene, event_override)
    local had_music = Game.world.music:isPlaying()
    local function pauseMusic()
        if had_music then
            Game.world.music:pause()
        end
    end
    local function resumeMusic()
        if had_music then
            Game.world.music:resume()
        end
    end

    local music_inst = Music()
    cutscene:after(function()
        music_inst:remove()
    end)
    local function playCellPhoneAudio(path, volume, pitch)
        local epic_hax = "voiceover/cell_phone/"
        if string.sub(path, 1, string.len(epic_hax)) == epic_hax then
            -- requiring a sound in assets/music
            music_inst:play(path, volume, pitch, false)
            return function() return not music_inst:isPlaying() end
        else
            return cutscene--[[@as WorldCutscene]]:playSound(path, volume, pitch)
        end
    end
    local function garbageNoise(path, time)
        pauseMusic()

        local wait = playCellPhoneAudio(path, 0.8)
        cutscene:wait(time or wait)

        resumeMusic()
    end

    local function pacematchingMsg(text, wait, portrait, actor)
        cutscene:text("[noskip][voice:nil]" .. text .. string.format("[wait:%g]", wait), portrait, actor, { auto = true })
    end
    local pmMsg = pacematchingMsg
    --[[local function textForTime(text, time, portrait, actor)
        cutscene:text("[noskip][voice:nil]" .. text, portrait, actor, { advance = false })
        cutscene:wait(time)
    end]]

    Assets.playSound("phone", 0.7)
    cutscene:text("* (You tried to call on the Cell\nPhone.)", nil, nil, { advance = false })
    cutscene:wait(1.5)

    local event_num = event_override ~= nil and event_override or love.math.random(1, 100)

    if event_num <= 10 then
        garbageNoise("voiceover/cell_phone/mcdonalds")

        cutscene:text("* Sounded like an angry customer.")
    elseif event_num == 17 then
        -- "17 is first yeah"
        pauseMusic()
        local _ = playCellPhoneAudio("voiceover/cell_phone/hello_world")

        local leader = Mod:getLeader("chara")
        local old_layer = leader.layer
        leader:setLayer(WORLD_LAYERS["below_ui"])

        local fade = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        fade.layer = leader.layer-0.1
        fade:setColor(0, 0, 0)
        fade.alpha = 0
        Game.world:addChild(fade)
        fade:setScreenPos(0, 0)
        fade:setGraphics({
            fade_to = 1,
            fade = 0.02
        })

        Game.light = true
        pmMsg("* (Hello.)", 40)
        pmMsg("* (Thank you for stopping by.)", 40)
        pmMsg("* (Sorry,[wait:9] but Neuro-sama is not available at the moment.)", 55)
        pmMsg("* (Unless it is an urgent matter,[wait:9] please refrain from messaging me.)", 50)
        pmMsg("* (Have a wonderful day.)", 40)
        Game.light = false

        leader:setFacing("down")

        cutscene:wait(5)

        local cc = Text("thank you")
        cc:setColor(0.2, 0.2, 0.2, 0)
        cc.layer = WORLD_LAYERS["top"]
        Game.world:addChild(cc)
        cc:setScreenPos(110, 360)
        cc:fadeTo(0.1, 5)

        cutscene:wait(_)
        cc:remove()

        fade:fadeTo(0, nil, function()
            fade:remove()
            leader:setLayer(old_layer)
        end)

        cutscene:text("* (Click.)")
        resumeMusic()
    elseif event_num == 39 then
        cutscene:text("* Hello!\n* Could I speak to G...")
        cutscene:text("* ...[wait:5]\n* Wait a second.")
        cutscene:text("* Is this the wrong number?")

        pauseMusic()
        music_inst:play("wrongnumbersong", 0.8)

        cutscene:text("* Oh it's the wrong number![wait:2]\n* The wrong number song!")
        cutscene:text("* We're very very sorry that\nwe got it wrong!")
        cutscene:text("* Oh it's the wrong number![wait:2]\n* The wrong number song!")
        cutscene:text("* We're very very sorry that\nwe got it wrong!")

        music_inst:stop()
        resumeMusic()

        cutscene:text("* (Click...)")
        cutscene:text("* Must've been a wrong number.")
    elseif event_num >= 87 and event_num <= 93 then
        garbageNoise("voiceover/cell_phone/fnafcall")

        cutscene:text("* It's nothing but useless information.")
    elseif event_num == 97 then
        pauseMusic()
        local spam = playCellPhoneAudio("voiceover/cell_phone/spamcall", 0.8)

        cutscene:showNametag("Spamton G. Spamton")
        pmMsg("* FUCK YOU CYBER CITY!", 10)
        pmMsg("* IF YOU'RE [[Exploitable]] ENOUGH TO BUY A CAR THIS WEEKEND...", 5)
        pmMsg("* YOU'RE A DESPERATE ENOUGH JOE SHMOE TO COME TO BIG SHOT AUTOS!", 15)
        pmMsg("* [[Ant-sized]] DEALS![wait:10]\n* CARS THAT [[Need auto insurance?]]!", 10)
        pmMsg("* THIEVES!", 10)
        pmMsg("* IF YOU THINK YOU'RE GOING TO FIND [[A free meal!]] AT BIG SHOT AUTOS...", 5)
        pmMsg("* YOU CAN KISS MY [[Beautiful head]]!!", 15)
        pmMsg("* IT'S MY BELIEF THAT YOU'RE SUCH A [[Specil]] MOTHERFUCKER...", 5)
        pmMsg("* THAT YOU'LL FALL FOR THIS [[Half-priced salamy]]!", 10)
        pmMsg("* GUARANTEED!", 20)
        pmMsg("* IF YOU FIND A [[50% off]] DEAL,[wait:20] YOU CAN SHOVE [[1000 KROMER]] UP YOUR UGLY ASS!", 25)
        pmMsg("* YOU HEARD ME RIGHT...", 5)
        pmMsg("* SHOVE IT UP YOUR UGLY ASS!", 15)
        pmMsg("* BRING YOUR [[100th customer!]]![wait:5]\n* BRING YOUR [[Wild prizes]]![wait:5]\n* BRING YOUR [[Hochi mama]]!", 5)
        pmMsg("* I'LL FUCK HER!", 5)
        pmMsg("* THAT'S RIGHT![wait:3] I'LL FUCK YOUR [[Hochi mama]]!", 10)
        pmMsg("* BECAUSE AT BIG SHOT AUTOS,[wait:3] YOU'RE FUCKED SIX WAYS TO SUNDAY!", 15)
        pmMsg("* TAKE A HIKE TO BIG SHOT AUTOS!", 15)
        pmMsg("* HOME OF CHALLENGE [[Pipis.]]!", 10)
        pmMsg("* THAT'S RIGHT,[wait:3] CHALLENGE [[Pipis.]]!", 15)
        pmMsg("* HOW DOES IT WORK?", 10)
        pmMsg("* IF YOU CAN [[Pipis.]] SIX FEET IN THE AIR STRAIGHT AND NOT GET WET...", 5)
        pmMsg("* YOU GET [[No money back guarantee]]!", 10)
        pmMsg("* DON'T WAIT,[wait:3] DON'T DELAY...", 5)
        pmMsg("* DON'T FUCK WITH ME OR I'LL RIP YOUR [[Eggs]] OFF!", 10)
        pmMsg("* ONLY AT BIG SHOT AUTOS!", 15)
        pmMsg("* THE ONLY DEALER THAT TELLS YOU TO FUCK OFF!", 20)
        pmMsg("* HURRY UP, ASSHOLE!", 10)
        pmMsg("* THIS [[Specil deal]] ENDS THE MOMENT YOU WRITE US A CHECK...", 5)
        pmMsg("* AND IT BETTER NOT BOUNCE OR YOU'RE A [[Permanently closed]] MOTHERFUCKER!", 10)
        pmMsg("* TAKE A GODDAMN VACATION STRAIGHT TO HELL!", 40)
        pmMsg("* ALSO KNOWN AS BIG SHOT AUTOS...", 5)
        pmMsg("* CYBER CITY'S FILTHIEST...", 5)
        pmMsg("* AND EXCLUSIVE HOME OF THE [[Biggest]] SON OF A BITCH IN THE DARK WORLD!", 40)
        pmMsg("* GUARANTEED!", 30)
        cutscene:hideNametag()

        cutscene:wait(spam)
        resumeMusic()

        cutscene:text("* ...")
        cutscene:text("* What.")

        if cutscene:getCharacter("susie") then
            cutscene:showNametag("Susie")
            cutscene:text("* The hell was THAT?", "nervous", "susie")
            cutscene:hideNametag()
        end
    elseif event_num >= 11 and event_num <= 25 then
        --[[
        Char's easteregg
        based on what I changed the cellphone to in an unreleased mod
        I made to test out how Kristal works that was called
        Kris and Susie Gamer Time.
        ]]
        garbageNoise("voiceover/cell_phone/bbqbb", 200 / 30)

        cutscene:text("* It's nothing but an old meme.")
    elseif event_num == 86 then
        pauseMusic()
        local carglass = playCellPhoneAudio("voiceover/cell_phone/carglass", 0.8)

        cutscene:wait(0.06)
        pmMsg("[speed:0.7]* ~Carglass répare,[wait:3] Carglass remplace!~", 15)
        cutscene:showNametag("Olivier de Carglass")
        pmMsg("* Bonjour.[wait:2] Je suis Olivier de Carglass.", 5)
        pmMsg("* Vous pensez que cet impact est trop petit,[wait:2] et que ça ne vaut pas le coup de s'en occuper?", 4)
        pmMsg("* Quand il fait chaud comme aujourd'hui...[wait:3]\n* On met la clim!", 6)
        cutscene:hideNametag()
        pmMsg("* BEEP[wait:5] BEEP[wait:5] BEEP", 5)
        cutscene:wait(1.5)
        cutscene:showNametag("Olivier de Carglass")
        pmMsg("* Et voilà.", 15)
        pmMsg("* [speed:0.8]L'impact n'a pas supporté le changement brutal de température.", 10)
        pmMsg("* Bien sûr,[wait:2] si demain ça vous arrive,[wait:2] chez Carglass,[wait:2] on remplacera votre parre-brise.", 10)
        pmMsg("* Mais vous risquez de payer une franchise.", 5)
        pmMsg("* Alors que si vous appelez Carglass dés que vous avez un impact", 20)
        pmMsg("* On vient chez vous[wait:3] et on répare votre parre-brise sans le remplacer.", 20)
        pmMsg("* On injecte notre récine spéciale en 30 minutes", 20)
        pmMsg("* Le résultat est presque invisible", 20)
        pmMsg("* Et le parre-brise retrouve sa solidité.\n[wait:15]* BUMP", 10)
        pmMsg("* En plus,[wait:5] avec votre assurance Bri-Glass,[wait:2] le plus souvent chez Carglass", 10)
        pmMsg("* La réparation,[wait:2] ça ne vous coûte rien.", 20)
        pmMsg("* OUI VRAIMENT![wait:4]\nCa ne vous coûte rien!", 15)
        pmMsg("* Alors n'attendez plus![wait:3] Appelez nous maintenant au 0[wait:2]800[wait:4] 7[wait:2]7[wait:6] 24[wait:2] 24", 20)
        pmMsg("* Ou réservez sur carglass.fr", 10)
        cutscene:hideNametag()
        pmMsg("[speed:0.7]* ~Carglass répare,[wait:3] Carglass remplace!~", 15)

        cutscene:wait(carglass)
        resumeMusic()

        cutscene:text("* It's nothing but a French ad.")
    elseif event_num == 52 then
        --[[
            Agent 7's easteregg
            The Legendary Soup Store.
        ]]
        pauseMusic()
        local soup = playCellPhoneAudio("voiceover/cell_phone/soup", 0.8)

        cutscene:showNametag("???", {right = false})
        pmMsg("[wait:3]* Hello?", 5)
        cutscene:showNametag("???", {right = true})
        pmMsg("* Hey,[wait:1] what's up?", 5)
        cutscene:showNametag("???", {right = false})
        pmMsg("[speed:1.3]* I need your help,[wait:1] can you come here?", 5)
        cutscene:showNametag("???", {right = true})
        pmMsg("* Uhh I can't I'm buying clothes.", 5)
        cutscene:showNametag("???", {right = false})
        pmMsg("* Alright,[wait:1] well hurry up and come over here.", 5)
        cutscene:showNametag("???", {right = true})
        pmMsg("* I can't find them.", 10)
        cutscene:showNametag("???", {right = false})
        pmMsg("[speed:1.5]* What do you mean you \"can't find them\"?", 7)
        cutscene:showNametag("???", {right = true})
        pmMsg("[speed:1.2]* I can't find them, there's only [color:#FFFF00]soup[color:reset].",20)
        cutscene:showNametag("???", {right = false})
        pmMsg("* What do you mean there's \"only [color:#FFFF00]soup[color:reset]\"?", 20)
        cutscene:showNametag("???", {right = true})
        pmMsg("* It means[wait:2] there's only[wait:1] [color:#FFFF00]soup[color:reset]!", 10)
        cutscene:showNametag("???", {right = false})
        pmMsg("* Well then get outta the [color:#FFFF00]soup aisle[color:reset]!!", 20)
        cutscene:showNametag("???", {right = true})
        pmMsg("* Alright,[wait:1] you don't have to shout at me!", 5)
        cutscene:hideNametag()
        cutscene:wait(2.5)
        cutscene:showNametag("???", {right = true})
        pmMsg("* There's more [color:#FFFF00]soup[color:reset]!", 3)
        cutscene:showNametag("???", {right = false})
        pmMsg("* What do you mean there's \"more [color:#FFFF00]soup[color:reset]\"!?", 5)
        cutscene:showNametag("???", {right = true})
        pmMsg("* There's just more [color:#FFFF00]soup[color:reset]!", 7)
        cutscene:showNametag("???", {right = false})
        pmMsg("* Go into the next aisle!", 20)
        cutscene:showNametag("???", {right = true})
        pmMsg("* There's still [color:#FFFF00]soup[color:reset]!", 5)
        cutscene:showNametag("???", {right = false})
        pmMsg("* Where [speed:0.7]ARE you[speed:1] right now!?", 12)
        cutscene:showNametag("???", {right = true})
        pmMsg("* I'M [speed:0.7]AT [color:#FFFF00]SOUP[color:reset]!", 7)
        cutscene:showNametag("???", {right = false})
        pmMsg("[speed:0.7]* WHAT DO YOU MEAN YOU'RE \"AT[wait:1] [color:#FFFF00]SOUP[color:reset]\"!?", 3)
        cutscene:showNametag("???", {right = true})
        pmMsg("* I MEAN I'M AT[wait:1] [color:#FFFF00]SOUP[color:reset]!", 15)
        cutscene:showNametag("???", {right = false})
        pmMsg("[speed:0.7]* WHAT [color:red]STORE[color:reset][wait:1] ARE YOU IN!?", 7)
        cutscene:showNametag("???", {right = true})
        pmMsg("[speed:0.7]* I'M AT THE [color:#FFFF00]SOUP STORE[color:reset]!!", 5)
        cutscene:showNametag("???", {right = false})
        pmMsg("[speed:0.7][shake:1]* [color:red]WHY ARE YOU BUYING CLOTHES AT THE [color:#FFFF00]SOUP STORE[color:red]!?", 5)
        cutscene:showNametag("???", {right = true})
        pmMsg("* [color:red]FUCK[wait:2] YOU!!", 20)
        cutscene:hideNametag()

        cutscene:wait(soup)
        cutscene:wait(1)
        resumeMusic()

        cutscene:text("* It's just an argument about soup.")
    elseif event_num >= 70 and event_num <= 75 then
        pauseMusic()
        local waystuffis = playCellPhoneAudio("voiceover/cell_phone/stuffisway")

        cutscene:wait(0.25)
        cutscene:setTextboxTop(false)
        pmMsg("[speed:0.9]* Did you just\n* What", 45)
        pmMsg("[speed:0.9]* Is what you\n* Yes", 45)
        pmMsg("[speed:0.9]* Did you whatever[wait:25]\n* Whatever you[wait:15]\n* I guess", 45)
        pmMsg("[speed:0.9]* The stocking horse[wait:45]\n* Was hides the guy", 45)
        pmMsg("[speed:0.9]* And which the pony[wait:15]\nis a phony[wait:15]\nwas a lie", 55)
        pmMsg("[speed:0.9]* You[wait:5] say[wait:35] stuff[wait:5] is[wait:10] way,\n[wait:35]way[wait:10] to[wait:10] go\n[wait:35]go[wait:10] a[wait:10]way", 55)
        pmMsg("[speed:0.9]* Who had\n* You was", 55)
        pmMsg("[speed:0.9]* I\n* yes you would", 45)
        pmMsg("[speed:0.9]* It was catastro[wait:25]\n* Catastro[wait:10]\n* Feeling good", 55)
        pmMsg("[speed:0.9]* As it the drag[wait:45]\n* That has you are", 45)
        pmMsg("[speed:0.9]* Is in the bag[wait:15][speed:0.6] that you drag behind your[wait:10] car.", 65)

        cutscene:setTextboxTop(true)
        Game.light = true
        pmMsg("[speed:0.9]* Did you just\n* What", 45)
        pmMsg("[speed:0.9]* Is what you\n* Yes", 45)
        pmMsg("[speed:0.9]* Did you whatever[wait:25]\n* Whatever you[wait:15]\n* I guess", 45)
        pmMsg("[speed:0.9]* The stocking horse[wait:45]\n* Was hides the guy", 45)
        pmMsg("[speed:0.9]* And which the pony[wait:15]\nis a phony[wait:15]\nwas a lie", 55)
        Game.light = false

        music_inst:stop()
        resumeMusic()
        cutscene:setTextboxTop(nil)

        cutscene:text("* (You're not sure what they were trying to say.)")
        cutscene:text("* (I have an idea to have the two voices, but I'm lazy rn.[wait:10]\n- Simbel)")
    -- if anyone wants to add an additional easter egg, feel free to use the template below!
    --[[
    elseif event_num == 100 then
        garbageNoise("voiceover/cell_phone/path/to/audio")
        cutscene:text("What the fuck")
    ]]
    else
        garbageNoise("smile", 200 / 30)

        cutscene:text("* It's nothing but garbage noise.")
    end
end
