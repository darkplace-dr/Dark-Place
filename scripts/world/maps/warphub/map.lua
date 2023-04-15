local WarpHub, super = Class(Map)

function WarpHub:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

return WarpHub