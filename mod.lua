function Mod:init()
    Mod:registerShaders()

    -- Accur acy
    MUSIC_PITCHES["deltarune/cybercity_alt"] = 1.2
    MUSIC_PITCHES["deltarune/THE_HOLY"] = 0.9
end

function Mod:registerShaders()
    Mod.shaders = {}
    for _,path,shader in Registry.iterScripts("shaders/") do
        assert(shader ~= nil, '"shaders/'..path..'.lua" does not return value')
        Mod.shaders[path] = shader
    end
end

function Mod:postInit(new_file)
    if new_file then
        -- FUN Value
        Game:setFlag("fun", love.math.random(1, 100))

        if Game:hasPartyMember("YOU") then
            Game.world:startCutscene("room1", "react_to_YOU")
        end
    end
end
modRequire("scripts/main/warp_bin")
modRequire("scripts/main/debugsystem")

function Mod:isInRematchMode()
    return Game.world.map.id == "thearena"
end