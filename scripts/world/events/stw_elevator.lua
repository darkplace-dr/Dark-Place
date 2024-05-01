local Elevator, super = Class(Event)

function Elevator:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self.solid = true
    self:setOrigin(0.5, 1)
    self:setSprite("world/maps/steamworks/objects/37_elevator_1")
end

function Elevator:onInteract(chara, dir)
    Game.world:startCutscene(function(cutscene)
        Assets.playSound("elevator_open_stw")
        self:setSprite("world/maps/steamworks/objects/37_elevator", 0.1)
        cutscene:wait(1.3)
        self:setSprite("world/maps/steamworks/objects/37_elevator_13")
        cutscene:wait(cutscene:walkTo(Game.world.player, self.x, self.y + 20, 0.5, "up"))
        cutscene:wait(cutscene:walkTo(Game.world.player, self.x, self.y, 0.25, "up"))
        --cutscene:mapTransition("hotland/elevator")
    end)
    return true
end

return Elevator