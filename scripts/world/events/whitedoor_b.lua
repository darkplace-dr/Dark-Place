local WhiteDoor_b, super = Class(Event)

function WhiteDoor_b:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/whitespace/white_door")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0.5, 1)
    self:addChild(self.sprite)

    self.solid = false
end

function WhiteDoor_b:onInteract(player, dir)
    Game.world:startCutscene("whitespace", "whitedoor", self)
    return true
end

return WhiteDoor_b