local mymap, super = Class(Map)

function mymap:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(CloudsBG(0, 0), "objects_bg")
end

return mymap