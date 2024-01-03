return {

    forestpuzzle_addSpade = function()
        local tiles = Game.world.map.sfp_tiles
        local event = Game.world.map:getEvent(545)
        local key = Game.world.map.sfp_combination
        if not Game.world.map.sfp_completed then
            for index, object in ipairs(tiles) do
                if object.tile == 10 then
                    event.tile = 1
                    object.tile = 6
                    Assets.playSound("noise")
                    if (tiles[1].tile == key[1]) and (tiles[2].tile == key[2]) and (tiles[3].tile == key[3]) and (tiles[4].tile == key[4]) and (tiles[5].tile == key[5]) and (tiles[6].tile == key[6]) then
                        Game.world.map:completeSFP()
                    else
                        local failed = true
                        for k,v in pairs(tiles) do
                            if v.tile == 10 then
                                failed = false
                            end
                        end
                        if failed == true then
                            Assets.playSound("noise")
                            for k,v in pairs(tiles) do
                                v.tile = 10
                            end
                        end
                    end
                    break
                end
            end
            Game.world.timer:after(0.1, function()
                event.tile = 0
            end)
        end
    end,

    forestpuzzle_addDiamond = function()
        local tiles = Game.world.map.sfp_tiles
        local event = Game.world.map:getEvent(546)
        local key = Game.world.map.sfp_combination
        if not Game.world.map.sfp_completed then
            for index, object in ipairs(tiles) do
                if object.tile == 10 then
                    event.tile = 3
                    object.tile = 7
                    Assets.playSound("noise")
                    if (tiles[1].tile == key[1]) and (tiles[2].tile == key[2]) and (tiles[3].tile == key[3]) and (tiles[4].tile == key[4]) and (tiles[5].tile == key[5]) and (tiles[6].tile == key[6]) then
                        Game.world.map:completeSFP()
                    else
                        local failed = true
                        for k,v in pairs(tiles) do
                            if v.tile == 10 then
                                failed = false
                            end
                        end
                        if failed == true then
                            Assets.playSound("noise")
                            for k,v in pairs(tiles) do
                                v.tile = 10
                            end
                        end
                    end
                    break
                end
            end
            Game.world.timer:after(0.1, function()
                event.tile = 2
            end)
        end
    end,

    forestpuzzle_switch = function()
        local tiles = Game.world.map.sfp_tiles
        local event = Game.world.map:getEvent(547)
        local key = Game.world.map.sfp_combination
        if not Game.world.map.sfp_completed then
            for index, object in ipairs(tiles) do
                local run = false
                if object.tile == 6 then
                    event.tile = 5
                    object.tile = 8
                    run = true
                elseif object.tile == 7 then
                    event.tile = 5
                    object.tile = 9
                    run = true
                elseif object.tile == 8 then
                    event.tile = 5
                    object.tile = 6
                    run = true
                elseif object.tile == 9 then
                    event.tile = 5
                    object.tile = 7
                    run = true
                end
                if run then
                    Assets.playSound("noise")
                    if (tiles[1].tile == key[1]) and (tiles[2].tile == key[2]) and (tiles[3].tile == key[3]) and (tiles[4].tile == key[4]) and (tiles[5].tile == key[5]) and (tiles[6].tile == key[6]) then
                        Game.world.map:completeSFP()
                    else
                        local failed = true
                        for k,v in pairs(tiles) do
                            if v.tile == 10 then
                                failed = false
                            end
                        end
                        if failed == true then
                            Assets.playSound("noise")
                            for k,v in pairs(tiles) do
                                v.tile = 10
                            end
                        end
                    end
                end
            end
            Game.world.timer:after(0.1, function()
                event.tile = 4
            end)
        end
    end,

    --------------------------------------------------

    gr_ruins = function()
        if Game.world.map.ruins then
            Game.world.music:fade(0,1)
            Game.world.map.ruins:fade(1,1)
            Game:setBorder("undertale/ruins")
        end
    end,

    ruins_gr = function()
        if Game.world.map.ruins then
            Game.world.map.ruins:fade(0,1)
            Game.world.music:fade(1,1)
            Game:setBorder("undertale/dog")
        end
    end,

    ruins_city = function()
        if Game.world.map.ruins and Game.world.map.city then
            Game.world.map.ruins:fade(0,1)
            Game.world.map.city:fade(1,1)
            Game:setBorder("city")
        end
    end,

    city_ruins = function()
        if Game.world.map.ruins and Game.world.map.city then
            Game.world.map.city:fade(0,1)
            Game.world.map.ruins:fade(1,1)
            Game:setBorder("undertale/ruins")
        end
    end,

    fields_city = function()
        if Game.world.map.fields and Game.world.map.city then
            Game.world.map.fields:fade(0,1)
            Game.world.map.city:fade(1,1)
            Game:setBorder("city")
        end
    end,

    city_fields = function()
        if Game.world.map.fields and Game.world.map.city then
            Game.world.map.city:fade(0,1)
            Game.world.map.fields:fade(1,1)
            Game:setBorder("castle")
        end
    end,

    fields_snowdin = function()
        if Game.world.map.fields and Game.world.map.snowdin then
            Game.world.map.fields:fade(0,1)
            Game.world.map.snowdin:fade(1,1)
            Game:setBorder("undertale/tundra")
        end
    end,

    snowdin_fields = function()
        if Game.world.map.fields and Game.world.map.snowdin then
            Game.world.map.snowdin:fade(0,1)
            Game.world.map.fields:fade(1,1)
            Game:setBorder("castle")
        end
    end,

    waterfall_forest = function()
        if Game.world.map.forest then
            Game.world.music:fade(0,1)
            Game.world.map.forest:fade(1,1)
            Game:setBorder("castle")
        end
    end,

    forest_cliffs = function()
        if Game.world.map.forest and Game.world.map.cliffs then
            Game.world.map.forest:fade(0,1)
            Game.world.map.cliffs:fade(1,1)
            Game:setBorder("none")
        end
    end,

    cliffs_forest = function()
        if Game.world.map.forest and Game.world.map.cliffs then
            Game.world.map.cliffs:fade(0,1)
            Game.world.map.forest:fade(1,1)
            Game:setBorder("castle")
        end
    end,
    
    cliffs_hotland = function()
        if Game.world.map.hotland and Game.world.map.cliffs then
            Game.world.map.cliffs:fade(0,1)
            Game.world.map.hotland:fade(1,1)
            Game:setBorder("undertale/fire")
        end
    end,
    
    cyber_core = function()
        if Game.world.map.core then
            if Game.world.map.corebg == nil then
                Game.world.map.corebg = Game.world:spawnObject(GlowBG(0, 0), "objects_bg")
                Game.world.map.corebg:setLayer(Game.world:parseLayer("objects_bg")+0.1)
            end
            Game.world.music:fade(0,1)
            Game.world.map.core:fade(1,1)
            Game:setBorder("undertale/fire")
        end
    end,

    remove_core_slide = function(event)
        local area = Game.world.map:getEvent(759)
        local coll = Game.world.map:getEvent(770)
        local ev2 = Game.world.map:getEvent(773)
        area:remove()
        if Game.world.player.state == "SLIDE" then
            Game.world.player:setState("WALK")
            Game.world.player.current_slide_area = nil
        end
        Game:setFlag("CONNECTION.beatcyber", true)
        ev2:remove()
        coll.x = 2280
        coll.y = 2840
        event:remove()
    end,
    
    remove_core_slide_b = function(event)
        local area = Game.world.map:getEvent(759)
        local coll = Game.world.map:getEvent(770)
        local ev2 = Game.world.map:getEvent(760)
        area:remove()
        ev2:remove()
        coll.x = 2280
        coll.y = 2840
        event:remove()
    end,
    
}