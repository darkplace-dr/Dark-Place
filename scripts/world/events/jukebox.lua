local Jukebox_JBM = CLASS_NAME_GETTER("jukebox")
if Jukebox_JBM then return Jukebox_JBM end

local Jukebox, super = Class("Event")

function Jukebox:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

	self.solid = true

    self:setSprite("world/events/jukebox")
    self:setOrigin(0.3, 0.5)
end

function Jukebox:onInteract(chara, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* A non-working jukebox, unfortunately.")
    end)
    return true
end

return Jukebox