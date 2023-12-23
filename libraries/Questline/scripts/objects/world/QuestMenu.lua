local QuestMenu, super = Class(Object)

function QuestMenu:init()
    super.init(self, 92, 112, 457, 240)
	
	self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.font = Assets.getFont("main")
    self.font_small = Assets.getFont("main", 16)

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.heart_sprite = Assets.getTexture("player/heart")
    self.up = Assets.getTexture("ui/page_arrow_up")
    self.down = Assets.getTexture("ui/page_arrow_down")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    self.selected_item = 1
	
	self.page = 1
	self.pages = math.ceil(#Game:getFlag("quest_name")/11)
end

function QuestMenu:onAdd()
	Assets.playSound("dimbox")
end

function QuestMenu:update()
    super.update(self)
	self.pages = math.ceil(#Game:getFlag("quest_name")/11)
end

function QuestMenu:onKeyPressed(key)
	if Input.isMenu(key) or Input.isCancel(key) then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end
	local old = self.selected_item
	if Input.is("up", key) then
		self.selected_item = self.selected_item - 1
	end
	if Input.is("down", key) then
		self.selected_item = self.selected_item + 1
	end
	if self.selected_item < 1 then self.selected_item = 1 end
	if self.selected_item > #Game:getFlag("quest_id") then self.selected_item = #Game:getFlag("quest_id") end
	if self.selected_item ~= old then
		self.ui_move:stop()
		self.ui_move:play()
		for i=1,self.pages do
			if (self.selected_item >= 1 + 11 * (i - 1)) and (self.selected_item <= 11 * (i)) then
				self.page = i
			end
		end
	end
end

function QuestMenu:draw()
    love.graphics.setFont(self.font)
	
	love.graphics.printf("QUESTS", 0, -8, 457, "center")
	love.graphics.setLineWidth(4)
	love.graphics.line(-20, 32, 477, 32)
	love.graphics.line(160, 32, 160, 260)
	
    love.graphics.setFont(self.font_small)
	for k,v in pairs(Game:getFlag("quest_name")) do
		if (k >= 1 + 11 * (self.page - 1)) and (k <= 11 * (self.page)) then
			if k == self.selected_item then
				love.graphics.setColor(1, 1, 0, 1)
			else
				love.graphics.setColor(1, 1, 1, 1)
			end
			love.graphics.print(v, -6, 42 + (16 * (k-1-11*(self.page-1))))
			if Game:getFlag("quest_completed")[k] then
				love.graphics.setColor(0, 1, 0, 1)
				love.graphics.printf("DONE", 100, 42 + (16 * (k-1)), 50, "right")
				love.graphics.setColor(1, 1, 1, 1)
			elseif Game:getFlag("quest_progress_max")[k] > 0 then
				love.graphics.printf(Game:getFlag("quest_progress")[k] .. "/" .. Game:getFlag("quest_progress_max")[k], 100, 42 + (16 * (k-1)), 50, "right")
			end
		end
	end
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(self.font)
	love.graphics.printf(Game:getFlag("quest_name")[self.selected_item], 160, 42, 320, "center")
	love.graphics.setFont(self.font_small)
	if Game:getFlag("quest_completed")[self.selected_item] then
		love.graphics.setColor(0, 1, 0, 1)
		love.graphics.printf("COMPLETED", 160, 74, 320, "center")
		love.graphics.setColor(1, 1, 1, 1)
	elseif Game:getFlag("quest_progress_max")[self.selected_item] > 0 then
		love.graphics.printf(Game:getFlag("quest_progress")[self.selected_item] .. "/" .. Game:getFlag("quest_progress_max")[self.selected_item], 160, 74, 320, "center")
	end
	love.graphics.printf(Game:getFlag("quest_desc")[self.selected_item], 168, 90, 304)
	
	local total_steps = 0
	if Game:getFlag("quest_total_steps") and Game:getFlag("quest_total_steps") > 0 then
		total_steps = Game:getFlag("quest_total_steps")
	else
		for k,v in pairs(Game:getFlag("quest_progress_max")) do
			local new_steps
			if v <= 0 then
				new_steps = 1
			else
				new_steps = v
			end
			total_steps = total_steps + new_steps
		end
	end
	
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
	
	local percentage = (comp_steps / total_steps) * 100
	love.graphics.printf("Progress: " .. math.floor(percentage) .. "%", 0, 230, 150, "center")
	
	if self.page < self.pages then
		Draw.draw(self.down, 5, 230)
	end
	
	if self.page > 1 then
		Draw.draw(self.up, 135, 230)
	end

    super.draw(self)
end

function QuestMenu:close()
    Game.world.menu = nil
    self:remove()
end

return QuestMenu
