local FuseMenu, super = Class(Object)

function FuseMenu:init()
	super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

	self.parallax_x = 0
	self.parallax_y = 0

	self:reloadItemsList()

	self.state = "FUSE" -- FUSE, CONFIRM

	self.selected = 1
	self.selected_confirm = 1

	self.offset = 0

	self.second_slot = true

	self.left_arrow = Assets.getTexture("ui/flat_arrow_left")
	self.right_arrow = Assets.getTexture("ui/flat_arrow_right")

	self.heart = Assets.getTexture("player/heart")
	self.heart_x = 80
	self.heart_y = 198
	self.heart_timer = nil
	self.heart_timer_on = false
	self.heart_change_state = false

	self.arrow_timer = 0
	self.arrows_x = {20, 604.5} --Yes, the .5 is for Toby code accuracy how could you tell?

	self.arrow_dir = "l-r"

	self.can_fuse = {false, false}

	--self.rectangle = Rectangle(0, 0, SCREEN_WIDTH, 121)
	--self.rectangle:setColor(0, 0, 0, 1)
	--self:addChild(self.rectangle)

	--self.box = UIBox(54, 154, 533, 229, "light")
	--self:addChild(self.box)
end

function FuseMenu:reloadItemsList()
	self.param_list = Kristal.callEvent("getItemsList")
	self.list = {}

	for k, recipe in ipairs(self.param_list) do
		table.insert(self.list, {})
		for k2,item in pairs(recipe) do
			print(k, k2)
			if k2 ~= "autofuse" and k2 ~= "cutscene" then
				local true_item = Registry.createItem(item)
				self.list[k][k2] = true_item
			end
		end
	end
end

