local Stomper, super = Class(Event)

function Stomper:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/stomper/thwomp_1")
    self.sprite:setScale(2)
    self:addChild(self.sprite)
end

return Stomper