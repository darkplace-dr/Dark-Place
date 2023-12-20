return {

    template = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: NO ONE\"")
        cutscene:text("* It appears to be locked.")
    end,


    brandon = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: BRENDAK7200\"")
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
                Game.world:mapTransition("devhotel/rooms/room_001/entrance", "spawn")
                Assets.playSound("doorclose")
            else
                cutscene:showNametag("Brandon")
                cutscene:text("* Uh,[wait:5] okay then?", "suspicious", "brandon")
                cutscene:hideNametag()
                cutscene:text("* Brandon relocked the door.")
            end
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

    sam = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: SIMBEL\"")
        cutscene:text("* For some reason, this door doesn't follow the numerical order.")
        if not Game:getFlag("finished_sphere_quest", false) then
            cutscene:text("* It appears to be locked.")
            cutscene:text("* Maybe the owner of the room will give you a spare key at some point.")
        else
            cutscene:text("* Will you enter?")
            if cutscene:choicer({"Yes", "No"})==1 then
                cutscene:wait(0.25)
                Assets.playSound("dooropen")
                if Utils.random(0, 100)<=1 then
                    Game:setFlag("gonergirl", true)
                    cutscene:wait(cutscene:mapTransition("chair_room"))
                else
                    cutscene:wait(cutscene:mapTransition("devhotel/rooms/room_004"))
                end
            else
                cutscene:text("* You let the door lives its door life peacefully.")
            end
        end
    end,

    agent7 = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: AGENT 7\"")
        cutscene:text("* You can hear construction on the other side...[wait:10] and someone complaining about it.")
        cutscene:showNametag("???")
        cutscene:text("[voice:lucy]* Ugh, this has been going on for WEEKS![wait:5] Can I have my house back to normal already!?")
        cutscene:hideNametag()
        cutscene:text("* The door isn't locked, but it seems like something's blocking it.")
    end,

    hallwayrng = function (cutscene, event)
        if Input.down("cancel") and Input.down("menu") then
            local speedrunners = "appeased"
            if love.math.random(1, 100) <= 50 then
                Game.world:mapTransition("devhotel/fakehallway", "entry")
            else
                Game.world:mapTransition("devhotel/devhotel1", "entryright")
            end
        else
            if love.math.random(1, 100) <= 5 then
                Game.world:mapTransition("devhotel/fakehallway", "entry")
            else
                Game.world:mapTransition("devhotel/devhotel1", "entryright")
            end
        end
    end,

    room269 = function (cutscene, event)
        Assets.playSound("dooropen")
        Game.world:mapTransition("mysteryman", "spawn")
    end,

    mysteryman = function (cutscene, event)
        event:setAnimation("interact")
        local mysteryblast = Assets.playSound("mysteryblast")
        cutscene:wait(1.2)
        event:setAnimation("fast")
        cutscene:wait(0.7)
        event:setAnimation("interact")
        cutscene:wait(0.3)
        event:setAnimation("blaster")
        cutscene:wait(0.77)
        event:setAnimation("blasterfire")
        cutscene:fadeOut(0.1, {color = {1, 1, 1}})
        cutscene:wait(0.9)
        cutscene:loadMap("devhotel/devhotel_lobby", "spawn", "down")
        cutscene:fadeIn(1/30, {color = {1, 1, 1}})
        Kristal.callEvent("completeAchievement", "mysteryman")
    end
}