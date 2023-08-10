local PartyRoom, super = Class(Map)

function PartyRoom:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

return PartyRoom