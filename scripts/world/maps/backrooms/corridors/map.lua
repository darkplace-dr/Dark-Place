local Corridors, super = Class(Map)

function Corridors:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(VHSFilter(), 99999)
end

return Corridors