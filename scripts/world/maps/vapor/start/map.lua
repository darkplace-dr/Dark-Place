local Start, super = Class(Map)

function Start:onEnter()
    super.onEnter(self)

    
    Game.world:spawnObject(VaporBG(false), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function Start:onExit()
    Game.stage:removeFX("vhs")
end

return Start