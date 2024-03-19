return {
    sign = function(cutscene, event)
        cutscene:text("* The sign reads:")
        cutscene:text("* Welcome to the 1 Year Deoxynn map!")
        cutscene:text("* This map was made to celebrate one year of Deoxynn Kristal releasing.")
        cutscene:text("* At the time of reading this,[wait:5] I am currently working on Deoxynn...")
        cutscene:text("* And the REAL one,[wait:5] this time.")
        cutscene:text("* Happy first birthday,[wait:5] Deoxynn!")
        cutscene:text("* - AcousticJamm")
    end,
	
    pk = function(cutscene, event)
		cutscene:showNametag("PK")
		cutscene:text("* So wait,[wait:5] Deoxynn is a year old at this point?", nil, "pk")
		cutscene:text("* That's...[wait:5] Pretty awesome,[wait:5] actually.", nil, "pk")
		cutscene:text("* I'm excited to see what will happen in the canon game...", nil, "pk")
		cutscene:text("* That is,[wait:5] even though I'm not going to be in it.", nil, "pk")
		cutscene:text("* Oh well.[wait:5] I knew this was coming anyways.", nil, "pk")
		cutscene:hideNametag()
	end,
	
    katy = function(cutscene, event)
		cutscene:showNametag("Kaity")
		cutscene:text("* I've seen the art for the new game so far,[wait:5] and I've gotta say...", "smile_low", "katy")
		cutscene:text("* It's quite the improvement over what we currently have!", "happy", "katy")
		cutscene:text("* Too bad the director won't let me show it here...", "frown", "katy")
		cutscene:text("* But instead,[wait:5] how about a fun fact?", "smile_low", "katy")
		cutscene:text("* My voice blip is from the first copypasta rap.", "smile_low", "katy")
		cutscene:text("* To you who know,[wait:5] good luck getting that out of your head.", "happy", "katy")
		cutscene:hideNametag()
	end,
}