local WarpHub, super = Class(Map)

function WarpHub:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(SpaceBG(0, 0), "objects_bg")
end

return WarpHub