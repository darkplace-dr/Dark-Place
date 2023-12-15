local Dogcheck, super = Class(Map)

function Dogcheck:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(DogCheck(), "objects")
    Game.lock_movement = true
end

return Dogcheck
