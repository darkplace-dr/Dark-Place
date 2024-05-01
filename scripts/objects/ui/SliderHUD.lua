---@class SliderHUD : Object
local SliderHUD, super = Class("Object")

function SliderHUD:init(map)
    super.init(self, 0, 0, SCREEN_WIDTH, 168)

    self:setLayer(WORLD_LAYERS["below_ui"])
    self:setParallax(0, 0)
    self.debug_select = false

    self.map = map
end

function SliderHUD:draw()
	super.draw(self)

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

	if self.map.sliding or self.map.slide_time > 0 then
		love.graphics.printf("TIME", 250, 70, SCREEN_WIDTH, "center")
		love.graphics.printf(string.format("%02d", self.map.slide_time), 250, 90, SCREEN_WIDTH, "center")
	end
end

return SliderHUD