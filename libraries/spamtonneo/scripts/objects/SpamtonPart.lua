local Part, super = Class(Object)

function Part:init(path, x, y, ox, oy, rot)
    super:init(self, x, y)
    self.inherit_color = true
    self.sprite = Sprite(path)
    self.sprite.inherit_color = true
    if ox > 1 or oy > 1 then
        self.sprite:setRotationOriginExact(ox, oy)
    else
        self.sprite:setRotationOrigin(ox, oy)
    end
    self.sprite:setScaleOrigin(self.sprite:getRotationOrigin())
    self:addChild(self.sprite)

    self.default_sprite = path

    self.swing_speed = 0
    self.swing_rotation = rot or 0
    self.default_rotation = self.swing_rotation
    self.siner = 0
    self.shake = 0
    self.swing_shake = 0
end

function Part:update()
    super:update(self)
    if self.shake > 0 then
        self.sprite:setPosition(love.math.random(-self.shake,self.shake), love.math.random(-self.shake,self.shake))
    else
        self.sprite:setPosition(0,0)
    end
    if self.swing_speed > 0 then
        self.siner = self.siner + self.swing_speed*self.parent.swing_speed*DTMULT
        local min, max
        if self.swing_range then
            min, max = unpack(self.swing_range)
        else
            min, max = unpack(self.parent.swing_range)
        end
        self.sprite.rotation = self.swing_rotation + Utils.wave(self.siner/30, min, max)
    else
        self.sprite.rotation = self.swing_rotation
    end
    if self.swing_shake > 0 then
        self.sprite.rotation = self.sprite.rotation + Utils.random(-self.swing_shake, self.swing_shake)
    end
end

function Part:setSprite(path)
    local sprite = Sprite(path)
    sprite.inherit_color = true
    sprite:setRotationOrigin(self.sprite:getRotationOrigin())
    sprite.rotation = self.sprite.rotation
    self.sprite:remove()
    self.sprite = sprite
    self:addChild(sprite)
end

function Part:reset(full, index)
    index = index or 1
    if self.id == "head" then
        self.swing_speed = 0
        self.swing_rotation = math.rad(10)
        self.animating = true
    else
        self.swing_speed = 1 + (index-1)/5
        self.swing_rotation = self.default_rotation
    end
    self.shake = 0
    self.swing_shake = 0
    if self.id == "body" then
        self.swing_range = {math.rad(-7.5),math.rad(7.5)}
    else
        self.swing_range = nil
    end
    if full then
        self:setSprite(self.default_sprite)
        self.siner = 0
    end
end

return Part