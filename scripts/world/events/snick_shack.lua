local SnickShack, super = Class(Event)

function SnickShack:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/maps/vapor/snick_shack")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0.5, 1)
    self.sprite:play(0.2, true)
    self:addChild(self.sprite)

    self.solid = false
end

return SnickShack