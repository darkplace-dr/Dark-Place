local VentSteam, super = Class(Object)

function VentSteam:init()
    super.init(self)
    self.x = 20
    self.y = 20
    self.debug_select = false
    self.sprite = Sprite("effects/ventsteam")
    self:addChild(self.sprite)
    self.sprite:setOrigin(0.5)
    self:setScale(0.8)
    self.size = 0.8

    self.sprite.rotation = math.rad(love.math.random(0,360))

    self.physics.direction = math.rad(-80) + math.rad(love.math.random(-20, 20))
    self.physics.speed = 6
    self.physics.friction = 0.1


end

function VentSteam:update()
    super.update(self)
    self.size = self.size + 0.12 * DTMULT
    self:setScale(self.size)

    self.sprite.alpha = self.sprite.alpha - 0.07 * DTMULT
    if self.sprite.alpha < 0.1 then self:remove() end

    self.sprite.rotation = self.sprite.rotation + math.rad(6)

end

return VentSteam