return {
    bonus1 = function(cutscene, event, number, teacher)
		cutscene:text("* Huh?[wait:5]\n* An ant crawled out of the box and gave you something...")
		cutscene:text("* Oh![wait:5] It's an [color:yellow]Aid Kit[color:white]!")
		success, result_text = Game.inventory:tryGiveItem("ut_items/monster_candy") -- Placeholder
		cutscene:text(result_text)
	end,

	lake_1 = function(cutscene)
		cutscene:text("* It's a lake.[wait:5]\n* There are plenty of fish here.")
	end,

	relation = function(cutscene, event)
		cutscene:text("* Whoever BT and JX are must be happy together.")
	end,

	sign1 = function(cutscene, event)
		if Game.world.player.facing == "up" then
			cutscene:text("* West:[wait:5] Shop[wait:5]\n* East:[wait:5] Puzzles")
		end
	end,
}