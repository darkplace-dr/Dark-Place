local Dogcheck, super = Class(Map)

function Dogcheck:onEnter()
    super.onEnter(self)

    Game.world.music:stop()
    Game.world:startCutscene(function(cutscene)
        Game.world:addChild(DogCheck())
        -- Trap the player
        cutscene:wait(function() return false end)
    end)
end

return Dogcheck
