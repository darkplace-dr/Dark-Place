local mymap, super = Class(Map)

function mymap:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(CloudsBG(0, 0), "objects_bg")
    Game.stage:setWeather("gilded_grove_ambient", false)
end

return mymap