local FizzRoom, super = Class(Map)

function FizzRoom:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(false), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function FizzRoom:onExit()
    Game.stage:removeFX("vhs")
end

return FizzRoom