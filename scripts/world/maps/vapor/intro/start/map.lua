local Start, super = Class(Map)

function Start:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(VHSFilter(), 99999)
end

return Start