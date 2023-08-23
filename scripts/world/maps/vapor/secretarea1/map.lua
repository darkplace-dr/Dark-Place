local SecretArea1, super = Class(Map)

function SecretArea1:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(VaporBG(true), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
end

function SecretArea1:onExit()
    Game.stage:removeFX("vhs")
end

return SecretArea1