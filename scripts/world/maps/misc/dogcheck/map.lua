local Dogcheck, super = Class(Map)

function Dogcheck:onEnter()
    super.onEnter(self)

    Game.dogcheck = Game.world:spawnObject(DogCheck(), "objects")
    Game.lock_movement = true
end

return Dogcheck
