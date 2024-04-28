return {
    test = function(cutscene, actor)
        local master = cutscene:getCharacter("test_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm test Master.\n[wait:5]* Ask me about TEST's.")

        local choices = {"1", "2", "3"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING ONE.")
        elseif c == 2 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING TWO.")
        elseif c == 3 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING THREE.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,
    kris = function(cutscene)
        local master = cutscene:getCharacter("kris_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Kris Master.\n[wait:5]* Ask me about KRIS's.")

        local choices = {"Reviving", "Acting", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            cutscene:text("* When HP goes negative,[wait:5] your friends fall down")
            cutscene:text("* But bringing them back,[wait:5] is easy town")
            cutscene:text("* Plain foods and spells,[wait:5] work like a charm -")
            cutscene:text("* And with a MINT,[wait:5] you can cure all HARM.")
        elseif c == 2 then
            cutscene:text("* If you only ACT,[wait:5] you might start to think -")
            cutscene:text("* What about the guy with the scarf in pink?")
            cutscene:text("* They are the one to keep things FAIR.")
            cutscene:text("* So end this battle with a second SPARE.")
        elseif c == 3 then
            cutscene:text("* It's a good idea,[wait:5] to give us BUCKs.")
            cutscene:text("* It'll make Kris happy,[wait:5] and fill them with LUCKs.")
            cutscene:text("* Over there,[wait:5] is our DONATION HOLE.")
            cutscene:text("* We had a BOX,[wait:5] but it got STOLE.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,
    susie = function(cutscene)
        local master = cutscene:getCharacter("susie_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Susie Master.\n[wait:5]* Ask me about SUSIE's.")

        local choices = {"Healing", "Attack", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            cutscene:text("* Susie puts all her POWER,[wait:5] in this one SPELL.")
            cutscene:text("* This will send your TENSION,[wait:5] straight to HELL.")
            cutscene:text("* Susie's ULTIMATE HEAL,[wait:5] is so RAD.")
            cutscene:text("* Unfortunely it's also,[wait:5] very[wait:5] very[wait:5] BAD.")
        elseif c == 2 then
            cutscene:text("* Susie's BUSTER, RUDE as may be...")
            cutscene:text("* Will deal more damage, if you just press [Z]!")
        elseif c == 3 then
            cutscene:text("* I now can see Susie's eye.")
            cutscene:text("* Which means she's learned PACIFY.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,
    YOU = function(cutscene)
        local master = cutscene:getCharacter("YOU_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm You Master.\n[wait:5]* Ask me about YOU's.")

        local choices = {"Ribbit", "Sending", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            cutscene:text("* You's eyes,[wait:5] are quite the SHOW.")
            cutscene:text("* In dark rooms,[wait:5] they even GLOW.")
            cutscene:text("* Their origins however,[wait:5] are very unclear.")
            cutscene:text("* Press [A] to CROAK.")
            cutscene:text("[speed:0.5]*\n                :D  ")
        elseif c == 2 then
            cutscene:text("* You's SEND,[wait:5] is quite strange.")
            cutscene:text("* What it replaces doesn't change.")
            cutscene:text("* It's just another way to SPARE.")
            cutscene:text("* All of the options are still THERE.")
        elseif c == 3 then
            cutscene:text("* You loves to give us DOLLARS.")
            cutscene:text("* They'll[speed:0.1]...")
            cutscene:text("* [wait:8][speed:0.5]Uhh...")
            cutscene:text("* [speed:0.7][wait:5]Destroy,[wait:8][speed:0.5] scam,[wait:10] [speed:0.3]CALLERS?")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,
    dess = function(cutscene)
        local master = cutscene:getCharacter("dess_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Dess Master.\n[wait:5]* Don't ask me about DESS's.")

        local choices = {"Stars", "2", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            --cutscene:text("* BING BING BING ONE.")
	    if Game:getFlag("sorry_dess") then
                cutscene:text("* Last I checked STAR isn't an actual type...")
                cutscene:text("* But my thing says your type is STAR so...[wait:5] screw it.")
                cutscene:text("* You are a BALL of FIRE Dess.\n[wait:5]* A giant ball OF fire.")
                cutscene:text("* I think that's what that means anyWAY.")
                if Game:getFlag("dungeonkiller") then
                    cutscene:text("* That phone over there is[wait:5] odd...")
                    cutscene:text("* They keep saying things that don't make sense.")
                    cutscene:text("* (Sometimes I feel like I'm the only one who can see them.)")
                    cutscene:text("* (I still have no idea who "..Game.save.name.." is and what they have to do with you Dess...)")
                end
            else
                cutscene:text("* Dess's power of the STARS.")
                cutscene:text("* Will[wait:5] HOPEFULLY[wait:5] get her run over by CARS.")
                cutscene:text("*[speed:0.3] ...")
                cutscene:text("*[speed:0.3] ...")
                cutscene:text("* Great,\n[wait:5]now I feel like a piece of sh[wait:5]-tupid[speed:0.3]...")
                cutscene:text("* Sorry for being mean...[wait:5]  There's no excuse for my actions...[wait:5] I'll try being nicer from now on.")
                Game:setFlag("sorry_dess", "1")
                if Game:getFlag("dungeonkiller") then
                    cutscene:text("* Someone told me someone else made some other person do something.")
                    cutscene:text("* Say...[wait:5] any of you know of a "..Game.save.name.."?")
                end
            end
                -- this feels too mean to actually put into the game  UPDATE:(OKAY, this SHOULD be better.)
        elseif c == 2 then
            cutscene:text("* BING BING BING TWO.")
        elseif c == 3 then
            cutscene:text("* Dess will stop being annoying,[wait:5] if you give me money to buy cigarettes.")
            cutscene:text("* Sorry,[wait:5] that was a lie.")
            cutscene:text("* Give me money,[wait:5] to buy cigarettes.")
	    if Game:getFlag("sorry_dess") then
                cutscene:text("* Sorry for calling you annoying by the way.")
            end
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] Chum.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

    berdly = function(cutscene, actor)
        local master = cutscene:getCharacter("berdly_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Berdly Master.\n[wait:5]* Ask me about BERDLY's.")

        local choices = {"1", "2", "3"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING ONE.")
        elseif c == 2 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING TWO.")
        elseif c == 3 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING THREE.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

    brenda = function(cutscene, actor)
        local master = cutscene:getCharacter("brenda_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Brenda Master.\n[wait:5]* Ask me about BREANDA's.")

        local choices = {"1", "2", "3"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING ONE.")
        elseif c == 2 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING TWO.")
        elseif c == 3 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING THREE.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

    jamm = function(cutscene, actor)
        local master = cutscene:getCharacter("jamm_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Jamm Master.\n[wait:5]* Ask me about JAMM's.")

        local choices = {"Healing", "Dark", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            cutscene:text("* Jamm's HealSling [wait:5]does a cool thing,[wait:5] you'll see...")
            cutscene:text("* It heals the opponent and increases their MERCY.")
            cutscene:text("* But cast it after the foe's been hit...")
            cutscene:text("* And it'll raise it further,[wait:5] even if by a bit!")
			if Game:getFlag("dungeonkiller") then
				cutscene:text("* But too bad,[wait:5] kid,[wait:5] you missed your chance.")
				cutscene:text("* Jamm lost this skill,[wait:5] it's if it were a trance.")
			end
        elseif c == 2 then
            cutscene:text("* Jamm's DarkSling [wait:5]is pretty tricky to cast.")
            cutscene:text("* When he's calm,[wait:5] the problem's in the past.")
            cutscene:text("* But say he's against someone strong,[wait:5] like a BOSS...")
            cutscene:text("* His spell won't do well,[wait:5] consider it a loss.")
        elseif c == 3 then
            cutscene:text("* Jamm loves it when you give us your cash...")
			if Game:getFlag("dungeonkiller") then
				cutscene:text("* He'll show you a smile and twirl his mustache.")
				cutscene:showNametag("Jamm")
				cutscene:text("* I think I lost the ability to smile earlier.", "shaded_pissed", "jamm")
				cutscene:text("* Also,[wait:5] I don't have a mustache in Dark Place.", "shaded_neutral", "jamm")
				cutscene:hideNametag()
			else
				cutscene:showNametag("Jamm")
				cutscene:text("* If you continue this,[wait:5] I'm calling my lawyer.", "stern", "jamm")
				cutscene:hideNametag()
				master:setAnimation({"shocked", 0.25, true})
				cutscene:text("* NO![wait:5] PLEASE![wait:5]\n* JUST GIVE ME A PASS!")
			end
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

    mario = function(cutscene, actor)
        local master = cutscene:getCharacter("mario_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm-a Mario Master.\n[wait:5]* Ask me about-a MARIO's.")

        local choices = {"Hammer", "World", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            cutscene:text("* Mario's hammer [wait:5] is his weapon to thump.")
            cutscene:text("* Since in top-down 2D,[wait:5] you can't really jump.")
            cutscene:text("* In Alpha Dream's games,[wait:5] he's a hammer king.")
            cutscene:text("* So don't be on the wrong side of his swing!")
        elseif c == 2 then
            cutscene:text("* Mario comes from another domestication...")
            cutscene:text("* But even then, there were some altercations.")
            cutscene:text("* He comes from SMG4,[wait:5] but with some accomodations...")
            cutscene:text("* The brand new tales,[wait:5] but same foundation.")
        elseif c == 3 then
            cutscene:text("* Mario loves it when you give us your money...")
            cutscene:text("* For that means he gets lotsa spaghetti!")
			cutscene:showNametag("Mario")
			cutscene:text("* Oooooohhh...!", "main", "mario")
			cutscene:showShop()
			if Game.money < 200 then
				cutscene:text("* But Mario doesn't have much-a money...", "main", "mario")
			else
				cutscene:text("* Mario has lotsa money!", "main", "mario")
				cutscene:hideNametag()
				cutscene:text("* (Buy spaghetti for D$200?)")
				if cutscene:choicer({"Yes", "No"}) == 1 then
					if Game.inventory:addItem("spaghetti") then
						Game.money = Game.money - 200
						cutscene:showNametag("Mario")
						cutscene:text("* That's-a so nice!", "main", "mario")
					else
						cutscene:showNametag("Mario")
						cutscene:text("* Oh,[wait:5] no![wait:5] No room!", "main", "mario")
					end
				else
					cutscene:showNametag("Mario")
					cutscene:text("* Oh,[wait:5] mamaf**ker!", "main", "mario")
				end
			end
			cutscene:hideNametag()
			cutscene:hideShop()
        elseif c == 4 then
            cutscene:text("* Buh-Bye!")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

    ceroba = function(cutscene, actor)
        local master = cutscene:getCharacter("ceroba_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Ceroba Master.\n[wait:5]* Ask me about CEROBA's.")

        local choices = {"1", "2", "Fact"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING ONE.")
        elseif c == 2 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING TWO.")
        elseif c == 3 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* Ceroba hearts to give funds.")
            cutscene:text("* Make feel very hearts rotund?")

            cutscene:showNametag("Ceroba")
            cutscene:text("*[speed:0.3] ...", "wat", "ceroba")
            cutscene:text("* What are you even saying???", "suprised", "ceroba")
            cutscene:hideNametag()

            cutscene:text("* I don't know, help me.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

    pauling = function(cutscene, actor)
        local master = cutscene:getCharacter("pauling_master")
        master:setAnimation({"bop", 0.25, true})
        cutscene:text("* I'm Pauling Master.\n[wait:5]* Ask me about PAULING's.")

        local choices = {"1", "2", "3"}
        table.insert(choices, "Bye")
        local c = cutscene:choicer(choices)
        if c == 1 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING ONE.")
        elseif c == 2 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING TWO.")
        elseif c == 3 then
            master:setAnimation({"shocked", 0.25, true})
            cutscene:text("* BING BING BING THREE.")
        elseif c == 4 then
            cutscene:text("* Later,[wait:5] kid.")
        end
        master:setAnimation({"idle", 0.25, true})
    end,

}
