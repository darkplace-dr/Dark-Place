return {
    pushblockreset = function(cutscene, event, number, teacher)
		for _,block in ipairs(Game.stage:getObjects(PushBlock)) do
			block.x = block.start_x
			block.y = block.start_y
			block:setSprite(block.default_sprite)
		end
	end,
	
	tilereset = function(cutscene, event)
		for _,tile in ipairs(Game.stage:getObjects(TileButton)) do
			if tile ~= event then
				if tile.wrong then
					tile:setPressed(false)
				end
			end
		end
	end
}