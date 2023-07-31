local LancerDoor, super = Class(Event)

function LancerDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/floor2/door_lancer")
    self.sprite:setScale(1)
    self:addChild(self.sprite)

    self.solid = false
end

return LancerDoor