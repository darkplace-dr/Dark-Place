local DogCheckHost, super = Class(Map)

function DogCheckHost:init(world, data, variant, ...)
    ---@diagnostic disable-next-line: redundant-parameter
    super.init(self, world, data, variant, ...)

    self.variant = variant
end

function DogCheckHost:onEnter()
    super.onEnter(self)

    Game.world:spawnObject(DogCheck(self.variant), "objects")
    Game.lock_movement = true
end

return DogCheckHost