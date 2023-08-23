local Pillars, super = Class(Map)

function Pillars:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(true), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function Pillars:onExit()
    Game.stage:removeFX("vhs")
end

return Pillars