local WhiteDoor, super = Class(Event)

function WhiteDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/whitespace/white_door")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0.5, 1)
    self:addChild(self.sprite)

    self.solid = false
end

function WhiteDoor:onInteract(player, dir)
    Game.world:startCutscene("room3", "whitedoor", self)
    return true
end

return WhiteDoor