return {
	jail = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local brenda = cutscene:getCharacter("brenda")
        local jamm = cutscene:getCharacter("jamm")
        if not Game:getFlag("cssusie_quest") then

            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* Man,[wait:5] this place feels so familiar...", "neutral_side", "susie")
                cutscene:text("* Hey,[wait:5] why the hell is there a giant wall of fire?", "nervous_side", "susie")
            end

            cutscene:showNametag("???")
            cutscene:text("[voice:cssusie]* HEH,[wait:5] IS SOMEONE AT THE DOOR?", "", nil)
            cutscene:text("[voice:cssusie]* IT'S BEEN TOO DAMN LONG SINCE SOMEONE LAST VISITED.", "", nil)
            cutscene:text("[voice:cssusie]* AM I FINALLY GONNA ROLL SOME HEADS AGAIN?", "", nil)

            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* Hey...[wait:5] wait a minute...", "neutral_side", "susie")
                cutscene:text("* WHY THE HELL DO YOU SOUND ALMOST EXACTLY LIKE ME?!", "teeth_b", "susie")

                cutscene:showNametag("???")
                cutscene:text("[voice:cssusie]* EH,[wait:5] DOESN'T MATTER TO ME.", "", nil)
                cutscene:text("[voice:cssusie]* AFTER ALL,[wait:5] THIS IS ALL JUST A GAME.", "", nil)

                cutscene:showNametag("Susie")
                cutscene:text("* Okay then...", "suspicious", "susie")
                cutscene:text("* I'm assuming you wanna be let out of your prison?", "sus_nervous", "susie")

                cutscene:showNametag("???")
                cutscene:text("[voice:cssusie]* PRISON?[wait:10]\n* THE HELL YOU TALKING ABOUT?", "", nil)

                cutscene:showNametag("Susie")
                cutscene:text("* There's a giant wall of fire,[wait:5] you're stuck in there.", "suspicious", "susie")

                cutscene:showNametag("???")
                cutscene:text("[voice:cssusie]* NAH,[wait:5] I'M THE FREEST I'VE EVER BEEN.", "", nil)
                cutscene:text("[voice:cssusie]* YOU'RE THE ONES WHO ARE TRAPPED.", "", nil)

                cutscene:showNametag("Susie")
                cutscene:text("* ... Whatever...", "sus_nervous", "susie")

                cutscene:showNametag("???")
            end

            cutscene:text("[voice:cssusie]* HEY,[wait:5] I'VE GOT SOMETHING REALLY COOL TO SHOW YOU.", "", nil)
            cutscene:text("[voice:cssusie]* THERE ARE THREE PIECES OF A KEY TO FIND.", "", nil)
			
			if cutscene:getCharacter("jamm") and not Game:getFlag("dungeonkiller") then
				cutscene:showNametag("Jamm")
				cutscene:text("* A secret boss with a fetch quest.\n* Sounds about right.", "neutral", "jamm")

                cutscene:showNametag("???")
			end
			
            cutscene:text("[voice:cssusie]* ASSEMBLE THEM AND BRING IT BACK HERE.", "", nil)
            cutscene:text("[voice:cssusie]* THEN YOU WILL ALL BE TRULY FREE.", "", nil)

            if dess then
                cutscene:showNametag("Dess")
                cutscene:text("* sounds poggers to me", "kind", "dess")
                cutscene:text("* I see no possible way this backfires on us", "condescending", "dess")
                cutscene:text("* now uhhhhh where are the pieces in question?", "calm", "dess")

                cutscene:showNametag("???")
            end

            cutscene:text("[voice:cssusie]* HELL IF I KNOW WHERE THEY ARE.", "", nil)

            if brenda then
                cutscene:showNametag("Brenda")
                cutscene:text("* Well that's just great.", "miffed", "brenda")
                cutscene:text("* C'mon guys,[wait:5] let's go find those key pieces.", "neutral", "brenda")
            end

            cutscene:hideNametag()
            Assets.playSound("creepyjingle")
        
            Kristal.callEvent("createQuest", "Mysterious Prisoner", "cssusie", "There's a giant wall of fire in a mysterious room that has someone inside it. The person inside mentioned something about finding three parts to a key that'll open it. Where exactly could those parts be?", 3)
			Game:setFlag("cssusie_quest", true)
        else
            if not Game:getFlag("placeholder, it's gonna be an item check for a key when I fully implement this") then
                cutscene:showNametag("???")
                cutscene:text("[voice:cssusie]* HEY,[wait:5] HERE'S SOME HINTS IF YOU IDIOTS NEED 'EM.", "", nil)
                cutscene:text("[voice:cssusie]* THEY'RE NOT IN THIS ROOM.", "", nil)

                if susie then
                    cutscene:showNametag("Susie")
                    cutscene:text("* ...", "neutral", "susie")
                    cutscene:text("* Wow,[wait:5] real helpful there.", "annoyed", "susie")

                    if dess then
                        cutscene:showNametag("Dess")
                        cutscene:text("* Yeah that helped a lot,[wait:5] thanks /srs", "kind", "dess")

                        cutscene:showNametag("Susie")
                        cutscene:text("* ...", "neutral_side", "susie")
                        cutscene:text("* Did you just say \"Slash ess are ess\"?", "suspicious", "susie")

                        cutscene:showNametag("Dess")
                        cutscene:text("* yeah because I didn't wanna seem like I was being rude", "genuine", "dess")
                        cutscene:text("* I wanna make sure they know I'm being genuine", "genuine_b", "dess")

                        cutscene:showNametag("Susie")
                        cutscene:text("* ... You know what?", "suspicious", "susie")
                        cutscene:text("* I'm just gonna not question you on that.", "sus_nervous", "susie")
                    end
                end

                cutscene:hideNametag()
            else
                --Insert door opening cutscene here
            end
        end
	end
}
