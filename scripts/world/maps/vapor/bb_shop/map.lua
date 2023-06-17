local BBShop, super = Class(Map)

function BBShop:onEnter()
    Game.world:spawnObject(VaporBG(0, 0), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function BBShop:onExit()
    Game.stage:removeFX("vhs")
end

return BBShop