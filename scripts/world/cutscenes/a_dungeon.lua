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
    lock1 = function(cutscene, event)
		if Game:getFlag("acj_key1") then
			cutscene:text("* Unlock the door with your [color:green]key[color:white]?")
			local choice = cutscene:choicer({"Yes", "No"})
			if choice == 1 then
				cutscene:text("* You unlock the lock...")
				Assets.playSound("dooropen")
				cutscene:mapTransition("fwood/dungeon_inside/floor2_main", "f1", "down")
			else
				cutscene:text("* You unlock the lock...")
			end
		else
			cutscene:text("* You don't have a [color:green]key[color:white] that fits this lock.")
		end
		cutscene:hideNametag()
    end,
}
