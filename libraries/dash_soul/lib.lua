local Lib = {}

function Lib:init()
	print("Dashing functionality loaded. Made by REFUNDINSTRUCTION Corp.")
	Utils.hook(Encounter, "createSoul", function(orig, self, x,y,color)
		if color == "blue" then
			return BlueSoul(x,y,color)
		end
		return BlackSoul(x,y,color)
	end)
end

return Lib