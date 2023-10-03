local DevRoom, super = Class(Map)

function DevRoom:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

return DevRoom