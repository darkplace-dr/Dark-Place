return function(cutscene, cell_phone_event_override)
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
    local function garbageNoise(path, time)
        pauseMusic()
        local wait = cutscene:playSound(path)
        if time then
            cutscene:wait(time)
        else
            cutscene:wait(wait)
        end
        resumeMusic()
    end
    local function pacematchingMsg(text, wait, portrait, actor)
        cutscene:text("[noskip][voice:nil]" .. text .. string.format("[wait:%g]", wait), portrait, actor, { auto = true })
    end

    Assets.playSound("phone", 0.7)
    cutscene:text("* (You tried to call on the Cell\nPhone.)", nil, nil, { advance = false })
    cutscene:wait(1+1/3)

    local event_num = cell_phone_event_override ~= nil and cell_phone_event_override or love.math.random(1, 100)

    if event_num <= 10 then
        garbageNoise("mcdonalds")
        cutscene:text("* Sounded like an angry customer.")
    elseif event_num >= 87 and event_num <= 93 then
        garbageNoise("fnafcall")
        cutscene:text("* It's nothing but useless information.")
    elseif event_num == 39 then
        cutscene:text("* Hello!\n* Could I speak to G...")
        cutscene:text("* ...[wait:5]\n* Wait a second.")
        cutscene:text("* Is this the wrong number?")
        pauseMusic()
        local wrongnumber = Music("wrongnumbersong", 0.8)
        wrongnumber:play()
        cutscene:text("* Oh it's the wrong number![wait:2]\n* The wrong number song!")
        cutscene:text("* We're very very sorry that\nwe got it wrong!")
        cutscene:text("* Oh it's the wrong number![wait:2]\n* The wrong number song!")
        cutscene:text("* We're very very sorry that\nwe got it wrong!")
        wrongnumber:remove()
        resumeMusic()
        cutscene:text("* (Click...)")
        cutscene:text("* Must've been a wrong number.")
    elseif event_num == 97 then
        pauseMusic()
        local spam = cutscene:playSound("spamcall")
        cutscene:showNametag("Spamton G. Spamton")
        pacematchingMsg("* FUCK YOU CYBER CITY!", 10)
        pacematchingMsg("* IF YOU'RE [[Exploitable]] ENOUGH TO BUY A CAR THIS WEEKEND...", 5)
        pacematchingMsg("* YOU'RE A DESPERATE ENOUGH JOE SHMOE TO COME TO BIG SHOT AUTOS!", 15)
        pacematchingMsg("* [[Ant-sized]] DEALS![wait:10]\n* CARS THAT [[Need auto insurance?]]!", 10)
        pacematchingMsg("* THIEVES!", 10)
        pacematchingMsg("* IF YOU THINK YOU'RE GOING TO FIND [[A free meal!]] AT BIG SHOT AUTOS...", 5)
        pacematchingMsg("* YOU CAN KISS MY [[Beautiful head]]!!", 15)
        pacematchingMsg("* IT'S MY BELIEF THAT YOU'RE SUCH A [[Specil]] MOTHERFUCKER...", 5)
        pacematchingMsg("* THAT YOU'LL FALL FOR THIS [[Half-priced salamy]]!", 10)
        pacematchingMsg("* GUARANTEED!", 20)
        pacematchingMsg("* IF YOU FIND A [[50% off]] DEAL,[wait:20] YOU CAN SHOVE [[1000 KROMER]] UP YOUR UGLY ASS!", 25)
        pacematchingMsg("* YOU HEARD ME RIGHT...", 5)
        pacematchingMsg("* SHOVE IT UP YOUR UGLY ASS!", 15)
        pacematchingMsg("* BRING YOUR [[100th customer!]]![wait:5]\n* BRING YOUR [[Wild prizes]]![wait:5]\n* BRING YOUR [[Hochi mama]]!", 5)
        pacematchingMsg("* I'LL FUCK HER!", 5)
        pacematchingMsg("* THAT'S RIGHT![wait:3] I'LL FUCK YOUR [[Hochi mama]]!", 10)
        pacematchingMsg("* BECAUSE AT BIG SHOT AUTOS,[wait:3] YOU'RE FUCKED SIX WAYS TO SUNDAY!", 15)
        pacematchingMsg("* TAKE A HIKE TO BIG SHOT AUTOS!", 15)
        pacematchingMsg("* HOME OF CHALLENGE [[Pipis.]]!", 10)
        pacematchingMsg("* THAT'S RIGHT,[wait:3] CHALLENGE [[Pipis.]]!", 15)
        pacematchingMsg("* HOW DOES IT WORK?", 10)
        pacematchingMsg("* IF YOU CAN [[Pipis.]] SIX FEET IN THE AIR STRAIGHT AND NOT GET WET...", 5)
        pacematchingMsg("* YOU GET [[No money back guarantee]]!", 10)
        pacematchingMsg("* DON'T WAIT,[wait:3] DON'T DELAY...", 5)
        pacematchingMsg("* DON'T FUCK WITH ME OR I'LL RIP YOUR [[Eggs]] OFF!", 10)
        pacematchingMsg("* ONLY AT BIG SHOT AUTOS!", 15)
        pacematchingMsg("* THE ONLY DEALER THAT TELLS YOU TO FUCK OFF!", 20)
        pacematchingMsg("* HURRY UP, ASSHOLE!", 10)
        pacematchingMsg("* THIS [[Specil deal]] ENDS THE MOMENT YOU WRITE US A CHECK...", 5)
        pacematchingMsg("* AND IT BETTER NOT BOUNCE OR YOU'RE A [[Permanently closed]] MOTHERFUCKER!", 10)
        pacematchingMsg("* TAKE A GODDAMN VACATION STRAIGHT TO HELL!", 40)
        pacematchingMsg("* ALSO KNOWN AS BIG SHOT AUTOS...", 5)
        pacematchingMsg("* CYBER CITY'S FILTHIEST...", 5)
        pacematchingMsg("* AND EXCLUSIVE HOME OF THE [[Biggest]] SON OF A BITCH IN THE DARK WORLD!", 40)
        pacematchingMsg("* GUARANTEED!", 30)
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
        garbageNoise("bbqbb", 200 / 30)
        cutscene:text("* It's nothing but an old meme.")
    -- if anyone wants to add an additional easter egg, feel free to use the template below!
    --[[
    elseif event_num == 100 then
        garbageNoise("path/to/audio")
        cutscene:text("What the fuck")
    ]]
    else -- fallthrough
        garbageNoise("smile", 200 / 30)
        cutscene:text("* It's nothing but garbage noise.")
    end
end
