local EndBullet, super = Class(Bullet)

function EndBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/Health")
    self.destroy_on_hit = false
    self.sprite:play(1/15)
    self:setScale(1,1)
    self.sprite_init_x = self.sprite.x
    self.sprite_init_y = self.sprite.y
    self.damage = 0
    self.tp = 0

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function EndBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

function EndBullet:onCollide(soul)
    for _,party in ipairs(Game.battle.party) do
        party:heal(math.huge)
    end
    self.attacker:addMercy(100)
    Game.battle.encounter:onWavesDone()
end


return EndBullet