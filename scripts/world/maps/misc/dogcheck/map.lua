local Dogcheck, super = Class(Map)

function Dogcheck:onEnter()
    super:onEnter(self)

    Game.world:startCutscene(function(cutscene)
        Game.world.music:stop()
        Game.world:addChild(DogCheck())
        cutscene:wait(function() return false end)
    end)
end

return Dogcheck
