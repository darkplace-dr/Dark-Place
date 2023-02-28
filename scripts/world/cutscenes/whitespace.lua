return {
	mewo = function(cutscene, event)
        Assets.playSound("mewo", 2, 1)
		cutscene:showNametag("MEWO")
		cutscene:text("* Meow?[wait:10] (Waiting for something to happen?)")
		cutscene:hideNametag()
	end
}