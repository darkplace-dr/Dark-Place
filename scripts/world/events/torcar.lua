local TorCar, super = Class(Event)

function TorCar:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/torcar")
	
    self.solid = true
end

function TorCar:onInteract(player, dir)
    Game.world:startCutscene("hometown.torcar")
    return true
end

return TorCar