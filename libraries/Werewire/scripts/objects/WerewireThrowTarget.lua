local WerewireThrowTarget, super = Class(Sprite)

function WerewireThrowTarget:init(x, y)
    super:init(self, "acts/werewire/throw/target", x, y)

    self:setScale(2, 2)
    self:setOrigin(0.5, 0.5)

    self:setHitbox(0, 0, self.width, self.height)

    self.start_x = self.x
    self.start_y = self.y

    self.y = self.y - 120

    self.progress = Utils.random(360)
    self.increment = Utils.random(3.8, 4.2)
    self.amplitude = 75

    self.shift_y = self.y

    self.progress = (self.progress + (self.increment * 2)) % 360
    self.shift = self.amplitude * math.sin(math.rad(self.progress))

    self.y = self.shift_y + self.shift
    self.x = (self.start_x - (self.y + 0.1) / 3.375) + 18
end

function WerewireThrowTarget:update()
    self.progress = (self.progress + (self.increment * DTMULT)) % 360
    self.shift = self.amplitude * math.sin(math.rad(self.progress))

    self.y = self.shift_y + self.shift
    self.x = (self.start_x - (self.y + 0.1) / 3.375) + 18 + (self.width/2 * self.scale_x)

    super:update(self)
end

function WerewireThrowTarget:slash(battler)
    local src = Assets.stopAndPlaySound(battler.chara:getAttackSound() or "laz_c")
    src:setPitch(battler.chara:getAttackPitch() or 1)

    local sprite = Sprite(battler.chara:getAttackSprite() or "effects/attack/cut", self.x, self.y)
    sprite:play(4/30, false, function() sprite:remove() end)
    sprite:setScale(2, 2)
    sprite:setOrigin(0.5, 0.5)
    sprite.rotation = math.rad(-45)
    sprite.layer = self.layer + 0.01

    self.collidable = false
    self.parent:addChild(sprite)

    self.parent:addChild(WerewireAfterImageCut(self))

    self:remove()
end

return WerewireThrowTarget