local Spark, super = Class(Bullet, "werewire/spark")

function Spark:init(x, y)
    super:init(self, x, y, "bullets/werewire/spark")

    self:setScale(4, 4)
    self.sprite:play(5/30, true)

    self.tp = 2

    self.destroy_on_hit = false
end

return Spark