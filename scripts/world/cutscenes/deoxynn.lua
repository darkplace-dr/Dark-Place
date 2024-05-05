return {
    bonus1 = function(cutscene, event, number, teacher)
		cutscene:text("* Huh?[wait:5]\n* An ant crawled out of the box and gave you something...")
		cutscene:text("* Oh![wait:5] It's an [color:yellow]Aid Kit[color:white]!")
		success, result_text = Game.inventory:tryGiveItem("ut_items/monster_candy") -- Placeholder
		cutscene:text(result_text)
	end,
}