return {

    template = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: NO ONE\"")
        cutscene:text("* It appears to be locked.")
    end,


    brenda = function(cutscene, event)
        cutscene:text("* It's a door.")
        cutscene:text("* The sign reads \"THIS ROOM BELONGS TO: BRENDAK7200\"")
        if not cutscene:getCharacter("brenda") then
            cutscene:text("* It appears to be locked.")
        else
            cutscene:showNametag("Brenda")
            cutscene:text("* Hold on guys,[wait:5] I got this.", "happy_side", "brenda")
            cutscene:hideNametag()
            cutscene:text("* Brenda took a key out from her pocket and unlocked the door.")
            cutscene:text("* Will you go inside?")
            local opinion = cutscene:choicer({"Yes", "No"})
            if opinion == 1 then
                Assets.playSound("dooropen")
                cutscene:text("* You open the door.")
                Game.world:mapTransition("devhotel/rooms/room_001/entrance", "spawn")
                Assets.playSound("doorclose")
            else
                cutscene:showNametag("Brenda")
                cutscene:text("* Uh,[wait:5] okay then?", "suspicious", "brenda")
                cutscene:hideNametag()
                cutscene:text("* Brenda relocked the door.")
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
        cutscene:text("* It appears to be locked.")
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
        
        local gb = Game.world:spawnBullet("gaster_blaster", event.x, event.y)
        local dd = Utils.random(360)
		
        Assets.stopSound("gaster_blaster")

        gb.rotation = math.rad(90)
        gb.target_x = gb.x
        gb.target_y = gb.y - 100

        if gb.target_y > 440 then
            gb.target_y = 440
        end
        if gb.target_y < 40 then
            gb.target_y = 40
        end
        if gb.target_x < 50 then
            gb.target_x = 50
        end
        if gb.target_x > 590 then
            gb.target_x = 590
        end
		
        gb.x = gb.x + math.sin(dd) * 400
        gb.y = gb.y + math.cos(dd) * 300
        gb.wait_time = 6.5
        cutscene:wait(0.77)
        Assets.stopSound("gaster_blast")
        Assets.stopSound("gaster_blast2")
        cutscene:fadeOut(0.1, {color = {1, 1, 1}})
        cutscene:wait(0.9)
        cutscene:loadMap("devhotel/devhotel_lobby", "spawn", "down")
        cutscene:fadeIn(1/30, {color = {1, 1, 1}})
        Kristal.callEvent("completeAchievement", "mysteryman")
    end
}