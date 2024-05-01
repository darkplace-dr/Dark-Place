---@class GDoor : Event
---@overload fun(...) : GDoor
local GDoor, super = Class(Event)

function GDoor:init(data)
    super.init(self, data.x, data.y, data.w, data.h)
	
	local properties = data.properties or {}
	
	self.map = properties["map"] or "room1"
	
	self:setSprite("world/events/gdoor_1")
	
	self:setOrigin(0.5,1)
end

function GDoor:onInteract(player, dir)
	self:setSprite("world/events/gdoor_2")
	Game.world:mapTransition(self.map, "entry", "up")
	return true
end

return GDoor
