local SneoBomb, super = Class(YellowSoulBullet)

function SneoBomb:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/bomb/sneobomb", dir, speed)
    self.alpha = 0
    self.sprite:play(-1, true)
    self:setScale(1, 1)
    self.graphics = {
        fade_to = 1,
        fade = 0.3,
    }
    self.collidable = true
    self.destroy_on_hit = false
    self.physics.speed = -8
end

function SneoBomb:onYellowShot(shot, damage)
    self.wave.timer:script(function(wait)
        self.collidable = false
        Assets.playSound("bump")
        Assets.playSound("bombfall")
        self.sprite:play(0.05, true)
        wait(0.07)
        Assets.playSound("bombfall")
        wait(0.07)
        Assets.playSound("bombfall")
        wait(0.07)
        Assets.playSound("bomb")
        Game.battle:shakeCamera(4)
        self.wave:spawnBullet("sneo/sneobomb2", self.x, self.y + 3, 0)
        for i = 1, 24 do
           self.wave:spawnBullet("sneo/sneobomb3", self.x - 24*i, self.y + 3, 1.571)
           self.wave:spawnBullet("sneo/sneobomb3", self.x + 24*i, self.y + 3, 1.571)
           self.wave:spawnBullet("sneo/sneobomb3", self.x, self.y + 3 + 24*i, 0)
           self.wave:spawnBullet("sneo/sneobomb3", self.x, self.y + 3 - 24*i, 0)
        end
        self:destroy()
    end)
    if Game:getMaxTension() > Game.tension then
       Game.tension = Game.tension + 1
    end
    return "a", false
end

function SneoBomb:update()
    super.update(self)
    if self.x < Game.battle.arena.x - 80 then
        self:fadeOutAndRemove(0.1)
		self:destroy()
    end

end


return SneoBomb