return {
    mewo = function(cutscene, event)
        Assets.playSound("mewo", 2, 1)
        cutscene:showNametag("MEWO")
        cutscene:text("* Meow?[wait:10] (Waiting for something to happen?)")
        cutscene:hideNametag()
    end,
    tissuebox = function(cutscene, event)
        cutscene:text("* A tissue box for wiping your sorrows away.")
    end,
    laptop = function(cutscene, event)
        cutscene:text("* A black laptop.\n* Seems it's only used for writing diary entries.")
    end,
    sketchbook = function(cutscene, event)
        cutscene:text("* A sketchbook full of strange-looking drawings.")
        cutscene:text("* There appears to be a crude-looking disembodied head drawn on the cover.")
    end,
    lightbulb = function(cutscene, event)
        cutscene:text("* A lightbulb hangs from the ceiling,[wait:5] wherever it is.")
        cutscene:text("* Look into the lightbulb?")
		
        choice = cutscene:choicer({"Yes", "No"}, options)

        if choice == 1 then
            cutscene:text("* It's pitch black inside.\n[wait:10]* You can't see a thing.")
        end
    end,
}