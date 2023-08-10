return {

    template = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: NO ONE\"")
        cutscene:text("* It appears to be locked.")
    end,


    brandon = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: BRANDONK7200\"")
        if not cutscene:getCharacter("brandon") then
            cutscene:text("* It appears to be locked.")
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Hold on guys,[wait:5] I got this.", "happy_side", "brandon")
            cutscene:hideNametag()
            cutscene:text("* Brandon took a key out from his pocket and unlocked the door.")
            cutscene:text("* Will you go inside?")
            local opinion = cutscene:choicer({"Yes", "No"})
            if opinion == 1 then
                Assets.playSound("dooropen")
                cutscene:text("* You open the door.")
            else
                cutscene:showNametag("Brandon")
                cutscene:text("* Uh,[wait:5] okay then?", "suspicious", "brandon")
                cutscene:hideNametag()
                cutscene:text("* Brandon relocked the door.")
            end
        end
    end,

    velvet = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: DELTAVELVET\"")
        cutscene:text("* It appears to be locked.")
        cutscene:text("* But there's a tiny mousehole under the door.")

        if not Game:getFlag("enter_velvet_room") then
            local susie = cutscene:getCharacter("susie")
            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("[voice:susie]* There's no way we're gonna fit in there!", "annoyed", "susie")
                cutscene:text("[voice:susie]* Don't think we can convince that mouse for the key...", "annoyed", "susie")
                cutscene:hideNametag()
            end
        end

        cutscene:text("* Will you attempt to squeeze inside?")

        if cutscene:choicer({"Yes", "No"}) == 1 then
            cutscene:wait(cutscene:fadeOut(0.2))
            cutscene:wait(.3)

            if not Game:getFlag("enter_velvet_room") then
                cutscene:text("* You crawled down, trying to enter the hole...")

                Assets.playSound("bump")
                cutscene:wait(.5)
                Assets.playSound("squeak")
                cutscene:wait(.5)
                Assets.playSound("dog_yip")
                cutscene:wait(.5)
                Assets.playSound("bageldefeat")
                cutscene:wait(.3)
            end

            -- FIXME: what the orange
            cutscene:fadeIn(0)
            cutscene:fadeOut(0, { global = true })
            cutscene:wait(cutscene:playSound("slidewhist"))

            cutscene:after(function()
                Game.world:mapTransition("devhotel/rooms/room_002", "spawn")
            end)
        else
            cutscene:text("* You decided not to try and crawl into the hole...")
        end
    end,

    jamm = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: ACOUSTICJAMM\"")
		if Game:getFlag("acj_marcy", false) then
			cutscene:text("* It appears to be locked, but...")
			cutscene:text("* Didn't Marcy say that she would open the door for you?")
			cutscene:text("* Will you knock?")
			
			if cutscene:choicer({"Yes", "No"}) == 1 then
				Assets.playSound("knock")
				cutscene:text("* You knock on the door...")
				
				cutscene:showNametag("Marcy")
				cutscene:text("[voice:marcy]* C-coming!")
				
				Assets.playSound("dooropen")
				cutscene:hideNametag()
				
				cutscene:wait(1)
				
				cutscene:wait(cutscene:fadeOut(0))
				Assets.playSound("doorclose")
				
				cutscene:wait(1)
				
				cutscene:loadMap("devhotel/rooms/room_003", "entry")
				cutscene:wait(cutscene:fadeIn(0.2))
			else
				cutscene:text("* You knockn't.")
			end
		else
			cutscene:text("* It appears to be locked.")
		end
    end,
}