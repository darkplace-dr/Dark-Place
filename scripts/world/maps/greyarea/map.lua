local greyarea, super = Class(Map)


function greyarea:onEnter()

    Game.stage:setWeather("rain", false, true)

    local savedData = Mod:loadGameN()
    if savedData then
    else
        Game.world:spawnNPC("noel", 2820, 2180, {cutscene = "noel.meet", sprite = "brella"})
    end

end

function greyarea:update()

    if Game.world.map.id == "greyarea" then
        if Game.world.player.walk_speed >= 60 then
    	    Game.world:InstantMapTransition("room1", "spawn")
        end
    end

    if Input.pressed("menu") and not Game.world.cutscene then
        local eye = Game:getFlag("greyarea_exit_to")
        Game.world:mapTransition(eye[1], eye[2], eye[3])
    end

    if Game.world.player.x <= 360 then
        Game.world.player.x = Game.world.player.x + 5060
        for _,follower in ipairs(Game.world.followers) do
            follower.x = follower.x + 5060
            for _,point in ipairs(follower.history) do
                point.x = point.x + 5060
            end
        end
    elseif Game.world.player.x >= 5420 then
        Game.world.player.x = Game.world.player.x - 5060
        for _,follower in ipairs(Game.world.followers) do
            follower.x = follower.x - 5060
            for _,point in ipairs(follower.history) do
                point.x = point.x - 5060
            end
        end
    end
    if Game.world.player.y <= 280 then
        Game.world.player.y = Game.world.player.y + 3780
        for _,follower in ipairs(Game.world.followers) do
            follower.y = follower.y + 3780
            for _,point in ipairs(follower.history) do
                point.y = point.y + 3780
            end
        end
    elseif Game.world.player.y >= 4060 then
        Game.world.player.y = Game.world.player.y - 3780
        for _,follower in ipairs(Game.world.followers) do
            follower.y = follower.y - 3780
            for _,point in ipairs(follower.history) do
                point.y = point.y - 3780
            end
        end
    end
    super.update(self)
end

return greyarea
