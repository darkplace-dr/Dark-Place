return {
    whitedoor = function(cutscene, event)
        cutscene:text("A white door casts a faint shadow...")
        cutscene:text("Will you enter it?")

        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 2 then
            cutscene:text("You doorn't.")
            return
        end

        cutscene:text("You opened the door...")
        cutscene:fadeOut(2, {color = {1, 1, 1}, music = true, blend = "add"})
        cutscene:wait(2)
        if Game.world.map.id == "room3" then
            cutscene:loadMap("whitespace", "entry")
        elseif Game.world.map.id == "whitespace" then
            cutscene:loadMap("room3", "exit_whitespace")
        end
        cutscene:look("down")
        cutscene:wait(cutscene:fadeIn(2, {color = {1, 1, 1}}))
    end,
    mewo = function(cutscene, event)
        Assets.playSound("mewo", 2, 1)
        cutscene:showNametag("MEWO", {font = "OMORI"})
        cutscene:text("Meow?[wait:10] (Waiting for something to happen?)")
        cutscene:hideNametag()
    end,
    tissuebox = function(cutscene, event)
        cutscene:text("A tissue box for wiping your sorrows away.")
    end,
    laptop = function(cutscene, event)
        cutscene:text("A black laptop.\nSeems it's only used for writing diary entries.")
    end,
    sketchbook = function(cutscene, event)
        cutscene:text("A sketchbook full of strange-looking drawings.")
        cutscene:text("There appears to be a crude, disembodied head drawn on the cover.")
    end,
    lightbulb = function(cutscene, event)
        cutscene:text("A lightbulb hangs from the ceiling,[wait:5] wherever it is.")
        cutscene:text("Look into the lightbulb?")

        if cutscene:choicer({"Yes", "No"}) == 1 then
            cutscene:wait(0.2)
            cutscene:fadeOut(0.5)
            cutscene:wait(0.5)

            local stare = Sprite("world/maps/whitespace/lightbulb_stare")
            stare:play(0.33, true)
			stare.layer = 500
            stare.parallax_x = 0
            stare.parallax_y = 0
            Game.world:addChild(stare)

            cutscene:wait(0.5)
            cutscene:fadeIn(0.5)
            cutscene:wait(2)

            cutscene:text("It's pitch black inside.\n[wait:10]You can't see a thing.")
			cutscene:wait(0.5)
            cutscene:fadeOut(0.5)
            cutscene:wait(0.5)
			stare:remove()
            cutscene:fadeIn(0.5)
            cutscene:wait(0.5)
        end
    end,
}
