local Room1, super = Class(Map)

function Room1:onEnter()
    super.onEnter(self)
	self.ina = Music("inainaina", 0)
end

function Room1:onExit()
    super.onExit(self)
	self.ina:remove()
end

return Room1