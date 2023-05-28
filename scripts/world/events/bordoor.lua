local BorDoor, super = Class(Event)

function BorDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/bordoor/closed")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = false
end

return BorDoor