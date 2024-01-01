local diamondwarproom, super = Class(Map)

function diamondwarproom:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end
return diamondwarproom