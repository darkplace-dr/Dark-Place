return function(cutscene, player_name_override)
    local required_version = SemVer(Mod.info.engineVer)
    local pre = required_version.prerelease
    local windows = love.system.getOS() == "Windows"
    local repo = "https://github.com/KristalTeam/Kristal"
    local dl_url = not pre
        and (repo .. "/releases/tag/" .. "v" .. tostring(required_version))
        or repo .. "/wiki/Playing-Kristal#source-code"

    local player_name = (player_name_override or Game.save_name):upper()

    Game.world.music:stop()
    cutscene:setTextboxTop(false)

    local dark = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    dark:setColor(0, 0, 0)
    dark:setParallax(0, 0)
    dark:setLayer(WORLD_LAYERS["below_ui"])
    Game.world:addChild(dark)

    local flowey = Sprite("", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, nil, nil, "objects/flowey")
    flowey:setScale(2)
    flowey:setOrigin(0.5, 1)
    flowey:setLayer(dark.layer + 1)
    dark:addChild(flowey)
    local function textF(text, emotion, altv)
        if emotion then flowey:setSprite(emotion) end
        cutscene:text("[voice:flowey"..(altv and "2" or "1").."]"..text)
    end

    cutscene:wait(20/30)
    flowey:setSprite("rise_plain")
    flowey:play(0.05, false, function()
        flowey:setSprite("plain")
        flowey:setOrigin(0.49, 1.03)
    end)
    cutscene:wait(4)

    cutscene:showNametag("Flowey")
    textF("* Uh...[wait:5] Howdy.")
    cutscene:hideNametag()

    cutscene:wait(3)

    cutscene:showNametag("Flowey")
    textF("* So, uh...", "side")
    textF("* I just thought I'd let you know...", "plain")
    textF("* You're using an outdated version of Kristal to play this mod.")
    textF("* You'll need version "..tostring(required_version).." in order to play it.")
    if pre then
        textF("* With said version,[wait:5] being an in-dev version of the engine.", "side")
    end
    textF("* But don't worry!", "nice")
    textF("* It's VERY easy to set up!", "nicesideum")
    textF("* All you need to do is go to Kristal's GitHub page...", "niceside")
    if pre then
        textF("* Then click the green button to download the engine!", "nice")
        if windows then
            textF("* And, of course,[wait:5] you'll also have to download LÖVE...", "niceside")
        end
    else
        textF("* Click the \"Releases\" link on the right,[wait:2] find the right version,[wait:5] and then download it!", "nice")
    end
    textF("* And unzip the file containing Kristal...\n[wait:5]* Blah, blah, blah...", "nicesideum")
    textF("* I'm SURE you can figure out the rest.", "sassy")
    textF("* Welp.[wait:5]\n* That's all that your old pal Flowey has to say!", "nice")
    textF("* In the meantime though...", "nicesideum")
    textF("* I'll just leave you with the dog.", "sassy")
    textF("* See ya around,[wait:5] "..player_name..".", "wink")
    cutscene:hideNametag()

    if player_name == "BLUE" or player_name == "PLAGUEIS" then
        flowey:setSprite("nice")
        cutscene:wait(2)

        cutscene:showNametag("Flowey")
        textF("* Wait a second...", "plain")
        textF("* Your name is...")
        textF("* "..player_name.."?", "nice")
        cutscene:hideNametag()

        cutscene:wait(3)
    end

    if player_name == "BLUE" then
        cutscene:showNametag("Flowey")
        textF("* Y'know,[wait:5] I've been wondering...", "nicesideum")
        textF("* Why exactly ARE you blue?", "plain")
        textF("* Is it because you're sad?[wait:5]\n* Or pure?", "side")
        textF("* ...or is it because you've been working in a meth lab of some kind?", "sassy")
        textF("* Not saying that I would know, of course!", "nicesideum")
        textF("* After all...", "niceside")
        textF("* I'm not some balding, middle-aged human who has his own drug business.", "nice")
        cutscene:hideNametag()
    elseif player_name == "PLAGUEIS" then
        cutscene:showNametag("Flowey")
        textF("* Y'know,[wait:5] I've actually heard a legend of someone who went by that name once...", "nicesideum")
        textF("* It was said that he had the power to save the ones he loved from death.", "plain")
        textF("* His life however,[wait:5] was cut short.", "side")
        textF("* When he taught his apprentice everything he knew...", "niceside")
        textF("* His apprentice KILLED him in his sleep!", "nice")
        textF("* Hee hee hee...[wait:5]\n* It's kind of ironic really.", "niceside")
        textF("* He had the power to save others...", "nicesideum")
        textF("[speed:0.6]* But he couldn't even use them to save his own SOUL.", "evil", true)
        cutscene:hideNametag()

        flowey:setSprite("laugh")
        flowey:play(0.05)
        Assets.playSound("floweylaugh")
        cutscene:wait(4)

        cutscene:showNametag("Flowey")
        textF("* Hahaha!!\n[wait:5]* What an absolute IDIOT!", "grin", true)
        cutscene:hideNametag()
    end

    -- HACK
    flowey:setAnimation({
        Utils.reverse(Assets.getFrames(flowey.path.."/rise")),
        0.05,
        false,
        callback = function() flowey:setSprite("") end
    })

    cutscene:wait(3)

    cutscene:after(function()
        love.system.openURL(dl_url)
        Game.world:loadMap("misc/dogcheck")
    end)
end