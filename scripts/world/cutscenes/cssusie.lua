return {
	jail = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")
        local brandon = cutscene:getCharacter("brandon")
        if susie then
            cutscene:showNametag("Susie")
            cutscene:text("* Man,[wait:5] this place feels so familiar...", "neutral_side", "susie")
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
            cutscene:text("* This door is literally locked,[wait:5] you're stuck in there.", "suspicious", "susie")
            cutscene:showNametag("???")
            cutscene:text("[voice:cssusie]* NAH,[wait:5] I'M THE FREEST I'VE EVER BEEN.", "", nil)
            cutscene:text("[voice:cssusie]* YOU'RE THE ONES WHO ARE TRAPPED.", "", nil)
            cutscene:showNametag("Susie")
            cutscene:text("* ... Whatever...", "sus_nervous", "susie")
            cutscene:showNametag("???")
        end
        cutscene:text("[voice:cssusie]* HEY,[wait:5] I'VE GOT SOMETHING REALLY COOL TO SHOW YOU.", "", nil)
        cutscene:text("[voice:cssusie]* HOW ABOUT YOU GO FIND THE KEY TO FREE YOURSELVES?", "", nil)
        if dess then
            cutscene:showNametag("Dess")
            cutscene:text("* sounds poggers to me", "kind", "dess")
            cutscene:text("* I see no possible way this backfires on us", "condescending", "dess")
            cutscene:text("* now uhhhhh where is the key in question?", "calm", "dess")
            cutscene:showNametag("???")
        end
        cutscene:text("[voice:cssusie]* HELL IF I KNOW WHERE IT IS.", "", nil)
        if brandon then
            cutscene:showNametag("Brandon")
            cutscene:text("* Well that's just great.", "miffed", "brandon")
            cutscene:text("* C'mon guys,[wait:5] let's go find that key.", "neutral", "brandon")
        end
        Assets.playSound("creepyjingle")
        cutscene:hideNametag()
	end
}
