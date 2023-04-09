return function(cutscene, player_name_override)
    local player_name = (player_name_override or Game.save_name):upper()

    Game.world.music:stop()

    local dark = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    dark:setColor(0, 0, 0)
    dark:setParallax(0, 0)
    dark:setLayer(WORLD_LAYERS["below_ui"])
    Game.world:addChild(dark)

    cutscene:wait(20/30)

    local flowey = Sprite("rise", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, nil, nil, "objects/flowey")
    flowey:setScale(2)
    flowey:setOrigin(0.5, 1)
    flowey:setLayer(dark.layer + 1)
    dark:addChild(flowey)

    flowey:play(0.05, false)
    cutscene:wait(2)
    flowey:setSprite("plain")
    flowey:setOrigin(0.49, 1.03)
    cutscene:wait(2)

    local function textF(text, emotion, altv)
        if emotion then flowey:setSprite(emotion) end
        cutscene:text("[voice:flowey"..(altv and "2" or "1").."]"..text)
    end

    cutscene:showNametag("Flowey")
    textF("* Uh...[wait:5] Howdy.")
    cutscene:hideNametag()

    cutscene:wait(3)
    cutscene:showNametag("Flowey")
    textF("* So, uh...", "side")
    textF("* I just thought I'd let you know...", "plain")
    textF("* You're using an outdated version of this engine to play this mod.")
    textF("* You'll need version 0.8.0 in order to play it.")
    textF("* With said version,[wait:5] being the source code for the engine.", "side")
    textF("* But don't worry!", "nice")
    textF("* It's VERY easy to set up!", "nicesideum")
    textF("* All you need to do is go to the Kristal Github page...", "niceside")
    textF("* Click the green button,[wait:5] and then download it!", "nice")
    textF("* And, of course,[wait:5] you'll also have to download LOVE2D...", "niceside")
    textF("* And unzip the file containing Kristal...\n[wait:5]* Blah, blah, blah...", "nicesideum")
    textF("* I'm SURE you can figure out the rest.", "sassy")
    textF("* Welp.[wait:5]\n* That's all that your old pal Flowey has to say!", "nice")
    textF("* In the meantime though...", "nicesideum")
    textF("* I'll just leave you with the dog.", "sassy")
    textF("* See ya around,[wait:5] "..player_name..".", "wink")
    flowey:setSprite("nice")
    cutscene:hideNametag()

    cutscene:wait(2)

    if player_name == "BLUE" or player_name == "PLAGUEIS" then
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
    flowey:setSprite("nice")

    cutscene:wait(1)
    cutscene:wait(cutscene:fadeOut(2))
    cutscene:wait(0.5)
    cutscene:after(function()
        love.system.openURL("https://github.com/KristalTeam/Kristal/wiki/Playing-Kristal#source-code")
        Game.world:loadMap("misc/dogcheck")
    end)
end