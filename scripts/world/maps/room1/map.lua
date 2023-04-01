local Room1, super = Class(Map)

function Room1:onEnter()
    super:onEnter(self)
	self.ina = Music("inainaina", 0)
	Game.world:addChild(self.ina)
end

return Room1