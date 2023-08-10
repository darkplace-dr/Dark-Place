local QueenDoor, super = Class(Event)

function QueenDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/floor2/door_queen")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = false
end

return QueenDoor