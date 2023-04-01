local BouncyBullet, super = Class(Bullet)

function BouncyBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/poseurbullet")
    self:setScale(1, 1)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false

    self.velx = 1 - 2*love.math.random()
    self.vely = 0
end

function BouncyBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    local x, y = self:getRelativePos(self.width/2, self.height/2)
    if(x > Game.battle.arena.left and x < Game.battle.arena.right) then
        if y > Game.battle.arena.bottom - 8 then
            self.vely = -4
        end
    end
    self.vely = self.vely + 0.04
    self:move(self.velx, self.vely)

    super.update(self)
end

return BouncyBullet