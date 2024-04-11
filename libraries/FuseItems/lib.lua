local Lib = {}

Lib.fuseItemsList = {
	{
		result = "dd_burger",
		item1 = "darkburger",
		item2 = "darkburger"
	},
	{
		result = "silver_card",
		item1 = "amber_card",
		item2 = "amber_card"
	},
	{
		result = "twinribbon",
		item1 = "pink_ribbon",
		item2 = "white_ribbon"
	},
	{
		result = "spikeband",
		item1 = "glowwrist",
		item2 = "ironshackle"
	},
	{
		result = "tensionbow",
		item1 = "bshotbowtie",
		item2 = "tensionbit"
	}
}

function Lib:init()
	print("Loaded FuseItems library!")
	if Kristal.getLibConfig("fusing_library", "print_list_console") then
		for i,recipe in ipairs(Lib.fuseItemsList) do
			print(i.."- "..recipe["item1"].." + "..recipe["item2"].. " = "..recipe["result"])
		end
	end
end

function Lib:postInit()
	Game:setFlag("fuse_items_data", {})
end

function Lib:setItemsList(item_list)
	Lib.fuseItemsList = item_list
end

function Lib:getItemsList()
	return Lib.fuseItemsList
end

function Lib:reloadItemsList()
	local menu = Game.world.menu
	if menu and menu.param_list and menu.list then
		menu:reloadItemsList()
		return true
	end
	return false
end

return Lib