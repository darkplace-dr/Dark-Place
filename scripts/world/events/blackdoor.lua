local BlackDoor, super = Class(Event)

function BlackDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/black_door")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0.5, 1)
    self:addChild(self.sprite)

    self.solid = false
end

function BlackDoor:onInteract(player, dir)
    Game.world:startCutscene("room3", "blackdoor", self)
end

return BlackDoor