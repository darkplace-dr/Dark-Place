local Entrance, super = Class(Map)

function Entrance:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(VHSFilter(), 99999)
end

return Entrance