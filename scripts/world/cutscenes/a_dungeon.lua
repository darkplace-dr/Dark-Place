return {
    key1 = function(cutscene, event)
		if not Game:getFlag("acj_key1") then
			cutscene:text("* You search the hay and find a [color:green]key[color:white] on a keychain.")
			cutscene:showNametag("Jamm")
			cutscene:text("* Huh...[wait:5]\n* The first place I'd look...", "nervous", "jamm")
			cutscene:text("* I guess Ania wanted to make this first part easy for me???", "nervous", "jamm")
			cutscene:showNametag("Dess")
			cutscene:text("* So,[wait:5] a needle in a haystack?", "eyebrow", "dess")
			cutscene:showNametag("Jamm")
			cutscene:text("* I hate how literal you were being with that.", "neutral", "jamm")
			Game:setFlag("acj_key1", true)
			cutscene:hideNametag()
			cutscene:text("* You grab the keychain.")
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* I don't think there's anything else in the hay...", "neutral", "jamm")
		end
		cutscene:hideNametag()
    end,
    music_key = function(cutscene, event)
		cutscene:text("* You look down and find a [color:red]key[color:white].")
		cutscene:text("* You put the [color:red]key[color:white] on the keychain.")
		Game:setFlag("acj_music_key", true)
		Game.world.map:getEvent(9):remove()
    end,
    game_key = function(cutscene, event)
		cutscene:text("* You look down and find a [color:blue]key[color:white].")
		cutscene:text("* You put the [color:blue]key[color:white] on the keychain.")
		Game:setFlag("acj_game_key", true)
		Game.world.map:getEvent(9):remove()
    end,
    observe_key = function(cutscene, event)
		cutscene:text("* You look down and find a [color:purple]key[color:white].")
		cutscene:text("* You put the [color:purple]key[color:white] on the keychain.")
		Game:setFlag("acj_observe_key", true)
		Game.world.map:getEvent(9):remove()
    end,
    combat_key = function(cutscene, event)
		cutscene:text("* You look down and find a [color:yellow]key[color:white].")
		cutscene:text("* You put the [color:yellow]key[color:white] on the keychain.")
		Game:setFlag("acj_combat_key", true)
		Game.world.map:getEvent(20):remove()
    end,
    lock1 = function(cutscene, event)
		if Game:getFlag("acj_key1") then
			cutscene:text("* Unlock the door with your [color:green]key[color:white]?")
			local choice = cutscene:choicer({"Yes", "No"})
			if choice == 1 then
				cutscene:text("* You unlock the lock...")
				Assets.playSound("dooropen")
				cutscene:mapTransition("fwood/dungeon_inside/floor2_main", "f1", "down")
			else
				cutscene:text("* You unlockn't.")
			end
		else
			cutscene:text("* You don't have a [color:green]key[color:white] that fits this lock.")
		end
		cutscene:hideNametag()
    end,
    lock2 = function(cutscene, event)
		if Game:getFlag("acj_combat_key") and Game:getFlag("acj_observe_key") and Game:getFlag("acj_game_key") and Game:getFlag("acj_music_key") then
			cutscene:text("* Unlock the door with your [color:red]k[color:blue]e[color:purple]y[color:yellow]s[color:white]?")
			local choice = cutscene:choicer({"Yes", "No"})
			if choice == 1 then
				cutscene:text("* You unlock the lock...")
				Assets.playSound("dooropen")
				cutscene:mapTransition("fwood/dungeon_inside/final_hall", "entry")
			else
				cutscene:text("* You unlockn't.")
			end
		else
			cutscene:text("* You don't have enough [color:red]k[color:blue]e[color:purple]y[color:yellow]s[color:white] that fits this lock.")
		end
		cutscene:hideNametag()
    end,
    king = function(cutscene, event)
		if not Game:getFlag("acj_king_talk") then
			Game:setFlag("acj_king_talk", true)
			cutscene:showNametag("King")
			cutscene:text("[facec:king/regretful][voice:king]* Hm.")
			cutscene:text("[facec:king/sad][voice:king]* Oh?\n* What are you two looking\nat?")
			cutscene:showNametag("Jamm")
			cutscene:text("* You're the Chaos King, right?", "neutral", "jamm")
			cutscene:text("* What are you doing in this dungeon?", "neutral", "jamm")
			cutscene:showNametag("King")
			cutscene:text("[facec:king/sad][voice:king]* I...\n* That is a good question.")
			cutscene:text("[facec:king/sad][voice:king]* I just woke up here one\nnight.")
			cutscene:text("[facec:king/sad_smile][voice:king]* That good-for-nothing\nprince must have moved\nme in my sleep.")
			cutscene:showNametag("Dess")
			cutscene:text("* but you didn't move.", "neutral", "dess")
			cutscene:showNametag("King")
			cutscene:text("[facec:king/straightfaced][voice:king]* Excuse me?")
			cutscene:showNametag("Dess")
			cutscene:text("* you're in a dungeon, right?", "neutral", "dess")
			cutscene:text("* if you were in a dungeon before and you're in one now...", "neutral_b", "dess")
			cutscene:text("* then you're in the same spot.", "heckyeah", "dess")
			cutscene:showNametag("King")
			cutscene:text("[facec:king/angry][voice:king]* ...")
			cutscene:showNametag("Jamm")
			cutscene:text("* I know, king.\n* I have to put up with her.", "stern", "jamm")
			cutscene:text("* But...\n* How were you moved here?", "nervous", "jamm")
			cutscene:showNametag("King")
			cutscene:text("[facec:king/shock][voice:king]* ...Are you body shaming\nme?")
			cutscene:showNametag("Jamm")
			cutscene:text("* Wh--\n* But I didn't--", "nervous", "jamm", {auto = true})
			cutscene:showNametag("King")
			cutscene:text("[facec:king/dissapointed][voice:king]* Begone.[react:1]", nil, nil, {reactions = { 
				{"I'm fat too!", 372, 50, "ouch", "jamm"}
			}})
		else
			cutscene:showNametag("King")
			cutscene:text("[facec:king/straightfaced][voice:king]* We have NOTHING to\ndiscuss.")
		end
		cutscene:hideNametag()
    end,
    music = function(cutscene, event)
		local text

        local function gonerTextFade(wait)
            local this_text = text
            Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function()
                this_text:remove()
            end)
            if wait ~= false then
                cutscene:wait(1)
            end
        end

        -- FIXME: actually use skippable
        local function gonerText(str, advance, skippable)
            text = DialogueText("[speed:0.5][spacing:6][voice:none]" .. str, 160, 100, 640, 480,
                { auto_size = true })
            text.layer = WORLD_LAYERS["textbox"]
            text.skip_speed = not skippable
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)

            cutscene:wait(function() return not text:isTyping() end)
			cutscene:wait(function() return Input.pressed("confirm") or Input.down("menu") end)
            gonerTextFade(true)
        end
		if Game:getFlag("acj_music_bonus") then
			cutscene:text("* It appears doing this trial again won't earn you anything else.")
		else
			local correct = 0
			local warned = false
			local lost = false
			cutscene:text("* You press the button...")
			
			local fade_rect = Rectangle(0, 0, Game.world.width, Game.world.height)
			fade_rect:setColor(0, 0, 0)
			fade_rect.alpha = 0
			Game.world:spawnObject(fade_rect, "below_ui")
			
			Game.stage.timer:tween(1, fade_rect, {alpha = 0.5}, "linear")
			
			cutscene:wait(1)
			
			gonerText("GOOD DAY,[wait:20] LUTHANE.")
			gonerText("I AM THE TRIAL OF\nTHE MUSIC.")
			gonerText("TO PASS,[wait:20] YOU MUST\nANSWER SEVEN OF MY\nTEN QUESTIONS.")
			gonerText("WITHOUT FURTHER\nADO...")
			gonerText("QUESTION ONE.")
			gonerText("FINISH THE\nFOLLOWING:")
			gonerText("DO,[wait:20] RE,[wait:20] MI,[wait:20] FA,[wait:20]\n_,[wait:20] LA,[wait:20] TI/SI,[wait:20] DO.")
			
			local wbi_ok = false
			local action = nil
			local wbi = WarpBinInputMenu(4)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "SOL" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS SOL.")
				gonerText("I SEE THAT YOU\nREMEMBER YOUR\nSOLFEGE.")
				correct = correct + 1
			elseif string.upper(action) == "SO" then
				gonerText("...HM.")
				gonerText("THAT WAS NOT THE\nANSWER I WAS\nEXPECTING...")
				gonerText("NEVERTHELESS,[wait:20]\nYOU ARE CORRECT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("PERHAPS YOU NEED TO\nBRUSH UP ON SOLFEGE.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS SOL.")
				gonerText("SO WOULD HAVE ALSO\nSUFFICED.")
			end
			
			gonerText("QUESTION TWO.")
			gonerText("WHAT ARE THE\nNAMES OF THE\nSPACES IN THE\nTREBLE CLEF?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(4)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "FACE" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS FACE.")
				gonerText("GOOD JOB.\nYOUR TEACHER HASN'T\nFAILED YOU YET.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS FACE.")
				gonerText("REMEMBER:\nTHERE'S A FACE\nIN THE SPACE.")
			end
			
			gonerText("QUESTION THREE.")
			gonerText("WHAT IS COMMON TIME?")
			gonerText("PUT YOUR ANSWER\nIN THE PATTERN\n#/#.")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(3)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "4/4" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS 4/4.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS 4/4.")
			end
			
			gonerText("FOUR BEATS IN\nA MEASURE...")
			gonerText("AND THE QUARTER\nNOTE GETS THE\nBEAT.")
			gonerText("KEEP THIS IN\nMIND FOR LATER.")
			
			if correct == 0 and not warned then
				warned = true
				gonerText("HOW DISAPPOINTING...")
				gonerText("YOU GOT EVERY\nSINGLE ONE WRONG.")
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			gonerText("QUESTION FOUR.")
			gonerText("SAY THE QUARTER\nNOTE GETS THE BEAT.")
			gonerText("HOW MANY BEATS\nARE IN A HALF\nNOTE?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(1)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "2" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS 2.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("I MADE THAT\nONE OBVIOUS.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS 2.")
			end
			
			if correct == 1 and not warned then
				warned = true
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			if correct == 0 and not lost then
				lost = true
				gonerText("VERY DISAPPOINTING...")
				gonerText("YOU GOT EVERY\nSINGLE ONE WRONG.")
				gonerText("HOW?")
				gonerText("...")
				gonerText("LET US GO THROUGH\nTHE REST.")
			end
			
			gonerText("QUESTION FIVE.")
			gonerText("YOU MAY RECALL\nTHAT A DOTTED\nNOTE IS WORTH\nONE AND A HALF\nOF ITS BEATS.")
			gonerText("SAY THE QUARTER\nNOTE GETS THE BEAT.")
			gonerText("HOW MANY BEATS\nARE IN A DOTTED\nHALF NOTE?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(1)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "3" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS 3.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS 3.")
			end
			
			if correct == 2 and not warned then
				warned = true
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			if correct == 1 and not lost then
				lost = true
				gonerText("VERY DISAPPOINTING...")
				gonerText("YOU LOST.")
				gonerText("...")
				gonerText("LET US GO THROUGH\nTHE REST.")
			end
			
			gonerText("QUESTION SIX.")
			gonerText("HOW MANY FLATS\nARE IN A FLAT\nMAJOR?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(1)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "4" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS 4.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS 4.")
			end
			gonerText("B FLAT,[wait:20]\nE FLAT,[wait:20]\nA FLAT,[wait:20]\nD FLAT.")
			
			if correct == 3 and not warned then
				warned = true
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			if correct == 2 and not lost then
				lost = true
				gonerText("VERY DISAPPOINTING...")
				gonerText("YOU LOST.")
				gonerText("...")
				gonerText("LET US GO THROUGH\nTHE REST.")
			end
			
			gonerText("QUESTION SEVEN.")
			gonerText("TRUE OR FALSE?\nTHE WORDS TO A\nSONG ARE CALLED\nVERSES.")
			
			input = cutscene:choicer({"True", "False"})
			
			if input == 2 then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS FALSE.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			gonerText("THE WORDS TO A\nSONG ARE CALLED\nLYRICS.")
			
			if correct == 4 and not warned then
				warned = true
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			if correct == 3 and not lost then
				lost = true
				gonerText("VERY DISAPPOINTING...")
				gonerText("YOU LOST.")
				gonerText("...")
				gonerText("LET US GO THROUGH\nTHE REST.")
			end
			
			gonerText("QUESTION EIGHT.")
			gonerText("SAY THE TIME\nSIGNATURE IS 4/8.")
			gonerText("HOW MANY BEATS\nARE IN A DOTTED\nHALF NOTE?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(1)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "6" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS 6.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS 6.")
			end
			gonerText("THE HALF NOTE\nGETS 4 BEATS.")
			
			if correct == 5 and not warned then
				warned = true
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			if correct == 4 and not lost then
				lost = true
				gonerText("VERY DISAPPOINTING...")
				gonerText("YOU LOST.")
				gonerText("...")
				gonerText("LET US GO THROUGH\nTHE REST.")
			end
			
			gonerText("QUESTION NINE.")
			gonerText("TELL ME THE\nMUSICAL\nALPHABET IN\nORDER.")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(10)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "ABCDEFG" then
				gonerText("EXCELLENT.")
				gonerText("YES,[wait:20] THE ANSWER\nWAS ABCDEFG.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
				gonerText("NO,[wait:20] THE ANSWER\nWAS ABCDEFG.")
			end
			
			if correct == 6 and not warned then
				warned = true
				gonerText("YOU ARE ON\nYOUR LAST LIFE.")
			end
			
			if correct == 5 and not lost then
				lost = true
				gonerText("VERY DISAPPOINTING...")
				gonerText("YOU LOST.")
				gonerText("...")
				gonerText("LET US GO THROUGH\nTHE LAST ONE.")
			end
			
			gonerText("FINAL QUESTION.")
			gonerText("WHAT VOICE\nRANGE ARE\nYOU IN?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(10)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "BASS" then
				gonerText("EXCELLENT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			
			gonerText("SO...[wait:20]\nHOW DID YOU\nDO?")
			gonerText("...")
			if correct == 0 then
				gonerText("YOU GOT NOTHING\nRIGHT.")
				gonerText("YOU FUCKING\nIDIOT.")
				gonerText("WAS ALL THAT TIME\nIN YOUR CHOIR\nFOR NAUGHT!?")
				Kristal.callEvent("completeAchievement", "music")
			elseif correct == 10 then
				gonerText("A PERFECT\nSCORE.")
				gonerText("I EXPECTED\nNOTHING LESS\nFROM YOU.")
				gonerText("YOUR BONUS\nAWAITS.")
				Game:setFlag("acj_music_bonus", true)
				Game:setFlag("acj_music_win", true)
			elseif correct >= 7 then
				gonerText(correct .. " OUT OF 10.")
				gonerText("CONGRATULATIONS!")
				gonerText("YOU FINISHED THE\nMUSIC TRIAL!")
				gonerText("YOUR [color:red]KEY[color:white] AWAITS.")
				Game:setFlag("acj_music_win", true)
			else
				gonerText(correct .. " OUT OF 10.")
				gonerText("UNFORTUNATELY,\nYOU DID NOT\nPASS THIS TRIAL.")
			end
			
			Game.stage.timer:tween(1, fade_rect, {alpha = 0}, "linear")
			cutscene:wait(1)
			
			if Game:getFlag("acj_music_win") then
				local layer = Game.world.map:getTileLayer("door_layer")
				layer.visible = false
				local shape = Game.world.map:getHitbox("door_collision")
				shape.collidable = false
			else
				if correct == 0 then
					cutscene:showNametag("Dess")
					cutscene:text("* ", "wtf", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* I don't want to talk about it.", "shaded_frown", "jamm")
				else
					cutscene:showNametag("Dess")
					cutscene:text("* welp, we're stuck now", "neutral", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* Oh, don't worry!\n* These things have short-term memory!", "side_smile", "jamm")
					cutscene:text("* We can try again whenever.", "side_smile", "jamm")
				end
			end
		end
		cutscene:hideNametag()
    end,
    game = function(cutscene, event)
		local text

        local function gonerTextFade(wait)
            local this_text = text
            Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function()
                this_text:remove()
            end)
            if wait ~= false then
                cutscene:wait(1)
            end
        end

        -- FIXME: actually use skippable
        local function gonerText(str, advance, skippable)
            text = DialogueText("[speed:0.5][spacing:6][voice:none]" .. str, 160, 100, 640, 480,
                { auto_size = true })
            text.layer = WORLD_LAYERS["textbox"]
            text.skip_speed = not skippable
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)

            cutscene:wait(function() return not text:isTyping() end)
			cutscene:wait(function() return Input.pressed("confirm") or Input.down("menu") end)
            gonerTextFade(true)
        end
		if Game:getFlag("acj_game_win") then
			cutscene:text("* It appears doing this trial again won't earn you anything else.")
		else
			cutscene:text("* You press the button on the machine...")
			
			local fade_rect = Rectangle(0, 0, Game.world.width, Game.world.height)
			fade_rect:setColor(0, 0, 0)
			fade_rect.alpha = 0
			Game.world:spawnObject(fade_rect, "below_ui")
			
			Game.stage.timer:tween(1, fade_rect, {alpha = 0.5}, "linear")
			
			cutscene:wait(1)
			
			gonerText("GOOD DAY,[wait:20] LUTHANE.")
			gonerText("I AM THE TRIAL OF\nTHE GAME.")
			gonerText("TO PASS,[wait:20] YOU MUST\nGET 5000 POINTS ON\nBALL JUMP.")
			gonerText("WHENEVER YOU'RE\nREADY.")
			
			Game.stage.timer:tween(1, fade_rect, {alpha = 0}, "linear")
			cutscene:wait(1)
			
			cutscene:showNametag("Jamm")
			cutscene:text("* That sounds simple enough.", "smug", "jamm")
			cutscene:hideNametag()
			
			cutscene:wait(cutscene:startMinigame("ball_level_1"))
			
			if not Game:getFlag("acj_game_win") then
				cutscene:showNametag("Dess")
				cutscene:text("* welp, we're stuck now", "neutral", "dess")
				cutscene:showNametag("Jamm")
				cutscene:text("* Oh, don't worry!\n* These things have short-term memory!", "side_smile", "jamm")
				cutscene:text("* We can try again whenever.", "side_smile", "jamm")
			else
				Game.stage.timer:tween(1, fade_rect, {alpha = 0.5}, "linear")
				cutscene:wait(1)
				
				gonerText("CONGRATULATIONS!")
				gonerText("YOU FINISHED THE\nGAME TRIAL!")
				gonerText("YOUR [color:blue]KEY[color:white] AWAITS.")
				
				Game.stage.timer:tween(1, fade_rect, {alpha = 0}, "linear")
				cutscene:wait(1)
				
				cutscene:text("* (Ball Jump has been unlocked in the Darkcade.)")
				
				local layer = Game.world.map:getTileLayer("door_layer")
				layer.visible = false
				local shape = Game.world.map:getHitbox("door_collision")
				shape.collidable = false
			end
			cutscene:hideNametag()
		end
	end,
	observation = function(cutscene, event)
		local text

        local function gonerTextFade(wait)
            local this_text = text
            Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function()
                this_text:remove()
            end)
            if wait ~= false then
                cutscene:wait(1)
            end
        end

        -- FIXME: actually use skippable
        local function gonerText(str, advance, skippable)
            text = DialogueText("[speed:0.5][spacing:6][voice:none]" .. str, 160, 100, 640, 480,
                { auto_size = true })
            text.layer = WORLD_LAYERS["textbox"]
            text.skip_speed = not skippable
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)

            cutscene:wait(function() return not text:isTyping() end)
			cutscene:wait(function() return Input.pressed("confirm") or Input.down("menu") end)
            gonerTextFade(true)
        end
		if Game:getFlag("acj_observation_win") then
			cutscene:text("* It appears doing this trial again won't earn you anything else.")
		else
			local correct = 0
			cutscene:text("* You press the button...")
			
			local fade_rect = Rectangle(0, 0, Game.world.width, Game.world.height)
			fade_rect:setColor(0, 0, 0)
			fade_rect.alpha = 0
			Game.world:spawnObject(fade_rect, "below_ui")
			
			Game.stage.timer:tween(1, fade_rect, {alpha = 0.5}, "linear")
			
			cutscene:wait(1)
			
			gonerText("GOOD DAY,[wait:20] LUTHANE.")
			gonerText("I AM THE TRIAL OF\nOBSERVATION.")
			gonerText("TO PASS,[wait:20] YOU MUST\nANSWER THREE OF MY\nFIVE QUESTIONS.")
			gonerText("WITHOUT FURTHER\nADO...")
			gonerText("QUESTION ONE.")
			gonerText("ON THE SIGN NEXT\nTO THE BUTTON...")
			gonerText("WHAT IS THE CORRECT\nSPELLING OF THE\nMISSPELLED WORD?")
			
			local wbi_ok = false
			local action = nil
			wbi = WarpBinInputMenu(10)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "WILL" then
				gonerText("EXCELLENT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			
			gonerText("QUESTION TWO.")
			gonerText("HOW MANY TALLY MARKS\nARE ON THE WALL\nNEXT TO KING?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(2)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "8" then
				gonerText("EXCELLENT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			
			gonerText("QUESTION THREE.")
			gonerText("HOW MANY CELLS\nARE IN THE\nBASEMENT?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(2)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "2" then
				gonerText("EXCELLENT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			
			gonerText("QUESTION FOUR.")
			gonerText("HOW MANY TRIALS\nHAVE BONUSES?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(1)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "1" then
				gonerText("EXCELLENT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			
			gonerText("FINAL QUESTION.")
			gonerText("HOW MANY TALLY MARKS\nARE IN THE\nBASEMENT?")
			
			wbi_ok = false
			action = nil
			wbi = WarpBinInputMenu(2)
			wbi.finish_cb = function(_action, input)
				wbi_ok = true
				action = input
			end
			Game.world:spawnObject(wbi, "ui")
			cutscene:wait(function() return wbi_ok end)
			
			if string.upper(action) == "3" then
				gonerText("EXCELLENT.")
				correct = correct + 1
			else
				gonerText("INCORRECT.")
			end
			
			gonerText("SO...[wait:20]\nHOW DID YOU\nDO?")
			gonerText("...")
			if correct >= 3 then
				gonerText(correct .. " OUT OF 5.")
				gonerText("CONGRATULATIONS!")
				gonerText("YOU FINISHED THE\nOBSERVATION TRIAL!")
				gonerText("YOUR [color:purple]KEY[color:white] AWAITS.")
				Game:setFlag("acj_observation_win", true)
			else
				gonerText(correct .. " OUT OF 5.")
				gonerText("UNFORTUNATELY,\nYOU DID NOT\nPASS THIS TRIAL.")
			end
			
			Game.stage.timer:tween(1, fade_rect, {alpha = 0}, "linear")
			cutscene:wait(1)
			
			if Game:getFlag("acj_observation_win") then
				local layer = Game.world.map:getTileLayer("door_layer")
				layer.visible = false
				local shape = Game.world.map:getHitbox("door_collision")
				shape.collidable = false
			else
				cutscene:showNametag("Dess")
				cutscene:text("* welp, we're stuck now", "neutral", "dess")
				cutscene:showNametag("Jamm")
				cutscene:text("* Oh, don't worry!\n* These things have short-term memory!", "side_smile", "jamm")
				cutscene:text("* We can try again whenever.", "side_smile", "jamm")
			end
		end
		cutscene:hideNametag()
	end,
    hallway_1 = function(cutscene, event)
		cutscene:showNametag("Dess")
		cutscene:text("* So,[wait:5] your wife made this dungeon for you?", "eyebrow", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* Yeah.[wait:5]\n* She must've spent a lot of time on this.", "neutral", "jamm")
		cutscene:showNametag("Dess")
		cutscene:text("* How much time?", "eyebrow", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* I...[wait:5] Don't know.", "neutral", "jamm")
		cutscene:hideNametag()
    end,
    hallway_2 = function(cutscene, event)
		cutscene:showNametag("Dess")
		cutscene:text("* because clearly it's our dungeon,[wait:5] not yours lol", "condescending", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* Don't you start with--", "determined", "jamm", {auto = true})
		cutscene:showNametag("Dess")
		cutscene:text("* No,[wait:5] hear me out.", "neutral", "dess")
		cutscene:text("* That door only opened when we were BOTH at it,[wait:5] right?", "neutral", "dess")
		cutscene:text("* So clearly,[wait:5] it's both of ours.", "wink", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* I...[wait:5]\n* Never thought about it that way.", "nervous", "jamm")
		cutscene:text("* Why DID it only open with us both?", "nervous", "jamm")
		cutscene:hideNametag()
    end,
    hallway_3 = function(cutscene, event)
		cutscene:showNametag("Dess")
		cutscene:text("* so where's the fakeout", "condescending", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* What?", "neutral", "jamm")
		cutscene:showNametag("Dess")
		cutscene:text("* it's a dungeon,[wait:5] there's always a fakeout", "wink", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* No???[wait:5]\n* That's extremely rare???", "neutral", "jamm")
		cutscene:hideNametag()
    end,
    boss = function(cutscene, event)
		cutscene:wait(cutscene:mapTransition("fwood/dungeon_inside/boss", "jamm_spawn", "right"))
		local jamm = cutscene:getCharacter("jamm")
		local dess = cutscene:getCharacter("dess")
		local sa = cutscene:getCharacter("shade_ania")
		cutscene:detachFollowers()
		dess.x = -80
		dess.y = 320
		cutscene:walkToSpeed("jamm", 200, 200, 4)
		cutscene:wait(cutscene:walkToSpeed("dess", 160, 320, 4))
		cutscene:showNametag("Dess")
		cutscene:text("* hey what that", "eyebrow", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* I think that's the master key Ania wrote about...", "look_left", "jamm")
		cutscene:showNametag("Dess")
		cutscene:text("* then go get it.", "neutral", "dess")
		cutscene:text("* I want to get out of here.", "annoyed", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* As fun as this was,[wait:5] I think I agree.", "stern", "jamm")
		cutscene:hideNametag()
		cutscene:wait(cutscene:slideTo(sa, 480, 240, 0.5))
		Assets.playSound("impact")
		cutscene:shakeCharacter(sa, 2, 0)
		cutscene:setSprite("jamm", "battle/hurt_1")
		Game.world.music:play("jamm_boss", 1, 1)
		cutscene:wait(1)
		cutscene:showNametag("Jamm")
		cutscene:text("* A-Ania!?", "shaded_pissed", "jamm")
		cutscene:showNametag("Dess")
		cutscene:text("* Jamm,[wait:5] snap out of it![wait:5]\n* That's not Ania!", "neutral", "dess")
		cutscene:text("* ...", "neutral_c", "dess")
		cutscene:text("* alright,[wait:5] let's do this lmao", "challenging", "dess")
		cutscene:hideNametag()
		
		cutscene:startEncounter("ania_boss", true, sa)
		
		sa:remove()
		Game.world.music:stop()
		cutscene:shakeCharacter(jamm, 2, 0)
		cutscene:wait(1)
		cutscene:shakeCharacter(jamm, 2, 0)
		cutscene:resetSprites()
		cutscene:wait(1)
		cutscene:look(dess, "up")
		cutscene:showNametag("Dess")
		cutscene:text("* you okay,[wait:5] bro?", "genuine", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* ...", "shaded_neutral", "jamm")
		cutscene:text("* ...I'm fine.", "shaded_neutral", "jamm")
		cutscene:showNametag("Dess")
		cutscene:text("* you sure?", "genuine", "dess")
		cutscene:showNametag("Jamm")
		cutscene:text("* Just give me a moment,[wait:5] okay?", "neutral", "jamm")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed("jamm", 360, 140, 4, "up"))
		cutscene:look(dess, "right")
		cutscene:showNametag("Jamm")
		cutscene:text('* "My dearest Luthane..."', "neutral", "jamm")
		cutscene:text('* "I was with you throughout the dungeon."', "neutral", "jamm")
		cutscene:text('* "In life or death."', "neutral", "jamm")
		cutscene:text('* "And I will always be by your side."', "neutral", "jamm")
		cutscene:text('* "\'Til death do us part?[wait:5]\nNot really my style."', "neutral", "jamm")
		cutscene:text('* "But what about past that?"', "neutral", "jamm")
		cutscene:text('* "I will always be with you,[wait:5] Luthane."', "neutral", "jamm")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed("dess", 540, 280, 4))
		cutscene:showNametag("Jamm")
		cutscene:text('* "I also included a dear possession of mine with the key."', "neutral", "jamm")
		cutscene:text('* "Keep it with you at all times."', "neutral", "jamm")
		cutscene:text('* ...I will,[wait:5] Ania.', "neutral", "jamm")
		Game.world.map:getEvent(2):remove()
		Game.inventory:addItem("flowerbrace")
		cutscene:look(dess, "left")
		cutscene:showNametag("Dess")
		cutscene:text("* i got the stuff,[wait:5] let's bolt", "neutral", "dess")
		cutscene:hideNametag()
		Game:setFlag("jamm_closure", true)
		cutscene:wait(cutscene:mapTransition("fwood/entry", "exit", "down"))
		Kristal.callEvent("completeQuest", "acj2")
        Game:getPartyMember("jamm").has_act = false
        Game:setFlag("jamm_canact", false)
    end,
}
