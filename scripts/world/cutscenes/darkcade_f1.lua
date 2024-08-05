return {

    table_1 = function(cutscene)
		local susie = cutscene:getCharacter("susie")
		local brenda = cutscene:getCharacter("brenda")
		local jamm = cutscene:getCharacter("jamm")
		local dess = cutscene:getCharacter("dess")
		
		if susie then
			cutscene:showNametag("Susie")
			cutscene:text("[voice:susie]* So, uh...", "nervous", "susie")
			cutscene:text("[voice:susie]* Can anyone tell the difference between the condiments?", "nervous_side", "susie")
			
			if dess then
				cutscene:showNametag("Dess")
				cutscene:text("* it's all mayo", "neutral", "dess")
				
				cutscene:showNametag("Susie")
				cutscene:text("[voice:susie]* Wait, really?\n* How can you tell?", "surprise_smile", "susie")
				
				cutscene:showNametag("Dess")
				cutscene:text("* the coulors are different lmao", "condescending", "dess")
				
				if brenda then
					cutscene:showNametag("Susie")
					cutscene:text("[voice:susie]* They're the same color![react:1]", "annoyed", "susie", {reactions = { 
						{"Also that's not\nwhere the \"u\"\ngoes?", 372, 50, "frown_side", "brenda"}
					}})
				else
					cutscene:showNametag("Susie")
					cutscene:text("[voice:susie]* They're the same color!", "annoyed", "susie")
				end
				
				if jamm then
					cutscene:showNametag("Jamm")
					cutscene:text("* They're...\n* They're clearly labeled 'ketchup'???", "stern", "jamm")
				end
			end
			cutscene:hideNametag()
		else
			cutscene:text("* The table looks brand new, yet the condiments are old.")
			if jamm and Game:getFlag("marcy_joined") then
				cutscene:showNametag("Marcy")
				cutscene:text("* Marcy doesn't like old condiments...", "frown", "marcy")
				
				cutscene:showNametag("Jamm")
				cutscene:text("* I mean,[wait:5] it's not like there's anything worth it here...", "nervous_left", "jamm")
				cutscene:text("* You won't have to worry about it,[wait:5] Marcy.", "smile_side", "jamm")
			end
		end
    end,

}