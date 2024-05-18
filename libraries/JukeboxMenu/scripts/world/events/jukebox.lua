local Jukebox, super = Class(Event)

function Jukebox:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

	self.solid = true

    self:setSprite("world/events/jukebox")
    self:setOrigin(0.3, 0.5)
end

function Jukebox:onInteract(chara, dir)
    Game.world:startCutscene("jukebox")
    return true
end

return Jukebox