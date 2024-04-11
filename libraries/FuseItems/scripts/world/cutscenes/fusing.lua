return {
	test = function(cutscene)
		cutscene:text("* Hi! I'm a dummy that can fuses items!")
		cutscene:text("* Would you like to fuse items?")
		if cutscene:choicer({"Yes", "No"}) == 1 then
			cutscene:after(function()
				Game.world:openMenu(FuseMenu())
			end)
		else
			cutscene:text("* That's fine. Come back when you need me.")
		end
	end,
	placeholder = function(cutscene)
		--Here is how you would make the fusion if autofuse was set to false
		--Game.inventory:removeItem(Game:getFlag("fuse_items_data")["item1"].id)
		--Game.inventory:removeItem(Game:getFlag("fuse_items_data")["item2"].id)
		--Game.inventory:addItem(Game:getFlag("fuse_items_data")["result"].id)

		cutscene:text("* Alright, I did it![wait:3] Enjoy your brand new "..Game:getFlag("fuse_items_data")["result"].name.."!")
	end
}