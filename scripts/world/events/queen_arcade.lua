local QueenAracde, super = Class(Event)

function QueenAracde:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/floor2/queen_arcade")
	
    self.solid = true
end

return QueenAracde