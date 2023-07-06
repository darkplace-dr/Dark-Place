local mymap, super = Class(Map)

function mymap:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(BrambleBlast(1), "objects_bg")
end

return mymap