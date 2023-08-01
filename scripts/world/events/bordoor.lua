local BorDoor, super = Class(Event)

function BorDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("bordoor_closed", 0, 0, nil, nil, "world/events/floor2")
    if Game:getFlag("BorDoorCodeUnlocked", false) then
        self.sprite:set("bordoor_open")
    end
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = false
end

return BorDoor