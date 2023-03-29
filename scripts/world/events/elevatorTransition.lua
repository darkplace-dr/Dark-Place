local elevatorTransition, super = Class(Transition)

function elevatorTransition:init(data)
	super:init(self, data.x, data.y, data.width, data.height, data.properties)
end

return elevatorTransition