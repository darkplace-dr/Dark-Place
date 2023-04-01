local VaporRoomTest, super = Class(Map)

function VaporRoomTest:onEnter()
    super:onEnter(self)
    Game.world:spawnObject(VaporBG(), "objects_bg")
	
    local mountains = Sprite("objects/vaporbg/mountains", 0, 105)
    mountains:setScale(1)
    mountains.wrap_texture_x = true
    mountains.parallax_x = 0.1
    mountains.parallax_y = 0.1
    Game.world:spawnObject(mountains, "objects_bg")
end

return VaporRoomTest