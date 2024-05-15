local SneoBombPipis, super = Class(YellowSoulBullet)

function SneoBombPipis:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/bomb/sneobomb")
    self.sprite:play(-1, true)
    self:setScale(1, 1)
    self.collidable = true
    self.destroy_on_hit = false
	self.boom = false
end

function SneoBombPipis:detonate()
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
end

function SneoBombPipis:onYellowShot(shot, damage)
    self:detonate()

    if Game:getMaxTension() > Game.tension then
       Game.tension = Game.tension + 1
    end
    return "a", false
end

function SneoBombPipis:update()
    super.update(self)
	
    if self:collidesWith(self.wave.wall) and self.boom == false then
        Assets.playSound("bump")
        self.physics.gravity = 0.24
        self.physics.speed_y = (-5.5 - Utils.random(3))
    end
	
    if self.boom == false and ((self.x < (Game.battle.arena.x + (Game.battle.arena.width / 2) + 20)) and not (self.y >= self.wave.wall.y)) then
        Assets.playSound("damage")
        self.physics = {}
        self.boom = true
        self:detonate()
    elseif self.y >= SCREEN_HEIGHT and self.boom == false then
        Assets.playSound("damage")
        self.physics = {}
        self.boom = true
        self:detonate()
    else
        self.rotation = self.rotation + math.rad(10) * DTMULT
    end
end

return SneoBombPipis