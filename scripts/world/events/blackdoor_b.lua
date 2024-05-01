local BlackDoor_b, super = Class(Event)

function BlackDoor_b:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/whitespace/blackspace/black_door")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0.5, 1)
    self:addChild(self.sprite)

    self.solid = false
end

function BlackDoor_b:onInteract(player, dir)
    Game.world:startCutscene("blackspace", "blackdoor", self)
    return true
end

return BlackDoor_b