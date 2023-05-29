local TickDoor, super = Class(Event)

function TickDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/potadoor")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = true
end

function TickDoor:onInteract(player, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* (There is a big note on the door.)")
        cutscene:text("* The Potassium will crush the Croustibat.\n[wait:10]- Tick")
        cutscene:text("* (There is also a smaller note on the door.)")
        cutscene:text("* Don't worry, I'm coming back!\n[wait:10]- Again, [wait:5]Tick")
    end)
end

return TickDoor