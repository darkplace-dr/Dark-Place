local LavaWave, super = Class(Event)

function LavaWave:init(x,y)
    super.init(self, x, y)
    Game.world:spawnObject(FireBG(), WORLD_LAYERS['bottom'])
    self:remove()
end

return LavaWave