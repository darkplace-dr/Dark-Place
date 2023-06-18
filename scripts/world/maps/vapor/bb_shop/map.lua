local BBShop, super = Class(Map)

function BBShop:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(false), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function BBShop:onExit()
    Game.stage:removeFX("vhs")
end

return BBShop