return {
    b = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")

        -- You killed them, didn't you?
        cutscene:wait(2)

        Game.world.music:fade(0, 0.5)

        cutscene:showNametag("Brenda")
        cutscene:text("[speed:0.2]* ...", "frown_side", "brenda")
        cutscene:text("* What...[wait:5] the hell was that?", "frown_side", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Hm?", "neutral_side", "susie")
        end

        cutscene:hideNametag()
        -- You claim you're a good person and yet...
        cutscene:wait(2)

        cutscene:showNametag("Brenda")
        cutscene:text("* I...[wait:5] I think?", "neutral_side", "brenda")
        cutscene:text("* What the hell are you talking about?", "frown", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* You okay dude?", "neutral", "susie")
        end

        cutscene:hideNametag()
        -- Good people don't kill other people.
        -- What about their families?
        -- What will they think about you slaughtering their own kin?
        cutscene:wait(4)

        cutscene:showNametag("Brenda")
        cutscene:text("* I...[wait:10]\n* I just...", "sad", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Uh...", "sad", "susie")
        end

        cutscene:hideNametag()
        -- You just what? Getting stronger?
        cutscene:wait(2)

        cutscene:showNametag("Brenda")
        cutscene:text("* N-no it's not that!", "sad_b", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Okay you're starting to scare me.", "shock_nervous", "susie")
        end

        cutscene:hideNametag()
        -- Don't lie to yourself, you could have stopped at any time.
        -- But you just complied with Them
        cutscene:wait(3)

        cutscene:showNametag("Brenda")
        cutscene:text("* W-who are you talking about?", "sad", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Brenda...?", "sad", "susie")
        end

        cutscene:hideNametag()
        -- The Player. You are complicite with Their actions.
        -- Be honest, you just want to see your stats increase.
        cutscene:wait(3)

        cutscene:showNametag("Brenda")
        cutscene:text("* N-no...", "sad_b", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Y-you good dude?", "sad_frown", "susie")
        end

        cutscene:hideNametag()
        -- You are nothing more than a monster
        -- You think you are above consequences just because you helped create this place?
        cutscene:wait(3)

        cutscene:showNametag("Brenda")
        cutscene:text("* Shut up...", "mad", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "shock", "susie")
        end

        cutscene:hideNametag()
        -- You think that you can toy with this world?
        cutscene:wait(2)

        cutscene:showNametag("Brenda")
        cutscene:text("* Shut up.", "livid_b", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Hey uh,[wait:5] calm down.", "shock_nervous", "susie")
        end

        cutscene:hideNametag()
        -- What would your friends think if they knew how horrible you really are?
        cutscene:wait(2)

        cutscene:showNametag("Brenda")
        cutscene:text("* SHUT UP!", "livid", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Dude,[wait:5] just take some deep breaths.", "sad_frown", "susie")
        end

        cutscene:hideNametag()
        -- You're nothing but filth
        cutscene:wait(2)

        cutscene:showNametag("Brenda")
        cutscene:text("* SHUT UP SHUT UP SHUT UP!!", "crying_b", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Please,[wait:5] we're here for you man.", "sad_frown", "susie")
        end

        cutscene:hideNametag()
        -- I think we are done here.
        -- I hope you're happy with what you're doing.
        cutscene:wait(3)

        cutscene:showNametag("Brenda")
        cutscene:text("* ...", "sad", "brenda")
        cutscene:text("* Sorry,[wait:5] I...", "frown_side", "brenda")
        cutscene:text("* Look,[wait:5] just forget that ever happened,[wait:5] okay?", "frown", "brenda")

        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Uh,[wait:5] okay?", "sus_nervous", "susie")
        end

        cutscene:showNametag("Brenda")
        cutscene:text("* I'm fine.", "happy", "brenda")
        cutscene:text("* ...", "frown_side", "brenda")

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
        cutscene:text("* Hey,[wait:5] isn't that Brenda?", "surprise", "susie")
        cutscene:hideNametag()
        local brenda = cutscene:getCharacter("brenda_dreamscape")
        brenda:walkTo(x, -60, 2, "up")
        cutscene:wait(1.5)
        cutscene:showNametag("Susie")
        cutscene:text("* Hey![wait:10] Brenda,[wait:5] wait up!", "surprise_frown", "susie")
        cutscene:hideNametag()
        cutscene:wait(cutscene:attachCamera())
        Game:setFlag("b_entrance", true)
    end,

    voidremark = function(cutscene, event)
        cutscene:showNametag("Susie")
        cutscene:text("* Man,[wait:5] just what the heck ARE those black orb things?", "nervous", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* idk but maybe they're related to shade enemies?", "eyebrow", "dess")
        cutscene:showNametag("Jamm")
        if Game:getFlag("dungeonkiller") then
            cutscene:text("* Not shades.", "shaded_neutral", "jamm")
        else
            cutscene:text("* I highly doubt that.", "look_left", "jamm")
            cutscene:text("* They're completely black,[wait:5] instead of being shades of blue.", "neutral", "jamm")
        end
        cutscene:showNametag("Susie")
        cutscene:text("* Well,[wait:5] whatever they are,[wait:5] they give me the creeps.", "nervous", "susie")
        if not Game:getFlag("dungeonkiller") then
            cutscene:showNametag("Jamm")
            cutscene:text("* You can say that again.", "nervous", "jamm")
        end
        cutscene:showNametag("Susie")
        cutscene:text("* I don't think I've ever seen an enemy that refuses mercy.", "nervous_side", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* does that mean we can beat the shit out of them?", "challenging", "dess")
        cutscene:showNametag("Susie")
        cutscene:text("* Heh,[wait:5] now we're talking!", "smile", "susie")
        if not Game:getFlag("dungeonkiller") then
            cutscene:showNametag("Jamm")
            cutscene:text("* Or,[wait:5] we can try and tire them out and pacify them.", "smirk", "jamm")
            cutscene:showNametag("Susie")
            cutscene:text("* I guess that works too.", "small_smile", "susie")
            cutscene:text("* Let's get going,[wait:5] guys.", "smile", "susie")
        end
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
        if not Game:getFlag("dungeonkiller") then
            cutscene:showNametag("Jamm")
            cutscene:text("* Yeah,[wait:5] if this keeps up...", "nervous", "jamm")
            cutscene:text("* ... I feel like we're gonna have to spam healing items.", "nervous_left", "jamm")
        end
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
        if not Game:getFlag("dungeonkiller") then
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
        else
            jamm:setFacing("down")
            cutscene:showNametag("Jamm")
            cutscene:text("* It's enough, though.", "shaded_neutral", "jamm")
            susie:setFacing("right")
            cutscene:showNametag("Susie")
            cutscene:text("* Are you sure...?", "sus_nervous", "susie")
            cutscene:showNametag("Jamm")
            cutscene:text("* It's. Enough.", "shaded_neutral", "jamm")
            cutscene:showNametag("Susie")
            cutscene:text("* Oh, okay...!", "surprise_smile", "susie")
            cutscene:text("* (When did Jamm get so...)", "sus_nervous", "susie")
            cutscene:hideNametag()
        end
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end,

    leftend = function(cutscene, event)
        cutscene:text("* Congratulations on making it this far.")
        cutscene:text("* You have conquered the Path of Strength.")
        if not Game:getFlag("thoughts_leftend") then
            if Game:getFlag("dungeonkiller") and Game:getFlag("library_kills") - 8 == Game:getFlag("thoughts_kills") then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "sus_nervous", "susie")
                cutscene:text("* Something about this feels...[wait:10] so wrong.", "annoyed_down", "susie")
                cutscene:text("* Like,[wait:5] I know those orbs don't seem too sentient,[wait:5] but...", "sus_nervous", "susie")
                cutscene:text("* I still feel bad for killing them...", "shy_down", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* hey don't sweat it they tried to kill us first", "heckyeah", "dess")
                cutscene:text("[noskip]* I know we've been sort of on a killing spree as of late but", "neutral_b", "dess", {auto = true})
                cutscene:showNametag("Jamm")
                cutscene:text("* Shut up.", "shaded_pissed", "jamm")
                cutscene:showNametag("Dess")
                cutscene:text("* ...", "wtf_b", "dess")
                cutscene:showNametag("Susie")
                cutscene:text("* Hey,[wait:5] Jamm,[wait:5] chill out.", "annoyed", "susie")
                cutscene:text("* Uh,[wait:5] as much as I hate to admit this...", "nervous", "susie")
                cutscene:text("* ... Dess DOES bring up a good point about them attacking us first.", "annoyed_down", "susie")
                if not Game:getFlag("thoughts_rightend") then
                    cutscene:text("* Let's just go back and do the other path.", "annoyed", "susie")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* ...", "shaded_neutral", "jamm")
                else
                    cutscene:text("* Look,[wait:5] Jamm,[wait:5] your attitude is REALLY starting to piss me off.", "annoyed_down", "susie")
                    cutscene:text("* I want you to cut the crap by the time we meet up with Brenda,[wait:5] okay?", "annoyed", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("* Oooo,[wait:5] you're in troubleeee", "condescending", "dess")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Dess,[wait:5] you're not off the hook either.", "annoyed", "susie")
                    cutscene:text("* The both of you guys need to stop acting like...", "annoyed_down", "susie")
                    cutscene:text("* ... this place personally insulted you or something.", "annoyed_down", "susie")
                    cutscene:text("* I do NOT want to have to be the team mom here.", "nervous_side", "susie")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* ...", "shaded_pissed", "jamm")
                    cutscene:showNametag("Dess")
                    cutscene:text("* ...", "neutral_c", "dess")
                    Assets.stopAndPlaySound("ominous")
                end
                cutscene:hideNametag()
            else
                cutscene:showNametag("Susie")
                cutscene:text("* FINALLY!", "teeth_b", "susie")
                cutscene:text("* Ugh,[wait:5] those things were RELENTLESS I tell you!", "teeth", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* those fucking orbs that i hate", "angry", "dess")
                if not Game:getFlag("dungeonkiller") and Game:getFlag("library_kills") - 8 ~= Game:getFlag("thoughts_kills") then
                    cutscene:showNametag("Jamm")
                    cutscene:text("* And now we have to walk all the way back and fight even more of them.", "stern", "jamm")
                    cutscene:showNametag("Dess")
                    cutscene:text("* i am at my fucking limit right now", "genuine", "dess")
                end
                if Game:getFlag("library_kills") - 8 == Game:getFlag("thoughts_kills") then
                    cutscene:text("* it's a good thing we killed them all", "condescending", "dess")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Uh...[wait:10] yeah,[wait:5] sure...", "nervous_side", "susie")
                    cutscene:text("* ...", "shy_down", "susie")
                end
                if not Game:getFlag("thoughts_rightend") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* Anyways,[wait:5] let's go do the other path now.", "small_smile", "susie")
                    if not Game:getFlag("dungeonkiller") then
                        cutscene:showNametag("Jamm")
                        cutscene:text("* Sounds good to me.", "happy", "jamm")
                    end
                else
                    cutscene:showNametag("Susie")
                    cutscene:text("* Hopefully that forcefield should be open now.", "neutral_side", "susie")
                    cutscene:text("* I just really hope Brenda's okay...", "shy_down", "susie")
                end
                cutscene:hideNametag()
            end
            Game:setFlag("thoughts_leftend", true)
        end
    end,

    quizhistory = function(cutscene, event)
        if not Game:getFlag("thoughts_quizhistory") then
            local susie = cutscene:getCharacter("susie")
            local dess = cutscene:getCharacter("dess")
            local jamm = cutscene:getCharacter("jamm")
            local x,y = event.x + event.width/2, event.y + event.height/2
            cutscene:detachCamera()
            cutscene:detachFollowers()
            cutscene:panTo(x,y)
            susie:walkTo(x, y + 50, 1, "up")
            dess:walkTo(x - 30, y + 80, 1, "up")
            jamm:walkTo(x + 30, y + 80, 1, "up")
            cutscene:wait(1)

            cutscene:text("* Greetings,[wait:5] welcome to the Path of Wits.")
            cutscene:text("* In order to reach the end,[wait:5] you must pass 4 quizes.")
            cutscene:text("* I hope you've been paying attention in History Class.")
            cutscene:text("* There are 5 questions,[wait:5] and you must answer at least 3 correctly.")
            if not Game:getFlag("dungeonkiller") then
                local correct = 0

                cutscene:showNametag("Dess")
                cutscene:text("* hey if quizes are quizical,[wait:5] then what are tests?", "condescending", "dess")
                cutscene:showNametag("Susie")
                cutscene:text("* Shush![wait:10]\n* I'm trying to concentrate!", "teeth", "susie")
                cutscene:hideNametag()
                cutscene:text("[noskip]* Question 1:[wait:10] What year was the Declaration of Independance for the USA signed?")
                cutscene:showNametag("Dess")
                cutscene:text("[noskip]* ooo ooo ooo i know this one it's", "challenging", "dess", {auto = true})
                cutscene:showNametag("Susie")
                cutscene:text("* I SAID SHUSH!!!", "teeth_b", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Huh,[wait:5] I guess it's starting out easy.", "look_left", "jamm")
                cutscene:hideNametag()
                
			    local wbi_ok = false
			    local action
			    local wbi = WarpBinInputMenu(4)
                wbi.as_warp_bin_ui = false
                wbi.cancellable = false
			    wbi.finish_cb = function(_action, input)
				    wbi_ok = true
				    action = input
			    end
			    Game.world:spawnObject(wbi, "ui")
			    cutscene:wait(function() return wbi_ok end)

                if string.upper(action) == "1776" then
                    cutscene:text("* That is correct![wait:10]\n* Congrats!")
                    correct = correct + 1
                else
                    cutscene:text("* Unfortunately,[wait:5] that is wrong.")
                end
                cutscene:text("[noskip]* Question 2:[wait:10] What year was the Articles of Confederation signed?")
                cutscene:text("[noskip]* This is the event that Canada Day celebrates,[wait:5] in case you were wondering.")
                
                cutscene:showNametag("Dess")
                cutscene:text("* ewwwww i hate canada", "neutral", "dess")
                cutscene:showNametag("Jamm")
                cutscene:text("* I mean,[wait:5] they make good maple syrup.", "look_left", "jamm")
                cutscene:hideNametag()

                wbi_ok = false
			    wbi = WarpBinInputMenu(4)
                wbi.as_warp_bin_ui = false
                wbi.cancellable = false
			    wbi.finish_cb = function(_action, input)
				    wbi_ok = true
				    action = input
			    end
			    Game.world:spawnObject(wbi, "ui")
			    cutscene:wait(function() return wbi_ok end)

                if string.upper(action) == "1867" then
                    cutscene:text("* That is correct![wait:10]\n* Congrats!")
                    correct = correct + 1
                else
                    cutscene:text("* Unfortunately,[wait:5] that is wrong.")
                end
                cutscene:text("[noskip]* Question 3:[wait:10] Durring WWI,[wait:5] the three major members of the Entente were Britain,[wait:5] Russia...[wait:5]")
                cutscene:text("[noskip]* ... and what other country?")
                
                cutscene:showNametag("Susie")
                cutscene:text("* WWI?[wait:10]\n* The hell does that mean?", "nervous", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* It means \"World War One\".[react:1]", "neutral", "jamm", {reactions = { 
				    {"How do you not know this???", 302, 50, "nervous", "jamm"}
			    }})
                cutscene:showNametag("Susie")
                cutscene:text("* Ohhhh.", "surprise_smile", "susie")
                cutscene:text("* I still have no idea what that means.", "nervous", "susie")
                cutscene:hideNametag()

                wbi_ok = false
			    wbi = WarpBinInputMenu(10)
                wbi.as_warp_bin_ui = false
                wbi.cancellable = false
			    wbi.finish_cb = function(_action, input)
				    wbi_ok = true
				    action = input
			    end
			    Game.world:spawnObject(wbi, "ui")
			    cutscene:wait(function() return wbi_ok end)

                if string.upper(action) == "FRANCE" then
                    cutscene:text("* That is correct![wait:10]\n* Congrats!")
                    cutscene:showNametag("Dess")
                    cutscene:text("* ewwwww i hate france too", "neutral", "dess")
                    cutscene:hideNametag()
                    correct = correct + 1
                else
                    cutscene:text("* Unfortunately,[wait:5] that is wrong.")
                end
                cutscene:text("[noskip]* Question 4:[wait:10] What nation of the German Confederation was the one to form Germany?")
                cutscene:showNametag("Jamm")
                cutscene:text("* Okay this I have no clue on.", "stern", "jamm")
                cutscene:text("* It's like this quiz was tailor made for a history nerd.", "determined", "jamm")
                cutscene:hideNametag()

                wbi_ok = false
			    wbi = WarpBinInputMenu(10)
                wbi.as_warp_bin_ui = false
                wbi.cancellable = false
			    wbi.finish_cb = function(_action, input)
				    wbi_ok = true
				    action = input
			    end
			    Game.world:spawnObject(wbi, "ui")
			    cutscene:wait(function() return wbi_ok end)

                if string.upper(action) == "PRUSSIA" then
                    cutscene:text("* That is correct![wait:10]\n* Congrats!")
                    correct = correct + 1
                else
                    cutscene:text("* Unfortunately,[wait:5] that is wrong.")
                end

                cutscene:text("[noskip]* Final Question:[wait:10] Which South American country is the only one to have had an emperor?")
                cutscene:showNametag("Jamm")
                cutscene:text("* Who the hell came up with these questions?!", "determined", "jamm")
                cutscene:showNametag("Dess")
                cutscene:text("* idk but i have no idea what half of what it just said was", "heckyeah", "dess")
                cutscene:hideNametag()

                wbi_ok = false
			    wbi = WarpBinInputMenu(10)
                wbi.as_warp_bin_ui = false
                wbi.cancellable = false
			    wbi.finish_cb = function(_action, input)
				    wbi_ok = true
				    action = input
			    end
			    Game.world:spawnObject(wbi, "ui")
			    cutscene:wait(function() return wbi_ok end)

                if string.upper(action) == "BRAZIL" or string.upper(action) == "BRASIL" then
                    cutscene:text("* That is correct![wait:10]\n* Congrats!")
                    correct = correct + 1
                else
                    cutscene:text("* Unfortunately,[wait:5] that is wrong.")
                end

                cutscene:text("* Let's see your final score...")
                cutscene:text("* You scored "..correct.." out of 5.")
                if correct >= 3 then
                    cutscene:text("* Congrats![wait:10]\n* You won!")
                    cutscene:text("* You may now move on to the next quiz.")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Hell yeah!", "smile", "susie")
                    cutscene:hideNametag()
                    Assets.stopAndPlaySound("screenshake")
                    Game:setFlag("thoughts_quizhistory", true)
                else
                    cutscene:text("* Unfortunately,[wait:5] that is not enough to pass.")
                    cutscene:text("* Please try again.")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Ugh,[wait:5] damnit!", "angry", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("* hey you can always look the answers up", "condescending", "dess")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* I mean,[wait:5] that would ruin the challenge.", "stern", "jamm")
                    cutscene:text("* But if you're stuggling,[wait:5] I guess you could do that.", "smirk", "jamm")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Uhhh,[wait:5] I don't have a phone.", "annoyed", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("* the voice in your head can look it up", "heckyeah", "dess")
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...", "shock", "susie")
                    cutscene:text("* What?", "sad_frown", "susie")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* Ignore her.", "stern", "jamm")
                    cutscene:hideNametag()
                end
            else
                cutscene:showNametag("Dess")
                cutscene:text("* oh my GOD", "angry", "dess")
                cutscene:text("* we are not doing this shit again", "neutral", "dess")
                cutscene:hideNametag()
                dess:walkTo(x, y + 50, 0.5, "up")
                susie:setSprite("shock_down")
                susie:walkTo(x - 40, y + 50, 0.5, "right")
                cutscene:wait(1)
                cutscene:wait(cutscene:walkTo(dess, x, y + 70, 0.5, "up", true))
                cutscene:wait(cutscene:walkTo(dess, x, y + 50, 0.2))
                dess:shake(5)
                Assets.playSound("screenshake")
                cutscene:wait(1)
                susie:setSprite("shock_right")
                cutscene:text("* WARNING![wait:10] VIOLENCE TOWARDS QUIZ DETECTED!")
                cutscene:text("* DEPLOYING SECURITY PROTOCALLS!")
                cutscene:startEncounter("3voidwanderer", true)
                cutscene:wait(1)
                susie:resetSprite()
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "suspicious", "susie")
                susie:setSprite("exasperated_right")
                cutscene:text("* WHAT THE HELL WAS THAT FOR?!", "teeth_b", "susie")
                susie:resetSprite()
                cutscene:hideNametag()
                dess:setFacing("right")
                Assets.stopAndPlaySound("screenshake")
                Game:setFlag("thoughts_quizhistory", true)
                cutscene:wait(1)
                dess:setFacing("left")
                cutscene:showNametag("Dess")
                cutscene:text("* oh hey that actually worked", "wtf", "dess")
                cutscene:text("* all according to keikaku[react:1]", "condescending", "dess", {reactions = { 
				    {"*keikaku means plan", 302, 50, "condescending", "dess"}
			    }})
                cutscene:showNametag("Susie")
                cutscene:text("* I-", "shock_nervous", "susie")
                cutscene:text("* I guess if it works,[wait:5] it works?", "surprise_smile", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Typical.[wait:10]\n* Using force to get your way again,[wait:5] are we, Dess?", "shaded_pissed", "jamm")
                dess:setFacing("down")
                cutscene:showNametag("Dess")
                cutscene:text("* hey like susie said if it works it works", "neutral", "dess")
                dess:setFacing("left")
                cutscene:showNametag("Susie")
                cutscene:text("* Hey,[wait:5] let's get going,[wait:5] we still have three left.", "neutral_side", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* ...", "shaded_neutral", "jamm")
                cutscene:hideNametag()
            end
            cutscene:attachCamera()
            cutscene:wait(cutscene:attachFollowers())
        end
    end,

    quizgeography = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local jamm = cutscene:getCharacter("jamm")
        local x,y = event.x + event.width/2, event.y + event.height/2
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo(x,y)
        susie:walkTo(x, y + 50, 1, "up")
        dess:walkTo(x - 30, y + 80, 1, "up")
        jamm:walkTo(x + 30, y + 80, 1, "up")
        cutscene:wait(1)

        cutscene:text("* On the topic of countries,[wait:5] here are some geography questions.")
        cutscene:text("* There are 5 questions,[wait:5] and you must answer at least 3 correctly.")
        if not Game:getFlag("dungeonkiller") then
            local correct = 0
            cutscene:text("[noskip]* Question 1:[wait:10] The United States shares a border with Canada and what other country?")

            cutscene:showNametag("Dess")
            cutscene:text("* ewwwww i hate canada", "neutral", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* CAN YOU NOT SAY THAT EVERY TIME CANADA IS BROUGHT UP?!", "teeth_b", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* ...[wait:10] alright", "neutral_c", "dess")
            cutscene:hideNametag()

            local wbi_ok = false
			local action
			local wbi = WarpBinInputMenu(10)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "MEXICO" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Question 2:[wait:10] Sicily is a Mediterranean island owned by which country?")

            cutscene:showNametag("Jamm")
            cutscene:text("* I think that's in Europe?", "look_left", "jamm")
            cutscene:hideNametag()

            wbi_ok = false
            wbi = WarpBinInputMenu(10)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
            wbi.finish_cb = function(_action, input)
                wbi_ok = true
                action = input
            end
            Game.world:spawnObject(wbi, "ui")
            cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "ITALY" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Question 3:[wait:10] France shares its largest land border with what country?")

            cutscene:showNametag("Jamm")
            cutscene:text("* I think I've heard of this one before.", "look_left", "jamm")
            cutscene:text("* And I'm pretty sure the answer isn't what you think it is.", "stern", "jamm")
            cutscene:showNametag("Susie")
            cutscene:text("* Good to know.", "sus_nervous", "susie")
            cutscene:hideNametag()

            wbi_ok = false
            wbi = WarpBinInputMenu(10)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
            wbi.finish_cb = function(_action, input)
                wbi_ok = true
                action = input
            end
            Game.world:spawnObject(wbi, "ui")
            cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "BRAZIL" or string.upper(action) == "BRASIL" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Question 4:[wait:10] What is the smallest country in the world by land area?")
            
            cutscene:showNametag("Dess")
            cutscene:text("* not america", "condescending", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* ...[wait:10] I think that's obvious.", "suspicious", "susie")
            cutscene:hideNametag()

            wbi_ok = false
            wbi = WarpBinInputMenu(10)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
            wbi.finish_cb = function(_action, input)
                wbi_ok = true
                action = input
            end
            Game.world:spawnObject(wbi, "ui")
            cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "VATICAN" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Final Question:[wait:10] How many UN recognized countries are there in Europe?")

            cutscene:showNametag("Dess")
            cutscene:text("* ", "wtf_b", "dess")
            cutscene:showNametag("Jamm")
            cutscene:text("* Uh,[wait:5] good luck.", "nervous_left", "jamm")
            cutscene:hideNametag()

            wbi_ok = false
			wbi = WarpBinInputMenu(3)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "44" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end

            cutscene:text("* Let's see your final score...")
            cutscene:text("* You scored "..correct.." out of 5.")
            if correct >= 3 then
                cutscene:text("* Congrats![wait:10]\n* You won!")
                cutscene:text("* You may now move on to the next quiz.")
                cutscene:showNametag("Susie")
                cutscene:text("* Hell yeah!", "smile", "susie")
                cutscene:hideNametag()
                Assets.stopAndPlaySound("screenshake")
                Game:setFlag("thoughts_quizgeography", true)
            else
                cutscene:text("* Unfortunately,[wait:5] that is not enough to pass.")
                cutscene:text("* Please try again.")
                cutscene:showNametag("Susie")
                cutscene:text("* Ugh,[wait:5] damnit!", "angry", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* hey you can always look the answers up", "condescending", "dess")
                cutscene:showNametag("Jamm")
                cutscene:text("* I mean,[wait:5] that would ruin the challenge.", "stern", "jamm")
                cutscene:text("* But if you're stuggling,[wait:5] I guess you could do that.", "smirk", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* Uhhh,[wait:5] I don't have a phone.", "annoyed", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* the voice in your head can look it up", "heckyeah", "dess")
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "shock", "susie")
                cutscene:text("* What?", "sad_frown", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Ignore her.", "stern", "jamm")
                cutscene:hideNametag()
            end
        else
            cutscene:showNametag("Dess")
            cutscene:text("* step aside,[wait:5] i'll handle this", "condescending", "dess")
            cutscene:hideNametag()
            dess:walkTo(x, y + 50, 0.5, "up")
            susie:walkTo(x - 40, y + 50, 0.5, "right", "right")
            cutscene:wait(1)
            cutscene:wait(cutscene:walkTo(dess, x, y + 70, 0.5, "up", true))
            cutscene:wait(cutscene:walkTo(dess, x, y + 50, 0.2))
            dess:shake(5)
            Assets.playSound("screenshake")
            cutscene:wait(1)
            cutscene:text("* WARNING![wait:10] VIOLENCE TOWARDS QUIZ DETECTED!")
            cutscene:text("* DEPLOYING SECURITY PROTOCALLS!")
            cutscene:startEncounter("3voidwanderer", true)
            cutscene:wait(1)
            Assets.stopAndPlaySound("screenshake")
            Game:setFlag("thoughts_quizgeography", true)
            cutscene:wait(1)
            cutscene:showNametag("Dess")
            cutscene:text("* 2 left to go guys", "heckyeah", "dess")
            cutscene:showNametag("Jamm")
            cutscene:text("* ...", "shaded_neutral", "jamm")
            cutscene:showNametag("Susie")
            cutscene:text("* (... Is Jamm doing okay...?)", "neutral_side", "susie")
            cutscene:hideNametag()
        end
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end,

    quizflags = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local jamm = cutscene:getCharacter("jamm")
        local x,y = event.x + event.width/2, event.y + event.height/2
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo(x,y)
        susie:walkTo(x, y + 50, 1, "up")
        dess:walkTo(x - 30, y + 80, 1, "up")
        jamm:walkTo(x + 30, y + 80, 1, "up")
        cutscene:wait(1)

        cutscene:text("* Last country-related quiz,[wait:5] this time it's all about flags.")
        cutscene:text("* There are 5 questions,[wait:5] and you must answer at least 3 correctly.")
        if not Game:getFlag("dungeonkiller") then
            local correct = 0
            cutscene:text("[noskip]* Question 1:[wait:10] The flag of the United States has how many stars on it?")
            
            cutscene:showNametag("Dess")
            cutscene:text("* oh this is so easy", "heckyeah", "dess")
            cutscene:hideNametag()

            local wbi_ok = false
			local action
			local wbi = WarpBinInputMenu(3)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "50" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Question 2:[wait:10] The flag of Germany contains black,[wait:5] red,[wait:5] and what other color?")
            
            cutscene:showNametag("Dess")
            cutscene:text("* nevermind it's no longer easy", "neutral", "dess")
            cutscene:showNametag("Jamm")
            cutscene:text("* That's because the only country you care about is the US.", "stern", "jamm")
            cutscene:showNametag("Dess")
            cutscene:text("* uh yeah because it's awesome", "heckyeah", "dess")
            cutscene:hideNametag()

            wbi_ok = false
			wbi = WarpBinInputMenu(10)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "YELLOW" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Question 3:[wait:10] Poland,[wait:5] Monaco,[wait:5] Indonesia,[wait:5] and Singapore all have similar flags.")
            cutscene:text("[noskip]* Which one of these have the red half on the bottom?")
            
            cutscene:showNametag("Dess")
            cutscene:text("* i have literally never heard of any of these countries", "neutral", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* Neither have I.", "nervous", "susie")
            cutscene:showNametag("Jamm")
            cutscene:text("* I remember taking a class on this kind of stuff.", "side_smile", "jamm")
            cutscene:text("* We had to memorize these flags and all,[wait:5] though...", "neutral", "jamm")
            cutscene:text("* I can't put my finger on which flag it is...", "nervous", "jamm")
            cutscene:showNametag("Dess")
            cutscene:text("* skill issue lol", "neutral", "dess", {reactions = { 
				    {"You don't know either.", 302, 50, "stern", "jamm"}
			    }})
            cutscene:hideNametag()

            local opinion = cutscene:choicer({"Poland", "Monaco", "Indonesia", "Singapore"})
            if opinion == 1 then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Question 4:[wait:10] What is the only country flag to not have a shade of red,[wait:5] white,[wait:5] or blue?")
            
            cutscene:showNametag("Susie")
            cutscene:text("* Well it can't be Germany.", "neutral_side", "susie")
            cutscene:text("* Because it already meantioned its flag having red in it.", "neutral", "susie")
            cutscene:showNametag("Jamm")
            cutscene:text("* That still leaves over 100 options though.", "stern", "jamm")
            cutscene:showNametag("Dess")
            cutscene:text("* man i hate this", "neutral_b", "dess")
            cutscene:hideNametag()
            
            wbi_ok = false
			wbi = WarpBinInputMenu(10)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "JAMAICA" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end
            cutscene:text("[noskip]* Final Question:[wait:10] What is the only country to have a square flag?")
            
            cutscene:showNametag("Jamm")
            cutscene:text("* I think this one is easier than the last one.", "stern", "jamm")
            cutscene:text("* Because that's a more noticable trait for a flag to have.", "look_left", "jamm")
            cutscene:hideNametag()

            wbi_ok = false
			wbi = WarpBinInputMenu(11)
			wbi.as_warp_bin_ui = false
			wbi.cancellable = false
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)

            if string.upper(action) == "SWITZERLAND" then
                cutscene:text("* That is correct![wait:10]\n* Congrats!")
                correct = correct + 1
            else
                cutscene:text("* Unfortunately,[wait:5] that is wrong.")
            end

            cutscene:text("* Let's see your final score...")
            cutscene:text("* You scored "..correct.." out of 5.")
            if correct >= 3 then
                cutscene:text("* Congrats![wait:10]\n* You won!")
                cutscene:text("* You may now move on to the next quiz.")
                cutscene:showNametag("Susie")
                cutscene:text("* Hell yeah!", "smile", "susie")
                cutscene:hideNametag()
                Assets.stopAndPlaySound("screenshake")
                Game:setFlag("thoughts_quizflags", true)
            else
                cutscene:text("* Unfortunately,[wait:5] that is not enough to pass.")
                cutscene:text("* Please try again.")
                cutscene:showNametag("Susie")
                cutscene:text("* Ugh,[wait:5] damnit!", "angry", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* hey you can always look the answers up", "condescending", "dess")
                cutscene:showNametag("Jamm")
                cutscene:text("* I mean,[wait:5] that would ruin the challenge.", "stern", "jamm")
                cutscene:text("* But if you're stuggling,[wait:5] I guess you could do that.", "smirk", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* Uhhh,[wait:5] I don't have a phone.", "annoyed", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* the voice in your head can look it up", "heckyeah", "dess")
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "shock", "susie")
                cutscene:text("* What?", "sad_frown", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Ignore her.", "stern", "jamm")
                cutscene:hideNametag()
            end
        else
            cutscene:showNametag("Dess")
            cutscene:text("* flags?[wait:10] that's nerd shit lmao", "condescending", "dess")
            cutscene:hideNametag()
            dess:walkTo(x, y + 50, 0.5, "up")
            susie:walkTo(x - 40, y + 50, 0.5, "right", "right")
            cutscene:wait(1)
            cutscene:wait(cutscene:walkTo(dess, x, y + 70, 0.5, "up", true))
            cutscene:wait(cutscene:walkTo(dess, x, y + 50, 0.2))
            dess:shake(5)
            Assets.playSound("screenshake")
            cutscene:wait(1)
            cutscene:text("* WARNING![wait:10] VIOLENCE TOWARDS QUIZ DETECTED!")
            cutscene:text("* DEPLOYING SECURITY PROTOCALLS!")
            cutscene:startEncounter("3voidwanderer", true)
            cutscene:wait(1)
            Assets.stopAndPlaySound("screenshake")
            Game:setFlag("thoughts_quizflags", true)
            cutscene:wait(1)
            cutscene:showNametag("Dess")
            cutscene:text("* one left to go guys", "heckyeah", "dess")
            cutscene:text("* this is actually pretty fun ngl", "condescending", "dess")
            cutscene:showNametag("Jamm")
            cutscene:text("* Of course you think it is...", "shaded_pissed", "jamm")
            cutscene:showNametag("Susie")
            cutscene:text("* ...", "sus_nervous", "susie")
            cutscene:hideNametag()
        end
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end,

    quizgaming = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local jamm = cutscene:getCharacter("jamm")
        local x,y = event.x + event.width/2, event.y + event.height/2
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo(x,y)
        susie:walkTo(x, y + 50, 1, "up")
        dess:walkTo(x - 30, y + 80, 1, "up")
        jamm:walkTo(x + 30, y + 80, 1, "up")
        cutscene:wait(1)

        cutscene:text("* Final quiz,[wait:5] this is all about gaming.")
        cutscene:text("* There are 10 questions,[wait:5] and you must answer at least 7 correctly.")
        if not Game:getFlag("dungeonkiller") then
            cutscene:showNametag("Dess")
            cutscene:text("* hold on guys,[wait:5] i think i can handle this", "challenging", "dess")
            cutscene:hideNametag()
            dess:walkTo(x, y + 50, 0.5, "up")
            susie:walkTo(x - 40, y + 50, 0.5, "right", "right")
            cutscene:wait(1)
            cutscene:showNametag("Susie")
            cutscene:text("* Are you sure about this?", "nervous_side", "susie")
            cutscene:showNametag("Jamm")
            cutscene:text("[noskip]* Oh come on,[wait:5] you are SO gonna screw this up-", "determined", "jamm", {auto = true})
            cutscene:showNametag("Dess")
            cutscene:text("* shut", "angry", "dess")
            cutscene:text("* lemme focus", "calm", "dess")
            cutscene:text("* ...", "neutral", "dess")
            cutscene:text("* well that's obvious.", "condescending", "dess")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Dess")
            cutscene:text("* ez", "heckyeah", "dess")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Susie")
            cutscene:text("* Is she...", "sad", "susie")
            cutscene:showNametag("Jamm")
            cutscene:text("* Solving it?[wait:10]\n* Looks like it.", "nervous_left", "jamm")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Dess")
            cutscene:text("* hm...", "neutral_b", "dess")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Susie")
            cutscene:text("* Looks like she's stuck...", "neutral_side", "susie")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Dess")
            cutscene:text("* oh wait i know this one", "genuine_b", "dess")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Jamm")
            cutscene:text("* Guess not...?", "look_left", "jamm")
            cutscene:hideNametag()
            cutscene:wait(2)
            cutscene:showNametag("Dess")
            cutscene:text("* hmmm this one's a toughie...", "neutral", "dess")
            cutscene:text("* oh wait no nvm i got it", "heckyeah", "dess")
            cutscene:hideNametag()
            cutscene:wait(4)
            cutscene:showNametag("Dess")
            cutscene:text("* aaaand that's the last one", "heckyeah", "dess")
            cutscene:text("* man these things are really easy", "condescending", "dess")
            cutscene:hideNametag()
            cutscene:text("* Let's see your final score...")
            cutscene:text("* You scored 10 out of 10.")
            cutscene:text("* Congrats![wait:10]\n* You won!")
            cutscene:text("* You have completed all the quizes!")
            cutscene:showNametag("Susie")
            cutscene:text("* ", "shock", "susie")
            cutscene:showNametag("Jamm")
            cutscene:text("* ", "nervous", "jamm")
            Assets.stopAndPlaySound("screenshake")
            Game:setFlag("thoughts_quizgaming", true)
            dess:setFacing("down")
            cutscene:showNametag("Dess")
            cutscene:text("* ez pz lemon squeezie", "condescending", "dess")
            cutscene:text("* ...", "heckyeah", "dess")
            cutscene:text("* hey why are you guys looking at me like that", "neutral", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* Uh...[wait:10] Let's just continue.", "shock_nervous", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* sounds good to me.", "challenging", "dess")
            cutscene:hideNametag()
        else
            cutscene:showNametag("Dess")
            cutscene:text("* we are gonna save so much time by skipping this", "heckyeah", "dess")
            cutscene:hideNametag()
            dess:walkTo(x, y + 50, 0.5, "up")
            susie:walkTo(x - 40, y + 50, 0.5, "right", "right")
            cutscene:wait(1)
            cutscene:wait(cutscene:walkTo(dess, x, y + 70, 0.5, "up", true))
            cutscene:wait(cutscene:walkTo(dess, x, y + 50, 0.2))
            dess:shake(5)
            Assets.playSound("screenshake")
            cutscene:wait(1)
            cutscene:text("* WARNING![wait:10] VIOLENCE TOWARDS QUIZ DETECTED!")
            cutscene:text("* DEPLOYING SECURITY PROTOCALLS!")
            cutscene:startEncounter("3voidwanderer", true)
            cutscene:wait(1)
            Assets.stopAndPlaySound("screenshake")
            Game:setFlag("thoughts_quizgaming", true)
            cutscene:wait(1)
            cutscene:showNametag("Dess")
            cutscene:text("* well that's all of them", "condescending", "dess")
            cutscene:text("* guys i think we got the world record", "heckyeah", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* Uh...[wait:10] yeah,[wait:5] sure.", "nervous_side", "susie")
            cutscene:hideNametag()
        end
        cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
    end,

    rightend = function(cutscene, event)
        cutscene:text("* Congratulations on making it this far.")
        cutscene:text("* You have conquered the Path of Wits.")
        if not Game:getFlag("thoughts_rightend") then
            if Game:getFlag("dungeonkiller") then
                cutscene:showNametag("Susie")
                cutscene:text("* Y'know, Dess,[wait:5] as much time as that might have saved...", "annoyed", "susie")
                cutscene:text("* I really don't feel good about this.", "annoyed_down", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* aw c'mon,[wait:5] we're getting stronger,[wait:5] aren't we?", "condescending", "dess")
                cutscene:text("* look those orb thingies probably have the mental capacity of a jellyfish", "calm", "dess")
                cutscene:text("[noskip]* i don't think we're doing anything wrong by-", "neutral", "dess", {auto = true})
                cutscene:showNametag("Jamm")
                cutscene:text("* Dess,[wait:5] you really need to shut up.", "shaded_pissed", "jamm")
                cutscene:showNametag("Dess")
                cutscene:text("* ...", "wtf", "dess")
                cutscene:text("* well excuse me princess", "angry", "dess")
                cutscene:text("* it's working,[wait:5] therefore what we're doing is perfectly fine", "neutral", "dess")
                cutscene:showNametag("Jamm")
                cutscene:text("* Violence will only take you so far,[wait:5] Dess.", "shaded_frown", "jamm")
                cutscene:showNametag("Dess")
                cutscene:text("[noskip]* well it's gotten us this far,[wait:5] so i think that-", "angry", "dess", {auto = true})
                cutscene:showNametag("Susie")
                cutscene:text("* Will the both of you just shut up already?!", "angry", "susie")
                cutscene:text("* You two are driving me up the goddamn wall!", "angry_c", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* ", "wtf_b", "dess")
                cutscene:showNametag("Jamm")
                cutscene:text("* ...", "shaded_pissed", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* Thank you...", "annoyed", "susie")
                if not Game:getFlag("thoughts_leftend") then
                    cutscene:text("* Let's just go back and do the other path.", "annoyed", "susie")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* ...", "shaded_neutral", "jamm")
                else
                    cutscene:text("* Look,[wait:5] Jamm,[wait:5] your attitude is REALLY starting to piss me off.", "annoyed_down", "susie")
                    cutscene:text("* I want you to cut the crap by the time we meet up with Brenda,[wait:5] okay?", "annoyed", "susie")
                    cutscene:showNametag("Dess")
                    cutscene:text("* Oooo,[wait:5] you're in troubleeee", "condescending", "dess")
                    cutscene:showNametag("Susie")
                    cutscene:text("* Dess,[wait:5] you're not off the hook either.", "annoyed", "susie")
                    cutscene:text("* The both of you guys need to stop acting like...", "annoyed_down", "susie")
                    cutscene:text("* ... this place personally insulted you or something.", "annoyed_down", "susie")
                    cutscene:text("* I do NOT want to have to be the team mom here.", "nervous_side", "susie")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* ...", "shaded_pissed", "jamm")
                    cutscene:showNametag("Dess")
                    cutscene:text("* ...", "neutral_c", "dess")
                    Assets.stopAndPlaySound("ominous")
                end
                cutscene:hideNametag()
            else
                cutscene:showNametag("Susie")
                cutscene:text("* Y'know, Dess,[wait:5] I'm surprised you aced that last one.", "nervous", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* hey what can i say,[wait:5] im an alpha gamer", "condescending", "dess")
                cutscene:showNametag("Jamm")
                cutscene:text("* ...[wait:10] Sure.", "nervous_left", "jamm")
                if not Game:getFlag("thoughts_leftend") then
                    cutscene:showNametag("Susie")
                    cutscene:text("* Anyways,[wait:5] let's go do the other path now.", "small_smile", "susie")
                    cutscene:showNametag("Jamm")
                    cutscene:text("* Sounds good to me.", "happy", "jamm")
                else
                    cutscene:showNametag("Susie")
                    cutscene:text("* Hopefully that forcefield should be open now.", "neutral_side", "susie")
                    cutscene:text("* I just really hope Brenda's okay...", "shy_down", "susie")
                end
                cutscene:hideNametag()
            end
            Game:setFlag("thoughts_rightend", true)
        end
    end,

    corridor = function(cutscene, event)
        local x,y = event.x + event.width/2, event.y + event.height/2
        cutscene:detachCamera()
        cutscene:wait(cutscene:panTo(x, y-30))
        cutscene:showNametag("Susie")
        cutscene:text("* Hey,[wait:5] Brenda,[wait:5] it's us!", "sad_frown", "susie")
        cutscene:showNametag("Brenda")
        cutscene:text("* ...", "shaded_b", "brenda")
        cutscene:text("* Why can't I do anything right?", "shaded", "brenda")
        cutscene:showNametag("Susie")
        cutscene:text("* ...", "sad", "susie")
        cutscene:text("* Dude,[wait:5] are you okay?", "sad_frown", "susie")
        cutscene:showNametag("Brenda")
        cutscene:text("* Susie,[wait:5] my recklessness nearly got the both of us killed.", "sad", "brenda")
        cutscene:showNametag("Susie")
        cutscene:text("* Hey,[wait:5] don't beat yourself over that,[wait:5] we all make mistakes.", "nervous", "susie")
        cutscene:showNametag("Brenda")
        cutscene:text("* ...", "shaded_b", "brenda")
        cutscene:text("* Don't follow me.", "miffed", "brenda")
        cutscene:hideNametag()
        local brenda = cutscene:getCharacter("brenda_dreamscape")
        brenda:walkTo(x, -60, 4, "up")
        cutscene:wait(3.5)
        cutscene:showNametag("Susie")
        cutscene:text("* ...", "shy_down", "susie")
        cutscene:text("* We need to go after her,[wait:5] c'mon.", "annoyed_down", "susie")
        cutscene:hideNametag()
        cutscene:wait(cutscene:attachCamera())
        Game:setFlag("b_corridor", true)
    end,

    boss = function(cutscene, event)
        local x,y = event.x + event.width/2, event.y + event.height/2
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local jamm = cutscene:getCharacter("jamm")
        local brenda = cutscene:getCharacter("brenda_dreamscape")
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo(x + 250, y, 2)
        susie:walkTo(x + 50, y - 60, 2, "right", "right")
        dess:walkTo(x + 40, y, 2, "right", "right")
        jamm:walkTo(x + 50, y + 60, 2, "right", "right")
        cutscene:wait(2)
        cutscene:showNametag("Susie")
        cutscene:text("* Hey,[wait:5] Brenda,[wait:5] listen...", "shy_down", "susie")
        cutscene:text("* Whatever's troubling you,[wait:5] we can help you through it.", "sincere", "susie")
        cutscene:showNametag("Brenda")
        cutscene:text("* I thought I told you not to follow me.", "shaded", "brenda")
        cutscene:showNametag("Susie")
        cutscene:text("* I mean,[wait:5] I don't want to leave you like this.", "annoyed_down", "susie")
        cutscene:text("* You seem like you're going through a lot right now.", "shy_down", "susie")
        cutscene:showNametag("Brenda")
        brenda:setFacing("down")
        cutscene:text("* ...", "shaded_b", "brenda")
        cutscene:hideNametag()
        cutscene:wait(3)
        brenda:setSprite("battle/idle_1")
        dess:alert(0.5)
        cutscene:wait(0.5)
        brenda:setAnimation("aim")
        dess:walkTo(x + 40, y - 40, 0.15, "down", "down")
        susie:setFacing("down")
        jamm:setFacing("up")
        cutscene:wait(0.2)
        Assets.stopAndPlaySound("bigcut")
        brenda:setAnimation("fire")
        cutscene:wait(2)
        susie:setFacing("right")
        dess:walkTo(x + 40, y, 1, "right", "down")
        jamm:setFacing("right")
        brenda:setAnimation("idle")
        cutscene:showNametag("dess")
        cutscene:text("[noskip]* dude watch where you shoot that thing", "angry", "dess")
        cutscene:text("* it aint deer season", "neutral_c", "dess")
        cutscene:showNametag("Brenda")
        cutscene:text("* If you're not gonna leave me alone...", "shaded", "brenda")
        Game.world.music:stop()
        cutscene:text("* Then I'll MAKE you leave me alone.", "mad", "brenda")
        cutscene:showNametag("Susie")
        cutscene:text("* (Brenda...)", "sad_frown", "susie")
        cutscene:hideNametag()

        -- remove damaging spells
        local susie_party = Game:getPartyMember("susie")
        local dess_party = Game:getPartyMember("dess")
        local jamm_party = Game:getPartyMember("jamm")
        susie_party:removeSpell("rude_buster")
        if susie_party:hasSpell("flame_buster") then
            susie_party:removeSpell("flame_buster")
            Game:setFlag("b_fight_flame_buster", true)
        end
        if not Game:getFlag("dungeonkiller") then
            if dess_party:hasSpell("starshot") then
                dess_party:removeSpell("starshot")
                Game:setFlag("b_fight_starshot", true)
            end
            if dess_party:hasSpell("starstorm") then
                dess_party:removeSpell("starstorm")
                Game:setFlag("b_fight_starstorm", true)
            end
            jamm_party:removeSpell("darksling")
            if jamm_party:hasSpell("electric_havoc") then
                jamm_party:removeSpell("electric_havoc")
                Game:setFlag("b_fight_electric_havoc", true)
            end
        end
        cutscene:startEncounter("brenda", true, {{"brenda", brenda}})
        -- add damaging spells back
        susie_party:addSpell("rude_buster")
        if Game:getFlag("b_fight_flame_buster") then
            susie_party:addSpell("flame_buster")
        end
        if Game:getFlag("b_fight_starshot") then
            dess_party:addSpell("starshot")
        end
        if Game:getFlag("b_fight_starstorm") then
            dess_party:addSpell("starstorm")
        end
        if not Game:getFlag("dungeonkiller") then
            jamm_party:addSpell("darksling")
        end
        if Game:getFlag("b_fight_electric_havoc") then
            jamm_party:addSpell("electric_havoc")
        end
        if Game:getFlag("b_fight_violence") then
            susie.x = brenda.x - 80
            susie.y = brenda.y - 5
            susie.flip_x = true
            susie:setSprite("battle/defeat")
            cutscene:wait(2)
            brenda:setSprite("battle/hurt")
            brenda:shake(5)
            Assets.stopAndPlaySound("wing")
            cutscene:wait(1)
            cutscene:showNametag("Brenda")
            cutscene:text("* O-oh my god,[wait:5] I...", "shaded_b", "brenda")
            cutscene:text("* Susie,[wait:5] a-are you okay...?", "shaded_sad", "brenda")
            cutscene:showNametag("Susie")
            cutscene:text("* Y-yeah,[wait:5] I'm fine.", "bangs_smile", "susie")
            brenda:resetSprite()
            brenda:setFacing("left")
            cutscene:showNametag("Brenda")
            cutscene:text("* Why did you...", "shaded", "brenda")
            cutscene:hideNametag()
            cutscene:wait(1)
            susie:shake(5)
            Assets.stopAndPlaySound("wing")
            susie.flip_x = false
            susie:resetSprite()
            susie:setFacing("left")
            cutscene:wait(1)
            susie:setFacing("right")
            cutscene:showNametag("Susie")
            cutscene:text("* It's because I care about you,[wait:5] dude.", "sad_frown", "susie")
            cutscene:text("* Look,[wait:5] I know we've only known each other for a few hours,[wait:5] but...", "sad", "susie")
            cutscene:text("* Those few hours were all I needed to know that deep down...", "sincere", "susie")
            cutscene:text("* ... you're a great person.", "sincere_smile", "susie")
            cutscene:text("* Please...[wait:10] we don't have to fight each other.", "sad_frown", "susie")
            cutscene:text("* We can just,[wait:5] talk things out.", "shy_down", "susie")
            dess:setFacing("up")
            cutscene:showNametag("Dess")
            cutscene:text("* ...", "neutral_b", "dess")
            dess:setFacing("right")
            dess:walkTo(x + 120, y, 1.5, "right")
            cutscene:text("* brenda,[wait:5] i...", "neutral_b", "dess")
            cutscene:text("* ik this may seem hard to believe but", "neutral_c", "dess")
            cutscene:text("* i care about you too my gal", "neutral", "dess")
            cutscene:text("* i know im like an annoying asshole and all but", "neutral_b", "dess")
            cutscene:text("* you really are so fun to be around", "kind", "dess")
            cutscene:text("* you're like,[wait:5] cooler than Mug:tm: Root Beer", "heckyeah", "dess")
            cutscene:text("* and if you know me,[wait:5] you know that's saying a lot", "condescending", "dess")
            cutscene:showNametag("Brenda")
            cutscene:text("* I...", "sad", "brenda")
            cutscene:text("* I'm so sorry.", "sad_b", "brenda")
            cutscene:showNametag("Susie")
            cutscene:text("* Hey,[wait:5] there's no need to be upset with yourself.", "nervous", "susie")
            cutscene:text("* We forgive you.", "sincere", "susie")
            cutscene:showNametag("Brenda")
            cutscene:text("* R-really...?", "sad", "brenda")
            cutscene:showNametag("Susie")
            cutscene:text("* Yeah,[wait:5] because that's what friends are for.", "sincere", "susie")
            cutscene:text("* To help each other out.", "sincere_smile", "susie")
            cutscene:showNametag("Brenda")
            cutscene:text("* I...", "sad", "brenda")
            cutscene:showNametag("Dess")
            cutscene:text("* yeah dude let's not try to kill each other", "heckyeah", "dess")
            cutscene:text("* that's like super lame imo", "neutral_b", "dess")
            brenda:setFacing("down")
            cutscene:showNametag("Brenda")
            cutscene:text("* ...", "sad", "brenda")
            brenda:setFacing("left")
            cutscene:text("* Thank you,[wait:5] I care about you guys too.", "happy_tears", "brenda")
        else
            cutscene:showNametag("Brenda")
            cutscene:text("* I...", "shaded_b", "brenda")
            cutscene:hideNametag()
            cutscene:wait(1)
            brenda:shake(5)
            brenda:setSprite("down")
            Assets.stopAndPlaySound("wing")
            cutscene:wait(1)
            cutscene:showNametag("Brenda")
            cutscene:text("* I-I'm so sorry guys,[wait:5] I...", "shaded", "brenda")
            brenda:setSprite("down_crying")
            cutscene:text("* Why the hell did I attack you?!", "shaded_sad", "brenda")
            cutscene:showNametag("Susie")
            cutscene:text("* Brenda...", "sad", "susie")
            cutscene:hideNametag()
            susie:walkTo(brenda.x - 80, brenda.y - 5, 3, "right")
            cutscene:wait(4)
            cutscene:showNametag("Susie")
            cutscene:text("* Hey,[wait:5] everything's gonna be alright, dude.", "sincere", "susie")
            cutscene:text("* We forgive you!", "sincere_smile", "susie")
            cutscene:showNametag("Brenda")
            cutscene:text("* R-really...?", "shaded_sad", "brenda")
            cutscene:showNametag("Dess")
            cutscene:text("* yeah dude,[wait:5] like i said you're a pretty cool gal", "neutral", "dess")
            cutscene:text("* even cooler than Mug:tm: Root Beer", "heckyeah", "dess")
            cutscene:text("* which if you know me,[wait:5] that's saying a lot", "kind", "dess")
            cutscene:showNametag("Brenda")
            brenda:setSprite("down")
            cutscene:text("* I...", "shaded_b", "brenda")
            cutscene:hideNametag()
            cutscene:wait(1)
            brenda:shake(5)
            brenda:resetSprite()
            brenda:setFacing("left")
            Assets.stopAndPlaySound("wing")
            cutscene:wait(1)
            cutscene:showNametag("Brenda")
            cutscene:text("* I care about you guys too.", "happy_tears", "brenda")
        end
        cutscene:showNametag("Dess")
        cutscene:text("* ok ik we're having a heartfelt moment rn but", "neutral_b", "dess")
        cutscene:text("* where the hell are we and how tf do we get out", "angry", "dess")
        cutscene:showNametag("Brenda")
        cutscene:text("* Oh,[wait:5] uhhh...", "neutral_side", "brenda")
        cutscene:text("* Where we are isn't really important right now.", "neutral", "brenda")
        cutscene:text("* So like,[wait:5] just close your eyes and relax for a bit...", "happy_side", "brenda")
        cutscene:text("* ... and we'll be right back at my room!", "happy_b", "brenda")
        cutscene:showNametag("Susie")
        cutscene:text("* Sounds good to me!", "smile", "susie")
        cutscene:text("* You guys ready to leave?", "small_smile", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* yup", "challenging", "dess")
        cutscene:hideNametag()
        cutscene:wait(cutscene:fadeOut(1))
        cutscene:wait(3)
        cutscene:loadMap("devhotel/rooms/room_001/entrance", "sleepover")
        susie = cutscene:getCharacter("susie")
        dess = cutscene:getCharacter("dess")
        jamm = cutscene:getCharacter("jamm")
        x,y = Game.world.map.markers["sleepover"].x, Game.world.map.markers["sleepover"].y
        susie:setSprite("fell")
		dess:setSprite("battle/defeat_1")
		jamm:setSprite("landed_2")
        dess.x = x - 80
        jamm.x = x + 80
        cutscene:wait(cutscene:fadeIn(1))
        cutscene:wait(1)
        susie:shake(5)
        Assets.stopAndPlaySound("wing")
        susie:setSprite("landed_2")
        cutscene:wait(1)
        susie:shake(5)
        Assets.stopAndPlaySound("wing")
        susie:resetSprite()
        susie:setFacing("down")
        cutscene:wait(2)
        dess:shake(5)
        jamm:shake(5)
        dess:resetSprite()
        jamm:resetSprite()
        dess:setFacing("right")
        jamm:setFacing("left")
        Assets.stopAndPlaySound("wing")
        cutscene:wait(1)
        cutscene:showNametag("Susie")
        cutscene:text("* ...[wait:10] Was that all...[wait:10] just a dream...?", "nervous_side", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* idk fam it felt real to me", "calm", "dess")
        cutscene:showNametag("Susie")
        cutscene:text("* Wait so like...[wait:10] we really did have a fight with Brenda?", "shy", "susie")
        cutscene:showNametag("Dess")
        cutscene:text("* seems like it", "neutral", "dess")
        cutscene:showNametag("Susie")
        cutscene:text("* Got it.", "sus_nervous", "susie")
        if Game:getFlag("b_fight_violence") then
            cutscene:text("* ...", "shy_down", "susie")
            jamm:setFacing("down")
            cutscene:showNametag("jamm")
            cutscene:text("* ...", "shaded_frown", "jamm")
            cutscene:hideNametag()
            jamm:walkTo(x + 80, 680, 3, "down")
            dess:setFacing("down")
            cutscene:wait(3)
            dess:setFacing("right")
            susie:setFacing("left")
            cutscene:showNametag("Susie")
            cutscene:text("* What the hell was HIS problem?", "annoyed", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* ...", "neutral_c", "dess")
            cutscene:text("* (... is all of this my fault...?)", "neutral_c", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* You doing okay,[wait:5] Dess?", "neutral_side", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* huh?", "wtf", "dess")
            cutscene:text("* oh uh yeah i'm doing just fine", "condescending", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* Alright,[wait:5] just making sure.", "sus_nervous", "susie")
            Game:removePartyMember("jamm")
            Game:setFlag("jamm_party", false)
            Game:getPartyMember("susie"):addOpinion("dess", 50)
            Game:getPartyMember("susie"):addOpinion("brenda", 20)
            Game:getPartyMember("susie"):setOpinion("jamm", 5)
            Game:getPartyMember("dess"):addOpinion("susie", 15)
            Game:getPartyMember("dess"):addOpinion("brenda", 15)
            Game:getPartyMember("dess"):addOpinion("jamm", -10)
            Game:getPartyMember("brenda"):addOpinion("susie", 20)
            Game:getPartyMember("brenda"):addOpinion("dess", 25)
            Game:getPartyMember("brenda"):addOpinion("jamm", -20)
        elseif Game:getFlag("dungeonkiller") then
            cutscene:showNametag("jamm")
            jamm:setFacing("left")
            susie:setFacing("right")
            cutscene:text("* Tch,[wait:5] all that talk was rich coming from you,[wait:5] Dess...", "shaded_pissed", "jamm")
            cutscene:showNametag("Dess")
            cutscene:text("* ", "wtf", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* Hey,[wait:5] is that really neccesary?", "annoyed", "susie")
            cutscene:text("* Like I know before now she's been VERY annoying.", "annoyed_down", "susie")
            cutscene:text("* But she genuinely cares about Brenda.", "annoyed", "susie")
            cutscene:showNametag("jamm")
            cutscene:text("* You wouldn't understand,[wait:5] Susie.", "shaded_pissed", "jamm")
            cutscene:hideNametag()
            jamm:walkTo(x + 80, 680, 3, "down")
            dess:setFacing("down")
            susie:setFacing("down")
            cutscene:wait(3)
            dess:setFacing("right")
            susie:setFacing("left")
            cutscene:showNametag("Susie")
            cutscene:text("* What's gotten into him lately...?", "annoyed_down", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* ...", "neutral_c", "dess")
            cutscene:text("* (... is all of this my fault...?)", "neutral_c", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* You doing okay,[wait:5] Dess?", "neutral_side", "susie")
            cutscene:showNametag("Dess")
            cutscene:text("* huh?", "wtf", "dess")
            cutscene:text("* oh uh yeah i'm doing just fine", "condescending", "dess")
            cutscene:showNametag("Susie")
            cutscene:text("* Alright,[wait:5] just making sure.", "sus_nervous", "susie")
            Game:removePartyMember("jamm")
            Game:setFlag("jamm_party", false)
            Game:getPartyMember("susie"):addOpinion("dess", 60)
            Game:getPartyMember("susie"):addOpinion("brenda", 20)
            Game:getPartyMember("susie"):addOpinion("jamm", -10)
            Game:getPartyMember("dess"):addOpinion("susie", 15)
            Game:getPartyMember("dess"):addOpinion("brenda", 15)
            Game:getPartyMember("brenda"):addOpinion("susie", 20)
            Game:getPartyMember("brenda"):addOpinion("dess", 35)
        end
        cutscene:showNametag("Susie")
        cutscene:text("* Hey,[wait:5] Brenda,[wait:5] you awake?", "neutral", "susie")
        cutscene:showNametag("Brenda")
        cutscene:text("* Yeah,[wait:5] I am.", "", "brenda")
        cutscene:text("* I'm just getting dressed,[wait:5] so you guys can go ahead without me.", "", "brenda")
        cutscene:showNametag("Susie")
        cutscene:text("* Got it.", "neutral", "susie")
        if Game:getFlag("dungeonkiller") then
            cutscene:text("* C'mon, Dess,[wait:5] let's go.", "neutral_side", "susie")
        else
            cutscene:text("* C'mon, guys,[wait:5] let's go.", "neutral_side", "susie")
        end
        cutscene:hideNametag()
        Game.world:mapTransition("devhotel/devhotel1", "door_001", "down")
    end,
}
