local Ozymandias, super = Class(Map)

function Ozymandias:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(true), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function Ozymandias:onExit()
    Game.stage:removeFX("vhs")
end

return Ozymandias