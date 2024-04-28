---@param cutscene WorldCutscene
return function(cutscene, player_name_override)
    local player_name = (player_name_override or Game.save_name):upper()
    local required_version = SemVer(Mod.info.engineVer)
    local pre = required_version.prerelease
    local dl_url = not pre
        and ("https://github.com/KristalTeam/Kristal" .. "/releases/tag/" .. "v" .. tostring(required_version))
        or ("https://kristal.cc/wiki/downloading#nightly-releases")

    Game.world.music:stop()
    cutscene:setTextboxTop(false)

    local dark = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    dark:setColor(0, 0, 0)
    dark:setParallax(0, 0)
    dark:setLayer(WORLD_LAYERS["below_ui"])
    Game.world:addChild(dark)

    cutscene:wait(40/30)

    local flowey = Character("flowey_check", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    flowey:setScale(2)
    flowey:setOrigin(0.5, 1)
    flowey:setLayer(1)
    flowey:setAnimation("rise_plain")
    dark:addChild(flowey)
    cutscene:wait(4)

    cutscene:setSpeaker(flowey)
    local function showText(text, image)
        if image then
            flowey.sprite:set(image)
        end
        cutscene:text(text)
    end

    cutscene:showNametag("Flowey")
    showText("* Uh...[wait:5]\n* Howdy.")
    cutscene:hideNametag()

    cutscene:wait(3)

    cutscene:showNametag("Flowey")
    showText("* So, uh...", "side")
    showText("* I just thought I'd let you know...", "plain")
    showText("* You're trying to play this mod with an outdated version of Kristal.")
    showText("* The mod actually requires version "..tostring(required_version).." of the engine.")
    if pre then
        showText("* With said version,[wait:5] being an in-dev version of the engine.", "side")
    end
    showText("* But don't worry!", "nice")
    showText("* It's VERY easy to set up!", "nicesideum")
    if GitFinder and GitFinder.is_git_repo then
        showText("* Just open a terminal in the folder your engine's in...", "niceside")
        showText("* Then put in \"git pull\" and press enter!", "nice")
        showText("* Quick,[wait:5] isn't it?", "nicesideum")
        showText("* Technology is amazing.", "sassy")
    else
        if pre then
            showText("* All you need to do is go to Kristal's Wiki...", "niceside")
            showText("* Head for the Downloading Kristal page...", "niceside")
            showText("* And click the link under the \"nightly releases\" section to download it!", "nice")
            local get = "get"
            local game_src = love.filesystem.getSource()
            local game_src_is_arc, _ = Utils.endsWith(game_src, ".love")
            if not (love.filesystem.isFused() or game_src_is_arc) then
                get = "redownload"
            end
            showText("* Of course you can "..get.." the source code too,[wait:5] if you prefer that.", "niceside")
        else
            showText("* All you need to do is go to Kristal's GitHub page...", "niceside")
            showText("* Click the \"Releases\" link on the right,[wait:5] find the right version,[wait:5] and download it!", "nice")
        end
        showText("* Then unzip the file containing Kristal...\n[wait:5]* Blah, blah, blah...", "nicesideum")
        showText("* I'm SURE you can figure out the rest.", "sassy")
    end
    showText("* Welp.[wait:5]\n* That's all that your old pal Flowey has to say!", "nice")
    showText("* In the meantime though...", "nicesideum")
    showText("* I'll just leave you with the dog.", "sassy")
    showText("* See ya around,[wait:5] "..player_name..".", "wink")
    cutscene:hideNametag()

    flowey:setSprite("nice")

    if player_name == "YOU"
	or player_name == "BLUE"
	or player_name == "PLAGUEIS"
	or player_name == "DESS"
    or player_name == "BELLA"
    or player_name == "BRENDA"
    or player_name == "LUCY"
    or player_name == "BONER"
    or player_name == "CLOVER"
	then
        cutscene:wait(2)

        cutscene:showNametag("Flowey")
        showText("* Wait a second...", "plain")
        showText("* Your name is...")
        showText("* "..player_name.."?", "nice")
        cutscene:hideNametag()

        -- Dialogue for YOU is a WIP.
        if player_name == "YOU" then
            cutscene:wait(2)
            cutscene:showNametag("Flowey")
            showText("* Ah yes...[wait:5]\n* The orphaned amphibian.", "sassy")
            cutscene:hideNametag()
        elseif player_name == "BLUE" then
            cutscene:showNametag("Flowey")
            showText("* I've been wondering...", "nicesideum")
            showText("* Why exactly ARE you blue?", "plain")
            showText("* Is it because you're sad or depressed about something?", "side")
            showText("* Did someone turn your SOUL blue?", "plain")
            cutscene:hideNametag()
            cutscene:wait(1)
            cutscene:showNametag("Flowey")
            showText("* ...or is it because you've been working in a meth lab of some kind?", "sassy")
            showText("* Not saying that I would know, of course!", "nicesideum")
            showText("* After all...", "niceside")
            showText("* I'm not some balding, middle-aged human who owns a drug business.", "nice")
            cutscene:hideNametag()
        elseif player_name == "PLAGUEIS" then
            cutscene:showNametag("Flowey")
            showText("* I've actually heard a legend of someone who went by that name once...", "nicesideum")
            showText("* It was said that he had the power to save the ones he loved from death.", "plain")
            showText("* His life however,[wait:5] was cut short.", "side")
            showText("* When he taught his apprentice everything he knew...", "niceside")
            showText("* His apprentice KILLED him in his sleep!", "nice")
            showText("* Hee hee hee...[wait:5]\n* It's kind of ironic really.", "niceside")
            showText("* He had the power to save others...", "nicesideum")
            showText("[voice:flowey2][speed:0.6][shake:2]* But he couldn't even use them to save his own SOUL.", "evil")
            cutscene:hideNametag()

            flowey:setAnimation("laugh")
            Assets.playSound("floweylaugh")
            cutscene:wait(4)

            cutscene:showNametag("Flowey")
            showText("[voice:flowey2]* Golly! That's rich!", "grin")
            cutscene:hideNametag()
        -- People aren't even gonna see this one normally since Dess denies you from using her name, 
		-- but I thought it'd be funny to include anyways, lol. - J.A.R.U.
        elseif player_name == "DESS" then
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Flowey")
            showText("* Seriously?[wait:5]\n* Is this a joke?", "pissed")
            showText("* Out of ALL the names you could have chosen...", "pissed")
            showText("* You just HAD to choose [color:red]HER[color:reset]'s.", "pissed")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Flowey")
            showText("* I'm just gonna say it.", "side")
            showText("* I think I speak for everyone when I say that I HATE that doe-eyed dumbass.", "plain")
            showText("* Yeah,[wait:2] that's right.[wait:5]\n* Even [color:yellow]I[color:reset] hate her!", "nice")
            showText("* And to think,[wait:2] she's not even the REAL Dess!", "nicesideum")
            showText("* She's just some weird clone of a Dess from another timeline!", "nice")
            showText("* That makes me wonder though.", "nicesideum")
            showText("* What if she's not the ONLY Dess here?", "nice")
            showText("* There could be more of those freaks out there!", "niceside")
            showText("* Just some food for thought.", "nice")
            showText("* But besides all of that,[wait:5] let me give you a little bit of advice...", "niceeyesclosed")
            showText("[voice:flowey2][speed:0.6]* STAY. [wait:10]AWAY. [wait:10]FROM. [wait:10]HER.", "grin")
            showText("[voice:flowey2]* She's like a tumor...", "evil")
            showText("[voice:flowey2]* Once she clings on,[wait:5] she'll NEVER come off.", "evil")
            cutscene:hideNametag()
        elseif player_name == "BELLA" or player_name == "BRENDA" then
            cutscene:showNametag("Flowey")
            showText("* Y'know,[wait:5] I've always wondered what it's like to visit other worlds.", "side")
            showText("* To see what endless possibilites lie outside your reach.", "nice")
            showText("[voice:flowey2]* Hehehe...[wait:5] imagine all the FUN I could have...", "evil")
            showText("* But anyways,[wait:5] that name...", "plain")
            showText("* It reminds me of a certain story.", "side")
            showText("* One about someone who had the power to fuse universes.", "nice")
            showText("* Naturally,[wait:5] they used it to try and see what fun stories could be made.", "niceside")
            showText("* Y'know,[wait:5] it reminds me of,[wait:5] well,[wait:5] ME.", "nicesideum")
            showText("* Curious about all the possibilites their power had.", "nice")
            showText("* Well,[wait:5] you know how they said that curiosity killed the cat?", "sassy")
            showText("[voice:flowey2]* Their powers backfired horribly,[wait:5] causing all of reality to begin falling apart.", "evil")
            showText("[voice:flowey2]* How pathetic,[wait:5] not knowing that your actions have consequences!", "grin")
            showText("[voice:flowey2]* Hehehe... if only they had the power to RESET,[wait:5] like how I did.", "evil")
            showText("* What happened to them after that?", "side")
            showText("[voice:flowey2]* Well,[wait:5] let's just say that things didn't go too well for their world.", "evil")
            cutscene:hideNametag()

            flowey:setAnimation("laugh")
            Assets.playSound("floweylaugh")
            cutscene:wait(4)
        elseif player_name == "LUCY" then
            cutscene:showNametag("Flowey")
            showText("* Y'know,[wait:5] there's a person in this world with that name who once said something like...", "niceside")
            showText("* \"If I had a nickel for every person I know with my name,[wait:5] I'd have at least 25 cents.\"", "nicesideum")
            showText("* Weird thing to say,[wait:5] I know.", "sassy")
            showText("* But hey,[wait:5] maybe you'll get to meet her.[wait:5] Once you've updated Kristal, that is.", "plain")
            showText("* Then she'd have 30 cents.[wait:10] Kinda useless, but hey.", "nicesideum")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Flowey")
            showText("* Although,[wait:5] she is kind of shy in person, I've heard.", "side")
            showText("* So good luck finding her.", "wink")
            cutscene:hideNametag()
        elseif player_name == "BONER" then
            cutscene:wait(1)
            flowey:setSprite("pissed")
            cutscene:wait(1)
            cutscene:showNametag("Flowey")
            showText("* Is this a joke?[wait:10] Are you braindead?", "pissed")
            showText("* Why the hell is your name \"BONER\"?", "pissed")
            showText("* Wait a minute...", "plain")
            showText("[voice:flowey2]* You think you're reaaaaally funny,[wait:5] don't you?", "evil")
            showText("* You want me to say...[wait:10] THAT.", "sassy")
            showText("* Seriously,[wait:5] that was just a one time thing.", "pissed")
            showText("[voice:flowey2]* And now EVERYONE calls me the \"Big boner down the lane\" guy!", "evil")
            showText("* I get people walking up to me on the streets and asking me:", "pissed")
            showText("[voice:default]* \"Hey aren't you the guy who said 'Big boner down the lane'?\"", "frisk")
            showText("* And then they ask me to say it like it's my catchphrase or something.", "pissed")
            showText("* ...", "side")
            showText("* Alright,[wait:5] fine,[wait:5] if it'll get you to leave me alone then I'll say it.", "pissed")
            showText("* Okay...", "plain")
            showText("* Big boner down the lane.", "concerned")
            showText("* THERE,[wait:5] I SAID IT![wait:10] ARE YOU HAPPY NOW?!", "enraged")
            showText("* Now leave me alone,[wait:5] asshole.", "pissed")
            cutscene:hideNametag()
        elseif player_name == "CLOVER" then
            cutscene:wait(1)
            flowey:setSprite("side")
            cutscene:wait(1)
            cutscene:showNametag("Flowey")
            showText("* Wait, wasn't it actually Gun-Hat?", "plain")
            cutscene:hideNametag()
            flowey:setSprite("side")
            cutscene:wait(2)
            cutscene:showNametag("Flowey")
            showText("* Nah, I'm just kidding.", "wink")
            showText("* But anyway,[wait:5] since we've found each other again...", "niceside")
            showText("* There's something I've been wanting to show you!", "nice")
            showText("* Are you ready?", "happyside")
            cutscene:hideNametag()
            flowey:setSprite("nice")
            local white = flowey:addFX(ShaderFX(Kristal.Shaders["White"]))
            white.vars["whiteAmount"] = 0
            Game.world.timer:tween(0.5, white.vars, {whiteAmount = 1}, "linear")
            Assets.playSound("boost")
            cutscene:wait(1)
            flowey:explode(0, 0, true)
            cutscene:wait(0.5)
            flowey:removeFX(white)
            flowey:setSprite("cut")
            cutscene:wait(3)
            cutscene:showNametag("Flowey")
            showText("* Hey Clover[wait:1s]\n* Check out my new cut")
            cutscene:hideNametag()
        end
    end

    flowey:setAnimation("rise_reverse")
    cutscene:wait(3)

    cutscene:after(function()
        Game.world:loadMap("misc/dogcheck")
        Game.stage.timer:after(1/3.5, function()
            love.system.openURL(dl_url)
        end)
    end)
end
