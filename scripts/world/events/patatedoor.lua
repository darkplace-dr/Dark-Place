local PatateDoor, super = Class(Event)

function PatateDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/croustidoor")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = true
end

function PatateDoor:onInteract(player, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* (There is a big note on the door.)")
        cutscene:text("* The Croustibat will crush the Potassium.\n[wait:10]- Patate")
        cutscene:text("* (There is also a smaller note on the door.)")
        cutscene:text("* I always come back!\n[wait:10]- Spring-[wait:5], um...[wait:5] Patate")
    end)
end

return PatateDoor