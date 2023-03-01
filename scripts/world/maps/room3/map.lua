local Room3, super = Class(Map)

function Room3:onEnter()
    super:onEnter(self)
	self.morshu_dance = false
end

return Room3