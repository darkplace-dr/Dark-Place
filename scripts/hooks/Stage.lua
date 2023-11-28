local Stage, super = Class("Stage", true)

function Stage:draw()
	super:draw(self)
	
	if Game.world and Game.world.map.slide_time then
		love.graphics.setFont(Assets.getFont("main", 32))
	
		love.graphics.printf(Utils.round(Game.world.map.slide_time), 0, 0, SCREEN_WIDTH, "center")
	end
end

return Stage