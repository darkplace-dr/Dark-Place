return {

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

}