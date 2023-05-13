local Dogcheck, super = Class(Map)

function Dogcheck:onEnter()
    super.onEnter(self)

    Game.world:addChild(DogCheck())
    Game.world:startCutscene(function(cutscene)
        -- Trap the player
        cutscene:wait(function() return false end)
    end)
end

return Dogcheck
