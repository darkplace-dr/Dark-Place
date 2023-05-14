local BackroomsDoor, super = Class(Event)

function BackroomsDoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/backroomsdoor/closed")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = true
end

function BackroomsDoor:onInteract(player, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* (The door is locked.)")
        cutscene:text("* (From behind it, you can hear the faint sound fluorescent lights.)")
    end)
end

return BackroomsDoor