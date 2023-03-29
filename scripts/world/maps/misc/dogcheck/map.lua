local Dogcheck, super = Class(Map)

function Dogcheck:onEnter()
    super:onEnter(self)
    Game.world:spawnObject(DogCheck(0, 0), "objects")
end

return Dogcheck
