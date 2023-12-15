local Stage, super = Class("Stage", true)

function Stage:draw()
	super:draw(self)
	
	if Game.world and Game.world.map.slide_time then
		love.graphics.setFont(Assets.getFont("sm64_hud", 32))

		love.graphics.draw(Assets.getTexture(Game.party[1]:getMenuIcon()), 20, 20, 0, 2)
		love.graphics.print(" x" .. 4, 50, 30)
		

		local comp_steps = 0
		for k,v in pairs(Game:getFlag("quest_progress")) do
			if Game:getFlag("quest_progress_max")[k] <= 0 then
				if Game:getFlag("quest_completed")[k] then
					comp_steps = comp_steps + 1
				end
			else
				if v >= Game:getFlag("quest_progress_max")[k] then
					comp_steps = comp_steps + Game:getFlag("quest_progress_max")[k]
				else
					comp_steps = comp_steps + v
				end
			end
		end

		love.graphics.printf("★x" .. comp_steps, SCREEN_WIDTH/2 + 120, 30, SCREEN_WIDTH, "left")

		love.graphics.printf("$x" .. Game.money, -10, 30, SCREEN_WIDTH, "right")


		if Game.world.map.sliding or (Game.world.map.slide_time and Game.world.map.slide_time > 0) then
			love.graphics.printf("TIME", 250, 70, SCREEN_WIDTH, "center")
			love.graphics.printf(Game.world.map.slide_time_display, 250, 90, SCREEN_WIDTH, "center")
		end
	end
end

return Stage