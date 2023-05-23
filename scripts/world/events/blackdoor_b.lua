local BlackDoor_b, super = Class(Event)

function BlackDoor_b:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/black_door")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0.5, 1)
    self:addChild(self.sprite)

    self.solid = false
end

function BlackDoor_b:onInteract(player, dir)
    Game.world:startCutscene("blackspace", "blackdoor", self)
end

return BlackDoor_b