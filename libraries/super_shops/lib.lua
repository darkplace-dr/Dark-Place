local Lib = {}

function Lib:init()
	Utils.hook(Item, "getDiscountPrice", function(orig, self, id)
		return false
	end)
    
    print("Loaded Super Shops")
end

return Lib