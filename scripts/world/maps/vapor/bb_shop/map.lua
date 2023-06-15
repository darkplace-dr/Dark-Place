local BBShop, super = Class(Map)

function BBShop:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(VaporBG(0, 0), "objects_bg")

    Game.world:spawnObject(VHSFilter(), 99999)
end

return BBShop