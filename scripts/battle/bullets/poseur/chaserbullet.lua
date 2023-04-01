local ChaserBullet, super = Class(Bullet)

function ChaserBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/poseurbullet")
    self:setScale(1, 1)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false

    self.xspeed = 0
    self.yspeed = 0
end

function ChaserBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    local selfx, selfy = self:getRelativePos(self.width/2, self.height/2)
    local xdifference = Game.battle.soul.x - selfx
    local ydifference = Game.battle.soul.y - selfy
    self.xspeed = (self.xspeed / 2) + (xdifference / 100)
    self.yspeed = (self.yspeed / 2) + (ydifference / 100)
    self:move(self.xspeed, self.yspeed)

    super.update(self)
end

return ChaserBullet