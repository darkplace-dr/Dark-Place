local Thoughts, super = Class(Map)

function Thoughts:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

return Thoughts