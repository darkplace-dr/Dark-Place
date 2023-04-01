local SpinHeart, super = Class(Wave)

function SpinHeart:onStart()
    local x = (Game.battle.arena.left + Game.battle.arena.right)/2
    local y = (Game.battle.arena.top + Game.battle.arena.bottom)/2
    self:spawnBullet("hathy/spinheart", x, y, math.rad(0))
end

function SpinHeart:update()
    super.update(self)
end

return SpinHeart