local PrunselMap, super = Class(Map)

function PrunselMap:load()
    super.load(self)
end

function PrunselMap:update()
    Game.world.music:setPitch(0.38)
end

return PrunselMap