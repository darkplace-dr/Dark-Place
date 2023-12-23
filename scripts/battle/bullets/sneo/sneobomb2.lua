local Sneobomb2, super = Class(Bullet)

function Sneobomb2:init(x, y, dir)
    super.init(self, x, y, "battle/bullets/sneo/bomb/sneobomb2")
    self.sprite:play(0.02, false)
    self:setScale(1, 1)
    self.rotation = dir
    self.physics.match_rotation = true
    self:set()
    self.destroy_on_hit = false
end

function Sneobomb2:set()
    Game.battle.timer:script(function(wait)
       wait(0.2)
       self.collidable = false
       self:remove()
    end)
end


return Sneobomb2