local GoogleField, super = Class(Map)

function GoogleField:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(DinoBG(0, 0), "objects_bg")

    local cloud_sun = Sprite("world/maps/dinofield/cloud_sun", 600, 20)
    cloud_sun:setScale(2)
    cloud_sun:setLayer(Game.world:parseLayer("objects_bg") + 0.1)
	cloud_sun.parallax_x = 0.1
    Game.world:addChild(cloud_sun)
end

return GoogleField