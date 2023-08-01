local Jukebox, super = Class(Event)

function Jukebox:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

	self.solid = true

    self:setSprite("world/events/juke")
    self:setOrigin(0.3, 0.5)

	self.simple = data.properties["simple"]
end

function Jukebox:onInteract(chara, dir)
    if not self.simple then
        Game.world:startCutscene("jukebox.normal")
	else
        Game.world:startCutscene("jukebox.simple")
    end
end

return Jukebox