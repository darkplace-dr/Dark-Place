local VaporRoomTest, super = Class(Map)

function VaporRoomTest:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(true), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function VaporRoomTest:onExit()
    Game.stage:removeFX("vhs")
end

return VaporRoomTest