local Pillars2, super = Class(Map)

function Pillars2:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(true), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function Pillars2:onExit()
    Game.stage:removeFX("vhs")
end

return Pillars2