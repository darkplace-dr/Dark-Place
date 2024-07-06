return {
    meet_test = function(cutscene, event)
        local noel = cutscene:getCharacter("noel")
        cutscene:setSpeaker(noel)
        cutscene:setTextboxTop(true)
        
    --[[    -- Example usage
        local newData = {
            playerName = Game.save_name,
            met_player = "true"
        }
        Mod:noel_updateAndSaveGame(newData)

        local savedData = Mod:noel_loadGame()

        -- Just a test.
        if savedData.playerName and savedData.playerName2 then
            cutscene:showNametag("Noel", { top = true, right = false})
            cutscene:text("* Wait, are you "..savedData.playerName.." or "..savedData.playerName2.."?\n* I'm a bit confused.", "oh")
        end


        cutscene:text("* Sorry, [wait:5]could you come back [color:yellow]later[color:reset]?", "neutral")
        cutscene:text("* I have [color:yellow]VERY[color:reset][wait:10] important things to take care of.", "lookup")
        cutscene:text("* Like, [color:yellow][wait:10]nothing.[color:reset]", "oh")
        cutscene:text("* It's very [color:yellow]tedious[color:reset] work ya know?", "bruh")
        local savedData = Mod:noel_loadGame()
        cutscene:showNametag("The game didn't crash give it a moment...", { top = true, right = false})
        cutscene:text("* (Hey, [color:yellow]"..savedData.playerName.."[color:reset]. I can only join the party at 10% completion.)", "bruh")

        
        -- Example usage
        if Mod:ifRunning({"obs32.exe", "obs64.exe", "obs.exe"}) then
            cutscene:showNametag("If Monika from DDLC can do it, so can I!", { top = true, right = false})
            cutscene:text("* OBS is open...\n* Why is it open?\n* Are you recording me?", "neutral")
        else
            cutscene:text("* Sorry if I made your game lag out for a bit.", "neutral")
        end
        




-- This was just for testing
--[[        --cutscene:text("* Hello Player.", "bruh")
        cutscene:text("* You're not supposed to be here.", "bruh")
        cutscene:text("* I'm not mad.", "neutral")
        cutscene:text("* I'M SHOCKED!", "loud")
        cutscene:text("* How did you get here?", "oh")
        cutscene:text("* I can't figure it out...", "...")
        cutscene:text("* ...", "...")
        cutscene:text("* ...", "neutral")
        cutscene:text("* You went fast?", "lookup")
        --cutscene:text("* ExcuseMeButWhatTheHell", "oh")
        cutscene:text("* oH yEAh thAts UndErstAndAblE", "excusemebutwhatthefuck")
        cutscene:text("* NOT!!!", "loud")
        cutscene:text("* Damn idiot.", "bruh")
        cutscene:text("* Went fast.", "...")]]
    --[color:red][shake:1][shake:0][color:reset]

        cutscene:showNametag("Noel", { top = true, right = false})

        function writeTextWithNametag(text, swap, face)

            local len = string.len(text)
            print(len)
            for i = 1, len do

                local current = string.sub(text, 1, i - 1)
                local letter = string.sub(text, i, i)
                print("" .. current .. "")
                cutscene:showNametag("".. current ..""..string.upper(letter), { top = true, right = false})
                if i == len then
                    if swap then
                        cutscene:text("[instant]"..swap, face, "noel", {auto = false})
                    else
                        cutscene:text("[instant]".. current .."[stopinstant]".. letter, face, "noel", {auto = false})
                    end
                else
                    if swap then
                        cutscene:text("[instant]"..swap, face, "noel", {auto = true})
                    else
                        cutscene:text("[instant]".. current .."[stopinstant]"..letter, face, "noel", {auto = true})
                    end
                end
                Assets.playSound("voice/noel/"..string.lower(letter), 1, 1)
            end
        end
        
        --writeTextWithNametag("* Hello there "..Game.save_name..".", false, "bruh")

        function findDifferenceIndex(text, text2)
            local minLen = math.min(#text, #text2)
            for i = 1, minLen do
                if text:sub(i, i) ~= text2:sub(i, i) then
                    return i
                end
            end
            return minLen
        end

        function UndoMyFuckup(text, text2, speaker, texts, faces)
            local len = string.len(text2)
            local len2 = string.len(text)

            local dif = findDifferenceIndex(text, text2)

            local fin2 = string.sub(text2, dif, len)

            local currentIndex = 1

            local function nextTag()
                local nextText = texts[currentIndex]
                currentIndex = (currentIndex % #texts) + 1
                return nextText
            end

            -- I feel like there should be a better way to do this.
            local isU = true
            local function toggleCase(text)
                if isU then
                    isU = false
                    return string.lower(text)
                else
                    isU = true
                    return string.upper(text)
                end
            end
            
            cutscene:text(text, "neutral", speaker, {auto = true})

            for i = 1, len2 do
                local rface = faces[math.random(1, #faces)]

                local current = string.sub(text, 1, dif - 1)
                local current2 = string.sub(text, dif, len2 - i)
                if i == len2 then
                    cutscene:showNametag("Noel", { top = true, right = false})
                    cutscene:text("[instant]"..current.."[stopinstant]"..fin2, "neutral", speaker)
                else
                    cutscene:showNametag(nextTag(), { top = true, right = false})
                    --I use speed instead of instant because of the funny sound it makes.
                    cutscene:text("[speed:30]"..toggleCase(current).."[shake:5]"..current2, rface, speaker, {auto = true})
                end
            end
        end
        
        -- This fucking scares me so much, but it works.

        local text = "* Oh SHIT" -- this is the text that will be undone
        local text2 = "* Oh SNAP! \n[wait:5]* Sorry,[speed:1][wait:5] looks like I forgot about the textbox limit." -- this is the final test
        local speaker = "noel" -- the person who should be talking
        local texts = {"I'M", "NOT", "ALLOWED", "TO", "SWEAR"} -- the name tag will cycle through these in order, and loop if necessarry.
        local faces = {"excusemebutwhatthefuck", "oh", "loud_2", "c_neutral"} -- the faces that will be picked at random.
        
        cutscene:text("* (...)", "bruh")
        cutscene:text("* ([shake:1][speed:0.4]"..Game.save_name.."?[shake:0][wait:3][speed:1] Right?)", "bruh")
        cutscene:text("* (Forgive me if I'm wrong.)\n[wait:8]* (I have no real way to verify if it is honestly.)\n[wait:8]* (I really should not rely on Game.save_name for", "neutral", "noel", {auto = true})

        UndoMyFuckup(text, text2, speaker, texts, faces)

        --[[
        cutscene:text("* (Oh SHIT", "oh", "noel", {auto = true})
        cutscene:showNametag("I'M", { top = true, right = false})
        cutscene:text("[speed:30]* (OH SH[shake:5]I", "c_neutral", "noel", {auto = true})
        cutscene:showNametag("NOT", { top = true, right = false})
        cutscene:text("[speed:30]* (OH S[shake:5]H", "loud_2", "noel", {auto = true})
        cutscene:showNametag("ALLOWED", { top = true, right = false})
        cutscene:text("[speed:30]* (OH S", "excusemebutwhatthefuck", "noel", {auto = true})
        cutscene:showNametag("TO", { top = true, right = false})
        cutscene:text("[speed:30]* (OH S[shake:5]n", "oh", "noel", {auto = true})
        cutscene:showNametag("SWEAR", { top = true, right = false})
        cutscene:text("[speed:30]* (OH SN[shake:5]a", "excusemebutwhatthefuck", "noel", {auto = true})
        cutscene:showNametag("Noel", { top = true, right = false})
        cutscene:text("[speed:10]* (Oh SNAP[speed:0.5]!)\n[wait:5]* Sorry,[speed:1][wait:5] looks like I forgot about the textbox limit.", "neutral")
        ]]
    
        cutscene:showNametag("Noel", { top = true, right = false})
        
        cutscene:text("* oh, l didn't even intrOduce myseIf.[wait:8]", "bruh", "noel", {auto = true})
        cutscene:showNametag("There was no name here. You're crazy.", { top = true, right = false})
        cutscene:text("[instant]* Oh, I didn't even introduce myself.", "bruh", "noel")

        cutscene:text("* (Not like I need to, since you can read my [color:yellow]NAMETAG[color:reset] n all.)[wait:8]", "bruh", "noel", {auto = true})
        cutscene:showNametag("Oh wait, you can't.", { top = true, right = false})
        cutscene:text("[instant]* (Not like I need to, since you can read my [color:yellow]NAMETAG[color:reset] n all.)", "bruh")

        writeTextWithNametag("* Name's Noel, and you are?", "Noel", "neutral")

        writeTextWithNametag("* Whoops.", false, "oh")

        writeTextWithNametag("* Wrong box.", false, "lookup")

        local error_message = "Is this the right one?"
        local buttonlist = {"No", "Yes", escapebutton = 3}


        local index = love.window.showMessageBox("Noel", error_message, buttonlist)

        if index == 2 then
            love.window.showMessageBox("Noel", "Oh, good...", "info")
            love.window.showMessageBox("Noel", "...", "info")
            love.window.showMessageBox("Noel", "...", "info")
            love.window.showMessageBox("Noel", "...", "info")
            love.window.showMessageBox("Noel", "Liar.", "warning")
        elseif index == 1 then
            love.window.showMessageBox("Noel", "Darn...", "error")
            cutscene:text("* (How about now?)", "neutral")
            cutscene:text([[* (wait, gotta remove the "()'s" so people can hear me...)]], "oh")
        else
            local a = {"..."}
            love.window.showMessageBox("Noel", "Did you just reject my fucking choicer???", a, "warning")   
            love.window.showMessageBox("Noel", "Well, Fuck You!", a, "error")  
            love.window.showMessageBox("Noel", "*crashes your game*", a, "error")  
            love.window.showMessageBox("Noel", "...", a, "error")  
            love.window.showMessageBox("Noel", "I was joking btw.", a, "info")  
            love.window.showMessageBox("Noel", "What kind of idiot would willingly do that?", a, "info") 
            love.window.showMessageBox("Noel", "I don't crash your game unlike some people.", a, "info")   
            love.window.showMessageBox("Noel", "Ps: I'm not talking about you Jeku.", a, "info")  
            love.window.showMessageBox("Noel", "I'm not a moron.", a, "info") 
        end


        --[[local title = "This is a title"
        local message = "This is some text"
        local buttons = {"OK", "No!", "Help", escapebutton = 2}

        local pressedbutton = love.window.showMessageBox(title, message, buttons)
        if pressedbutton == 1 then
            -- "OK" was pressed
        elseif pressedbutton == 2 then
            -- etc.
        end]]



        cutscene:hideNametag()
    end,
    meet_nah = function(cutscene, event)
        cutscene:showNametag("Noel", { top = true, right = false})
        cutscene:setTextboxTop(true)

        function findDifferenceIndex(text, text2)
            local minLen = math.min(#text, #text2)
            for i = 1, minLen do
                if text:sub(i, i) ~= text2:sub(i, i) then
                    return i
                end
            end
            return minLen
        end

        function writeTextWithNametag(text, swap, face, auto)

            local len = string.len(text)
            print(len)
            for i = 1, len do

                local current = string.sub(text, 1, i - 1)
                local letter = string.sub(text, i, i)
                print("" .. current .. "")
                cutscene:showNametag("".. current ..""..string.upper(letter), { top = true, right = false})
                love.window.setTitle(current ..""..string.upper(letter))

                if auto then
                    if i == len then
                        if swap then
                            cutscene:text("[instant]"..swap, face, "noel", {auto = true})
                        else
                            cutscene:text("[instant]".. current .."[stopinstant]".. letter, face, "noel", {auto = true})
                        end
                    else
                        if swap then
                            cutscene:text("[instant]"..swap, face, "noel", {auto = true})
                        else
                            cutscene:text("[instant]".. current .."[stopinstant]"..letter, face, "noel", {auto = true})
                        end
                    end
                else
                    if i == len then
                        if swap then
                            cutscene:text("[instant]"..swap, face, "noel", {auto = false})
                        else
                            cutscene:text("[instant]".. current .."[stopinstant]".. letter, face, "noel", {auto = false})
                        end
                    else
                        if swap then
                            cutscene:text("[instant]"..swap, face, "noel", {auto = true})
                        else
                            cutscene:text("[instant]".. current .."[stopinstant]"..letter, face, "noel", {auto = true})
                        end
                    end
                end
                Assets.playSound("voice/noel/"..string.lower(letter), 1, 1)
            end
        end
        
        writeTextWithNametag("* Hello there "..Game.save_name..".", false, "bruh", true)
        writeTextWithNametag("* I don't know how to intoduce myself.", false, "neutral", true)
        writeTextWithNametag("* So, I'm just going to.", false, "neutral", true)
        cutscene:showNametag("Noel", { top = true, right = false})
        writeTextWithNametag("* (Forgive me if I got your name wrong.)\n* (I have no real way to verify what it is honestly.)\n* (I really should not rely on Game.save_name for-", false, "neutral", true)
    



        local index = love.window.showMessageBox("Noel", "* I'm gonna have a cat sidequest thingimajig\nbut it's not done being built.", {"What?", "Ok"})

        --cutscene:text("* I don't know how I should introduce myself.", "bruh", "noel")
        function may_i_join()
            local index = love.window.showMessageBox("Noel", "* Once you let me in, I will never leave.\n\n* Understood?", {"No", "Yes"}, "warning")
            local index = love.window.showMessageBox("Noel", "You only get...\n\nshit, i forgot the line from oneshot.", {"What?", "Ok?"})
            local index = love.window.showMessageBox("Noel", "Your actions here will affect Niko.", {"What?", "Ok"})

        end
        --may_i_join()
        cutscene:hideNametag()
    end,
    meet = function(cutscene, event)

        local dess = cutscene:getCharacter("dess")
        local YOU = cutscene:getCharacter("YOU")
        local noel = cutscene:getCharacter("noel")
        cutscene:setSpeaker(noel)
        cutscene:setTextboxTop(true)

        local index = love.window.showMessageBox("???", "* Once you let me in, I will never leave.\n\n* Understood?", {"No", "Yes", escapebutton = 3}, "warning")


        local name = Game.save_name

        if index == 2 then
            local newData = {
                Player_Name = ""..name.."",
                MyName = "Noel",
                Attack = 1,
                Magic = 1,
                MaxHealth = 900,
                Health = 890,
                Defense = -100,
                Am_I_Awake = "Yes",
                Map = "room1",
                Level = "-1",
                Equipped = {
                    armor = {},
                    weapon = {
                    flags = {},
                    id = "old_umbrella"
                    }
                },
                Spells = {"spare_smack", "soul_send", "quick_heal", "life_steal"},
                SaveID = 0,
            }
            --"Equipped":{"weapon":{"flags":[],"id":"old_umbrella"},"armor":{"2":{"flags":[],"id":"jevilstail"},"1":{"flags":[],"id":"dealmaker"}}}
            local noel2 = Game:getPartyMember("noel")
            noel2:setWeapon("old_umbrella")

            Mod:saveGameN(newData)

            local savedData = Mod:loadGameN()
            if not savedData then
                cutscene:text("* [speed:0.2]...", "no portrait")
                love.window.showMessageBox("???", "* Cannot create save data.", {"Ok"}, "warning")
                love.window.showMessageBox("???", "* Sorry, but I won't be able to enter.", {"Ok"}, "warning")
            elseif savedData.Am_I_Awake == "Yes" then
                cutscene:showNametag("???", { top = true, right = false})
                cutscene:text("* [speed:0.2].[face:bruh].[face:neutral].", "huh")
                cutscene:text("* [speed:0.2]oh...", "neutral")
                cutscene:text("* [speed:0.5]Hello there...", "neutral")
                if Game.party[2].id then
                    cutscene:text("* [speed:0.5]Are either of you "..savedData.Player_Name.."?", "neutral")
                else
                    cutscene:text("* [speed:0.5]Are you "..savedData.Player_Name.."?", "neutral")
                end
                if savedData.Player_Name == "DECEMBER" and dess then
                    cutscene:showNametag("Dess", { top = true, right = false})
                    cutscene:text("* please,[wait:3][face:condescending] call me sir", "kind", "dess")
                    cutscene:showNametag("???", { top = true, right = false})
                    cutscene:text("* ???", "oh")
                    cutscene:text("* I beg your pardon?", "oh")
                    cutscene:showNametag("Dess", { top = true, right = false})
                    cutscene:text("* then beg.", "smug", "dess")
                    cutscene:showNametag("???", { top = true, right = false})
                    cutscene:text("* I [wait:5][face:excusemebutwhatthefuck]wha [wait:7][face:...]huh???\n[wait:5][face:huh]* No?[wait:7][face:oh]\n* Oh[wait:3] wait,[wait:4][face:huh] yeah?", "neutral")

                    local text = "* I'm confused.[wait:5]\n* Your" -- this is the text that will be undone
                    local text2 = "* I'm confused.[wait:5]\n* You're DECEMBER?" -- this is the final text
                    local speaker = "noel" -- the person who should be talking
                    local texts = {"YOU'RE", "YOUR"} -- the name tag will cycle through these in order, and loop if necessarry.
                    local faces = {"excusemebutwhatthefuck", "oh", "loud_2", "c_neutral"} -- the faces that will be picked at random.
        
                    Mod:UndoMyFuckup(cutscene, text, text2, speaker, texts, faces)

                    cutscene:showNametag("Dess", { top = true, right = false})
                    cutscene:text("* woah, cool face thing.\n[wait:5][face:genuine]* would be a shame if i used it for [wait:3][color:yellow][face:condescending]personnel[color:white][wait:3] use.", "neutral", "dess") 

                    cutscene:text("* and no,[wait:5]", "condescending", "dess", {auto = true})

                    local noelle_theme = Music("deltarune/noelle_normal", 1, 1)

                    cutscene:text([[[instant]* and no,[stopinstant][speed:0.5] i'm[speed:0.1] [color:red]"HER"[color:white].]], "wink", "dess")


		    noelle_theme:stop()
                    cutscene:showNametag("???", { top = true, right = false})

                    cutscene:text("* You know what?\n[wait:4][face:lookup]* It's not deep so I should not care.", "huh")


                    cutscene:text("* If you say you're", "neutral", "noel", {auto = true})
                    local noelle_theme2 = Music("deltarune/noelle_normal", 1, 1)
                    cutscene:text("[instant]* If you say you're[stopinstant] [color:red]her[color:white],[wait:4][face:bruh] you're", "neutral", "noel", {auto = true})
                    local noelle_theme3 = Music("deltarune/noelle_normal", 1, 1)
                    cutscene:text("[instant]* If you say you're [color:red]her[color:white], you're[stopinstant] [color:red]her[color:white].", "bruh")


                    cutscene:text("* (I didn't think god would be a deer, but what do I know.)", "huh")

		    noelle_theme2:stop()
		    noelle_theme3:stop()
                    local newData = {
                        Thinks_dess_is_player = "true"
                    }    
                    Mod:saveGameN(newData)

                elseif savedData.Player_Name == "YOU" and YOU then
                    -- change this part of the cutscene if you dont like it
                    cutscene:text("* YOU?", "bruh")
                    cutscene:text("* YOU the frog?", "bruh")
                    cutscene:text("* Man, that's confusing to say.", "...")
                    cutscene:text("* You should change it to HUGH.", "bruh")
                    cutscene:text("* Like how my name is pronounnced NULL, but spelled N-O-E-L.", "neutral")
                    cutscene:text("* ...", "lookup")
                    cutscene:text("* HUGH, spelled H-U-G-H.", "neutral")
                    cutscene:text("* ...", "lookup")
                    cutscene:text("* Well, excuuuuuuuuuuse ME!", "bruh")
                    cutscene:text("* I didn't say it was a bad name!", "huh")
                    cutscene:text("* ...", "lookup")
                    cutscene:text("* Don't look at me like that!", "...")


                elseif savedData.Player_Name == "NOEL" then
                    cutscene:text("* [speed:0.25]Wait...", "huh")
                    cutscene:text("* [speed:0.25]NOEL?", "bruh")
                    cutscene:text("* How do you know that name?", "...")
                    local index = love.window.showMessageBox("Noel", "* You know my name.\n* Don't you?", {"   ", escapebutton = 3}, "info")
                    local index = love.window.showMessageBox("Noel", "* How?", {"   ", escapebutton = 3}, "info")
                    local index = love.window.showMessageBox("Noel", "* You know more about reality than I thought.", {"   ", escapebutton = 3}, "info")
                    local index = love.window.showMessageBox("Noel", "* You're cringe.\n* You know that right?", {"   ", escapebutton = 3}, "info")
                    local index = love.window.showMessageBox("Noel", "* Either you learned about me,\nor made me forget.", {"   ", escapebutton = 3}, "info")
                    local index = love.window.showMessageBox("Noel", "* Or maybe...", {"   ", escapebutton = 3}, "info")
                    local index = love.window.showMessageBox("Noel", "* You're just a-", {"   ", escapebutton = 3}, "info")
                    cutscene:text("* [speed:0.2]Hirty Dacker", "hey_jeku") -- note: I am not talking to jeku thats just the sprite for when im in the shop
                    error("* Game crashed because it became too cringe.\n\n* L")
                else
                end

        
                local noel2 = Game:getPartyMember("noel")

                if noel2.health ~= 890 then
                    local text = "* Wait, why are all my stats fuck-" -- this is the text that will be undone
                    local text2 = "* Wait, why are all my stats fudged up?" -- this is the final text
                    local speaker = "noel" -- the person who should be talking
                    local texts = {"I'M", "NOT", "ALLOWED", "TO", "SWEAR"} -- the name tag will cycle through these in order, and loop if necessarry.
                    local faces = {"excusemebutwhatthefuck", "oh", "loud_2", "c_neutral"} -- the faces that will be picked at random.
        
                    Mod:UndoMyFuckup(cutscene, text, text2, speaker, texts, faces)
                    cutscene:showNametag("???", { top = true, right = false})
                    cutscene:text("* Are you on an old save?", "huh")
                    cutscene:text("* Hang on.", "bruh")

                    noel2:removeSpell("soul_send")
                    noel2:removeSpell("life_steal")

                    noel2:addSpell("spare_smack")
                    noel2:addSpell("soul_send")
                    noel2:addSpell("quick_heal")
                    noel2:addSpell("life_steal")

                   --noel2:setWeapon("light/old_umbrella")
                   noel2:setWeapon("old_umbrella")

                    noel2.health = 890
                    noel2.lw_health = 890
                    noel2.stats = {
                        health = 900,
                        attack = 1,
                        defense = -100,
                        magic = 1
                    }

                    noel2.lw_stats = {
                        health = 900,
                        attack = 11,
                        defense = -90,
                        magic = 1
                    }

                    cutscene:showNametag("...", { top = true, right = false})

                    cutscene:text("* There  we go.\n[wait:3]* Much better.", "neutral")

                else

                end

                cutscene:text("* REMEMBER TO FINSIH THIS CUTSCENE SDM", "bruh")


                cutscene:text("* So, may I join the [color:yellow]PARTY[color:white]?", "neutral")
                local savedData = Mod:loadGameN()
                local cc = cutscene:choicer({"Yes", "No"})
                if cc == 1 then
                    if Game.party[Game:getFlag("party_max")] then
                        cutscene:text("* Empty your party first [color:yellow]DUMBASS[color:white].", "huh")
                    else
                        cutscene:text("* Swag bacon.", "bruh")
          	        cutscene:detachFollowers()
                        noel:convertToFollower()
                        Game:addPartyMember("noel")
                        cutscene:attachFollowers()
                        cutscene:alignFollowers()
                        local num = savedData.SaveID
                        Game:setFlag("noel_SaveID", num)
                    end
                else
                    cutscene:text("* Understood "..savedData.Player_Name..".", "neutral")
                    noel:remove()
                end
                cutscene:hideNametag()
            end
        elseif index == 1 then
        else
        end
    end,
    found_again = function(cutscene, event)
        local noel = cutscene:getCharacter("noel")

        cutscene:setSpeaker(noel)

        local savedData = Mod:loadGameN()
        local name = Game.save_name
        local thing = love.math.random(1, 10)
        if thing == 1 then
            cutscene:doki_text("[voice:none]\"So,[wait:5] do you like literature "..savedData.Player_Name.."?\"", nil, noel, {name = "Noel"})
        elseif Game.save_name == savedData.Player_Name then
            cutscene:text("* Ello.", "bruh")
        else
            cutscene:text("* "..name.."?\n* I thought it was "..savedData.Player_Name..".", "...")
            cutscene:text("* You changed it.", "huh")
            cutscene:text("* Does that mean you want me to forget the old one?", "lookup")
        end
        if thing == 1 then
            cutscene:doki_text("[name:Natsuki]\"[voice:none]Oh,[wait:5] may I[name:Noel] also join the [color:yellow]PARTY[color:white] by the way?\"", nil, noel, {name = "Natsuki"})
        else
            cutscene:text("* So, may I join the [color:yellow]PARTY[color:white]?", "neutral")
        end

        local cc = cutscene:choicer({"Yes", "No"})
        if cc == 1 then
            if Game.party[Game:getFlag("party_max")] then
                cutscene:text("* Empty your party first [color:yellow]DUMBASS[color:white].", "huh")
            else
                cutscene:text("* Swag bacon.", "bruh")
	        cutscene:detachFollowers()
                noel:convertToFollower()
                Game:addPartyMember("noel")
                cutscene:attachFollowers()
                cutscene:alignFollowers()
                local num = savedData.SaveID
                Game:setFlag("noel_SaveID", num)
            end
        else
            cutscene:text("* Understood "..savedData.Player_Name..".", "neutral")
        end
        cutscene:hideNametag()
    end
}
