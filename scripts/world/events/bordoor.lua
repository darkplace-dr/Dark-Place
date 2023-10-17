local BorDoor, super = Class(Event)

function BorDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("bordoor_closed", 0, 0, nil, nil, "world/events/floor2")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = false
end

function BorDoor:update()
    super.update(self)
	
    if Game:getFlag("BorDoorCodeUnlocked", true) then
        self:setSprite("world/events/floor2/bordoor_open")
    end
end

return BorDoor