function FuseMenu:update()
	if 2+self.offset*2 > #self.list then
		self.second_slot = false
		if self.selected == 2 then
			self.selected = 1
			self.heart_timer_on = false
			Game.world.timer:cancel(self.heart_timer)
		end
	else
		self.second_slot = true
	end

	local debug_open = (Kristal.DebugSystem and Kristal.DebugSystem:isMenuOpen()) or (Kristal.Console and Kristal.Console.is_open)

	if not debug_open then
		if Input.pressed("down", true) and self.second_slot then
			if self.state == "FUSE" then
				self.selected = self.selected+1
				if self.selected > 2 then
					self.selected = 1
				end
				self.heart_timer_on = false
				Game.world.timer:cancel(self.heart_timer)
			end
		elseif Input.pressed("up", true) then
			if self.state == "FUSE" then
				self.selected = self.selected-1
				if self.selected < 1 then
					self.selected = self.second_slot and 2 or 1
				end
				self.heart_timer_on = false
				Game.world.timer:cancel(self.heart_timer)
			end
		elseif Input.pressed("left", true) then
			if self.state == "FUSE" then
				self.offset = self.offset - 1
				if self.offset < 0 then self.offset = math.ceil(#self.list/2)-1 end
			elseif self.state == "CONFIRM" then
				self.selected_confirm = self.selected_confirm + 1
				if self.selected_confirm > 2 then
					self.selected_confirm = 1
				end
				self.heart_timer_on = false
				Game.world.timer:cancel(self.heart_timer)
			end
		elseif Input.pressed("right", true) then
			if self.state == "FUSE" then
				self.offset = self.offset + 1
				if self.offset > math.ceil(#self.list/2)-1 then self.offset = 0 end
			elseif self.state == "CONFIRM" then
				self.selected_confirm = self.selected_confirm - 1
				if self.selected_confirm < 1 then
					self.selected_confirm = 2
				end
				self.heart_timer_on = false
				Game.world.timer:cancel(self.heart_timer)
			end
		elseif Input.pressed("cancel", true) then
			if self.state == "FUSE" then
				Game.world:closeMenu()
				self:remove()
			elseif self.state == "CONFIRM" then
				if not self.heart_change_state then
					self.state = "FUSE"
					self.heart_change_state = true
					self.heart_timer_on = true
					Game.world.timer:cancel(self.heart_timer)
					self.heart_timer = Game.world.timer:tween(0.3, self, {heart_y=self.selected==1 and 198 or 311}, "out-quint", function()
						self.heart_timer_on = false
					end)
					Game.world.timer:tween(0.3, self, {heart_x=80}, "out-quint", function()
						self.heart_change_state = false
					end)
				end
			end
		elseif Input.pressed("confirm", true) then
			if self.state == "FUSE" then
				if self.can_fuse[self.selected] then
					self.state = "CONFIRM"
					self.heart_change_state = true
					self.heart_timer_on = true
					Game.world.timer:cancel(self.heart_timer)
					self.heart_timer = Game.world.timer:tween(0.3, self, {heart_x=self.selected_confirm==1 and 350 or 450}, "out-quint", function()
						self.heart_timer_on = false
					end)
					Game.world.timer:tween(0.3, self, {heart_y=408}, "out-quint", function()
						self.heart_change_state = false
					end)
				end
			elseif self.state == "CONFIRM" then
				if self.selected_confirm == 1 then
					local cutscene = Kristal.getLibConfig("fusing_library", "cutscene")
					if self.param_list[self.selected+self.offset*2]["cutscene"] ~= nil then
						cutscene = self.param_list[self.selected+self.offset*2]["cutscene"]
					end
					local fuse = Kristal.getLibConfig("fusing_library", "autofuse")
					if self.param_list[self.selected+self.offset*2]["autofuse"] ~= nil then
						fuse = self.param_list[self.selected+self.offset*2]["autofuse"]
					end
					Game.world:closeMenu()
					self:remove()
					Game:setFlag("fuse_items_data", {
						item1 = self.list[self.selected+self.offset*2]["item1"],
						item2 = self.list[self.selected+self.offset*2]["item2"],
						result = self.list[self.selected+self.offset*2]["result"]
					})
					if fuse then
						Game.inventory:removeItem(self.param_list[self.selected+self.offset*2]["item1"])
						Game.inventory:removeItem(self.param_list[self.selected+self.offset*2]["item2"])
						Game.inventory:addItem(self.param_list[self.selected+self.offset*2]["result"])
					end
					Game.world:startCutscene(cutscene)
				else
					if not self.heart_change_state then
						self.state = "FUSE"
						self.heart_change_state = true
						self.heart_timer_on = true
						Game.world.timer:cancel(self.heart_timer)
						self.heart_timer = Game.world.timer:tween(0.3, self, {heart_y=self.selected==1 and 198 or 311}, "out-quint", function()
							self.heart_timer_on = false
						end)
						Game.world.timer:tween(0.3, self, {heart_x=80}, "out-quint", function()
							self.heart_change_state = false
						end)
					end
				end
			end
		end
	end

	if self.state == "FUSE" then
		if self.selected == 1 then
			if not self.heart_timer_on then
				self.heart_timer_on = true
				self.heart_timer = Game.world.timer:tween(0.3, self, {heart_y=198}, "out-quint", function()
					self.heart_timer_on = false
				end)
			end
		else
			if not self.heart_timer_on then
				self.heart_timer_on = true
				self.heart_timer = Game.world.timer:tween(0.3, self, {heart_y=311}, "out-quint", function()
					self.heart_timer_on = false
				end)
			end
		end
	elseif self.state == "CONFIRM" then
		if self.selected_confirm == 1 then
			if not self.heart_timer_on then
				self.heart_timer_on = true
				self.heart_timer = Game.world.timer:tween(0.3, self, {heart_x=350}, "out-quint", function()
					self.heart_timer_on = false
				end)
			end
		else
			if not self.heart_timer_on then
				self.heart_timer_on = true
				self.heart_timer = Game.world.timer:tween(0.3, self, {heart_x=450}, "out-quint", function()
					self.heart_timer_on = false
				end)
			end
		end
	end

	self.arrow_timer = self.arrow_timer + DTMULT

	if self.arrow_timer%5 == 0 then
		if self.arrow_dir == "l-r" then
			if self.arrows_x[1] < 24 then
				self.arrows_x[1] = self.arrows_x[1] + 2
				self.arrows_x[2] = self.arrows_x[2] - 2
			else
				self.arrow_dir = "to-r-l"
			end
		elseif self.arrow_dir == "r-l" then
			if self.arrows_x[1] > 20 then
				self.arrows_x[1] = self.arrows_x[1] - 2
				self.arrows_x[2] = self.arrows_x[2] + 2
			else
				self.arrow_dir = "to-l-r"
			end
		elseif Utils.startsWith(self.arrow_dir, "to-") then
			self.arrow_dir = self.arrow_dir:sub(4)
		end
	end
end

function FuseMenu:draw()
	love.graphics.setColor(0, 0, 0)
	if self.state == "FUSE" then
		love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, 121)
	end

	love.graphics.rectangle("fill", 30+2, 130+2, 580-3, 276-3)

	love.graphics.setColor(1, 1, 1)
	love.graphics.setLineWidth(4)
	love.graphics.rectangle("line", 30+2, 130+2, 580-3, 276-3)

	love.graphics.print("Result", 114, 140)
	love.graphics.print("Ingredients", 330, 140)

	love.graphics.setLineWidth(3)

	love.graphics.line(90, 181, 551, 181)

	local hasItems = {false, false}

	local item1 = self.list[1+self.offset*2]["item1"]
	local item2 = self.list[1+self.offset*2]["item2"]
	local result = self.list[1+self.offset*2]["result"]

	local temp_storages = {
		Utils.copy(Game.inventory.storages[item1.type == "key" and "key_items" or item1.type.."s"]),
		Utils.copy(Game.inventory.storages[item2.type == "key" and "key_items" or item2.type.."s"])
	}

	for i=1,2 do
		local item = i==1 and item1 or item2
		for _,v in ipairs(temp_storages[i]) do

			if v.id == item.id then
				hasItems[i] = true
				Utils.removeFromTable(temp_storages[i], v)
				if i==1 and item1.type == item2.type then
					Utils.removeFromTable(temp_storages[2], v)
				end
				break
			end
			if hasItems[i] then
				hasItems[i] = false
			end
		end
	end

	if self.selected == 1 and self.state == "FUSE" then
		love.graphics.print(result.description, 20, 20)
	end

	self.can_fuse[1] = hasItems[1] and hasItems[2]
	if self.can_fuse[1] then
		if self.selected == 1 then
			love.graphics.setColor(1, 1, 0)
		else
			love.graphics.setColor(1, 1, 1)
		end
	else
		love.graphics.setColor(0.5, 0.5, 0.5)
	end

	love.graphics.print(result.name, 110, 190)

	if hasItems[1] then
		love.graphics.setColor(1, 1, 1)
	else
		love.graphics.setColor(0.5, 0.5, 0.5)
	end
	love.graphics.print(item1.name, 330, 190)

	if hasItems[2] then
		love.graphics.setColor(1, 1, 1)
	else
		love.graphics.setColor(0.5, 0.5, 0.5)
	end
	love.graphics.print(item2.name, 330, 230)

	love.graphics.setColor(1, 1, 1)
	love.graphics.line(90, 280, 551, 280)

	hasItems = {false, false}

	if 2+self.offset*2 <= #self.list then
		item1 = self.list[2+self.offset*2]["item1"]
		item2 = self.list[2+self.offset*2]["item2"]
		result = self.list[2+self.offset*2]["result"]

		temp_storages = {
			Utils.copy(Game.inventory.storages[item1.type == "key" and "key_items" or item1.type.."s"]),
			Utils.copy(Game.inventory.storages[item2.type == "key" and "key_items" or item2.type.."s"])
		}

		for i=1,2 do
			local item = i==1 and item1 or item2
			for _,v in ipairs(temp_storages[i]) do
				if v.id == item.id then
					hasItems[i] = true
					Utils.removeFromTable(temp_storages[i], v)
					if i==1 and item1.type == item2.type then
						Utils.removeFromTable(temp_storages[2], v)
					end
					break
				end
				if hasItems[i] then
					hasItems[i] = false
				end
			end
		end

		if self.selected == 2 and self.state == "FUSE" then
			love.graphics.print(result.description, 20, 20)
		end

		self.can_fuse[2] = hasItems[1] and hasItems[2]
		if self.can_fuse[2] then
			if self.selected == 2 then
				love.graphics.setColor(1, 1, 0)
			else
				love.graphics.setColor(1, 1, 1)
			end
		else
			love.graphics.setColor(0.5, 0.5, 0.5)
		end

		love.graphics.print(result.name, 110, 303)

		if hasItems[1] then
			love.graphics.setColor(1, 1, 1)
		else
			love.graphics.setColor(0.5, 0.5, 0.5)
		end
		love.graphics.print(item1.name, 330, 303)

		if hasItems[2] then
			love.graphics.setColor(1, 1, 1)
		else
			love.graphics.setColor(0.5, 0.5, 0.5)
		end
		love.graphics.print(item2.name, 330, 343)
	end

	local print_pages = true
	local print_arrows = true
	if #self.list <= 2 then
		local one_page_accuracy = Kristal.getLibConfig("fusing_library", "one_page_hide")
		if one_page_accuracy == "all" then
			print_pages = false
			print_arrows = false
		elseif one_page_accuracy == "pages" then
			print_pages = false
		elseif one_page_accuracy == "arrows" then
			print_arrows = false
		end
	end

	if print_pages then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print("Page "..(self.offset+1).." / "..math.ceil(#self.list/2), 532, 346, 0, 0.5, 1)
	end

	if print_arrows then
		if self.state == "FUSE" then
			love.graphics.setColor(1, 1, 1)
			love.graphics.draw(self.left_arrow, self.arrows_x[1], 256, 0, 2, 2)
			love.graphics.draw(self.right_arrow, self.arrows_x[2], 256, 0, 2, 2)
		end
	end

	if self.state == "CONFIRM" then
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 0, 377, SCREEN_WIDTH, SCREEN_HEIGHT)

		love.graphics.setLineWidth(4)
		love.graphics.setColor(1, 1, 1)
		love.graphics.line(0, 377, SCREEN_WIDTH, 377)

		love.graphics.print("Really fuse it?", 60, 400)

		if self.selected_confirm == 1 then
			love.graphics.setColor(1, 1, 0)
		else
			love.graphics.setColor(1, 1, 1)
		end

		love.graphics.print("Yes", 380, 400)

		if self.selected_confirm == 2 then
			love.graphics.setColor(1, 1, 0)
		else
			love.graphics.setColor(1, 1, 1)
		end

		love.graphics.print("No", 480, 400)
	end

	love.graphics.setColor(1, 0, 0)

	love.graphics.draw(self.heart, self.heart_x, self.heart_y)

	super.draw(self)
end

return FuseMenu