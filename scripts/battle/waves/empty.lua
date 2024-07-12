local Empty, super = Class(Wave)

function Empty:init()
	super.init(self)
	
	self.time = 0
end

return Empty