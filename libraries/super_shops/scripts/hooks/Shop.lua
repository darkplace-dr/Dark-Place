local Shop, super = Class(Shop)

function Shop:init()
	super.init(self)
	
	self.haggle_rate = self:getFlag("haggle_rate", 1)
	self.haggle_marks = {} -- {position, rate}, calculated after discounts
	self.can_haggle = false
	self.haggle_current = self:getFlag("haggle_current", 0)
	self.haggle_max = 100
	
	self.deny_text = {}
	
	self.current_x = 1
	self.current_y = 1
	
	-- Bonus card
	self.card_width = 5
	self.card_height = 3
	self.list = {1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0}
	self.images = {Assets.getTexture("ui/shop/scratch_card/fail"), Assets.getTexture("ui/shop/scratch_card/excellent"), Assets.getTexture("ui/shop/scratch_card/great"), Assets.getTexture("ui/shop/scratch_card/good"),}
	self.rewards = {0, 0.4, 0.2, 0.1}
	self.bonus_selected = false
	self.bonus_timer = 0
	self.bonus_money = 0
	self.bonus_game = false
	self.bonus_fail_dialogue = "* Too bad![wait:5]\n* Better luck next time!"
	self.bonus_win_dialogue_1 = "* Good job![wait:5] You got a rank "
	self.bonus_win_dialogue_2 = " win!"
end

function Shop:doHaggle(amount)
	self.haggle_current = self.haggle_current + amount
	self.haggle_current = math.min(math.max(self.haggle_current, 0), self.haggle_max)
	self:setFlag("haggle_current", self.haggle_current)
	
	self:updatePrices()
end

function Shop:updateHaggle()
	local mark_current = 0
	local did_mark = false
	for k,v in pairs(self.haggle_marks) do
		if v[1] > mark_current and self.haggle_current >= v[1] then
			mark_current = v[1]
			self.haggle_rate = v[2]
			self:setFlag("haggle_rate", v[2])
			did_mark = true
		end
	end
	if not did_mark then
		self.haggle_rate = 1
		self:setFlag("haggle_rate", 1)
	end
	for k,v in pairs(self.items) do
		v.options["price"] = math.floor(v.options["price"] * self.haggle_rate)
	end
end

function Shop:updateDiscounts()
	for k,v in pairs(self.items) do
		if v.options["discount"] then
			if Game:getFlag(v.options["discount"][1], false) then
				v.options["color"] = {0, 1, 1, 1}
				v.options["price"] = math.floor(v.options["price"] * v.options["discount"][2])
			else
				v.options["color"] = v.options["basecolor"]
			end
		end
	end
end

function Shop:resetPrices()
	for k,v in pairs(self.items) do
		v.options["price"] = v.options["baseprice"]
	end
end

function Shop:updatePrices()
	self:resetPrices()
	self:updateDiscounts()
	self:updateHaggle()
end

function Shop:denyDialogue(reason)
	self:setState("DIALOGUE")
	if type(self.deny_text[reason]) == "function" then
		self.deny_text[reason]()
	else
		self:setDialogueText(self.deny_text[reason])
	end

    self.dialogue_text.advance_callback = (function()
        self:setState("MAINMENU", "DIALOGUE")
    end)
end

function Shop:setState(state, reason)
	if self.deny_text[state] and self:doesDeny(state) then
		self:denyDialogue(state)
		return
	end
	
	super.setState(self, state, reason)
end

function Shop:doesDeny(state)
	return true
end

function Shop:replaceItem(index, item, options)
    if type(item) == "string" then
        item = Registry.createItem(item)
    end
    if item then
        options = options or {}
        options["name"]        = options["name"]        or item:getName()
        options["description"] = options["description"] or item:getShopDescription()
        options["baseprice"]   = options["price"]       or item:getBuyPrice()
        options["price"]       = (options["price"]      or item:getBuyPrice()) * self.haggle_rate
        options["bonuses"]     = options["bonuses"]     or item:getStatBonuses()
        options["discount"]    = options["discount"]    or item.getDiscountPrice and item:getDiscountPrice(self.id) or false -- {flag, decimal modifier}
        options["basecolor"]   = options["color"]       or {1, 1, 1, 1}
        options["color"]       = (options["discount"]   and Game:getFlag(options["discount"][1], false)    and {0, 1, 1, 1} or options["basecolor"])
        options["flag"]        = options["flag"]        or ("stock_" .. tostring(index) .. "_" .. item.id)

        options["stock"] = self:getFlag(options["flag"], options["stock"])

        self.items[index] = {
            item = item,
            options = options
        }
        return true
    else
        return false
    end
end

function Shop:onKeyPressed(key, is_repeat)
	super.onKeyPressed(self, key, is_repeat)
	
	if self.state == "BONUS" then
		if not self.bonus_selected then
			if Input.isConfirm(key) then
				self.bonus_selected = true
			elseif Input.is("up", key) then
				self.current_y = self.current_y - 1
				if self.current_y < 1 then
					self.current_y = 1
				end
			elseif Input.is("down", key) then
				self.current_y = self.current_y + 1
				if self.current_y > self.card_height then
					self.current_y = self.card_height
				end
			elseif Input.is("left", key) then
				self.current_x = self.current_x - 1
				if self.current_x < 1 then
					self.current_x = 1
				end
			elseif Input.is("right", key) then
				self.current_x = self.current_x + 1
				if self.current_x > self.card_width then
					self.current_x = self.card_width
				end
			end
		end
	elseif self.state == "BONUSCONFIRM" then
        if Input.isConfirm(key) and self.bonus_timer > 0.1 then
            if self.current_x == 1 then
				self:setState("BONUS")
			else
				self.bonus_money = 0
				self:setState("MAINMENU")
			end
		elseif Input.is("left", key) or Input.is("right", key) then
            self.current_x = self.current_x + 1
			if self.current_x > 2 then
				self.current_x = 1
			end
        end
	end
	
	self:updatePrices()
end

function Shop:onStateChange(old,new)
	super.onStateChange(self, old, new)
	if old == "BUYMENU" and self.bonus_money > 0 and self.bonus_game then
		self:setState("BONUSCONFIRM")
	end
	if new == "BONUSCONFIRM" then
		self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = false
        self.dialogue_text.width = 372
		self.current_x = 1
		self:setDialogueText("")
		self:setRightText("")
		self.bonus_timer = 0
	elseif new == "BONUS" then
		self.large_box.visible = false
        self.left_box.visible = true
        self.right_box.visible = true
        self.info_box.visible = false
        self.dialogue_text.width = 372
		self.current_x = 1
		self.current_y = 1
		self:setDialogueText("")
		self:setRightText("Select a box!")
		self.list = Utils.shuffle(self.list)
		self.bonus_timer = 0
	elseif old == "BONUSCONFIRM" or old == "BONUS" then
		self.bonus_selected = false
		self.bonus_timer = 0
		self.current_x = 1
		self.current_y = 1
	end
end

function Shop:buyItem(current_item)
    if (current_item.options["price"] or 0) > self:getMoney() then
        self:setRightText(self.buy_too_expensive_text)
    else
        -- PURCHASE THE ITEM
        -- Remove the gold
        self:removeMoney(current_item.options["price"] or 0)
		if self.bonus_game then
			self.bonus_money = self.bonus_money + (current_item.options["price"] or 0)
		end

        -- Decrement the stock
        if current_item.options["stock"] then
            current_item.options["stock"] = current_item.options["stock"] - 1
            self:setFlag(current_item.options["flag"], current_item.options["stock"])
        end

        -- Add the item to the inventory
        local new_item = Registry.createItem(current_item.item.id)
        new_item:load(current_item.item:save())
        if Game.inventory:addItem(new_item) then
            -- Visual/auditorial feedback (did I spell that right?)
            Assets.playSound("locker")
            self:setRightText(self.buy_text)
        else
            -- Not enough space, oops
            self:setRightText(self.buy_no_space_text)
        end
    end
end

function Shop:update()
	super.update(self)
	
	if self.state == "BONUS" then
		if self.bonus_selected then
			self.bonus_timer = self.bonus_timer + DT
		end
		if self.bonus_timer >= 1 then
			self.prize_selected = self.list[self.current_x + (self.current_y-1)*self.card_width]
			Game.money = Game.money + self.bonus_money*self.rewards[self.prize_selected+1]
			if self.prize_selected == 0 then
				self:startDialogue({self.bonus_fail_dialogue},"MAINMENU")
			else
				self:startDialogue({self.bonus_win_dialogue_1 .. self.prize_selected .. self.bonus_win_dialogue_2 .. "\n* You win " .. string.format(self.currency_text, self.bonus_money*self.rewards[self.prize_selected+1]) .. " (" .. math.floor(self.rewards[self.prize_selected+1]*100) .. "%)."},"MAINMENU")
			end
			self.bonus_money = 0
		end
	elseif self.state == "BONUSCONFIRM" then
		self.bonus_timer = self.bonus_timer + DT
	end
end

function Shop:draw()
    self:drawBackground()

    super.super.draw(self)

    love.graphics.setFont(self.font)
    if self.state == "MAINMENU" then
        Draw.setColor(COLORS.white)
        for i = 1, #self.menu_options do
            love.graphics.print(self.menu_options[i][1], 480, 220 + (i * 40))
        end
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 450, 230 + (self.main_current_selecting * 40))
    elseif self.state == "BUYMENU" then

        while self.current_selecting - self.item_offset > 5 do
            self.item_offset = self.item_offset + 1
        end

        while self.current_selecting - self.item_offset < 1 do
            self.item_offset = self.item_offset - 1
        end

        if self.item_offset + 5 > #self.items + 1 then
            if #self.items + 1 > 5 then
                self.item_offset = self.item_offset - 1
            end
        end

        if #self.items + 1 == 5 then
            self.item_offset = 0
        end

        -- Item type (item, key, weapon, armor)
        for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.items)) do
            if i == math.max(4, #self.items) + 1 then break end
            local y = 220 + ((i - self.item_offset) * 40)
            local item = self.items[i]
            if not item then
                -- If the item is null, add some empty space
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 60, y)
            elseif item.options["stock"] and (item.options["stock"] <= 0) then
                -- If we've depleted the stock, show a "sold out" message
                Draw.setColor(COLORS.gray)
                love.graphics.print("--SOLD OUT--", 60, y)
            else
                Draw.setColor(item.options["color"])
                love.graphics.print(item.options["name"], 60, y)
                if not self.hide_price then
					Draw.setColor(COLORS.white)
					love.graphics.print(string.format(self.currency_text, item.options["price"] or 0), 300, y)
					if item.options["discount"] and Game:getFlag(item.options["discount"][1]) then
						Draw.setColor({0.5,0.5,0.5})
						love.graphics.setFont(Assets.getFont("main", 16))
						love.graphics.print(math.floor((item.options["baseprice"] or 0) * self.haggle_rate), 302+self.font:getWidth(string.format(self.currency_text, item.options["price"] or 0)), y+13)
						love.graphics.setLineWidth(2)
						love.graphics.line( 302+self.font:getWidth(string.format(self.currency_text, item.options["price"] or 0)), y+22, 302+self.font:getWidth(string.format(self.currency_text, item.options["price"] or 0))+Assets.getFont("main", 16):getWidth(math.floor((item.options["baseprice"] or 0) * self.haggle_rate)), y+22)
					end
                end
            end
			love.graphics.setFont(self.font)
        end
        Draw.setColor(COLORS.white)
        if self.item_offset == math.max(4, #self.items) - 4 then
            love.graphics.print("Exit", 60, 220 + (math.max(4, #self.items) + 1 - self.item_offset) * 40)
        end
        Draw.setColor(Game:getSoulColor())
        if not self.buy_confirming then
            Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
        else
            Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
            Draw.setColor(COLORS.white)
            local lines = Utils.split(string.format(self.buy_confirmation_text, string.format(self.currency_text, self.items[self.current_selecting].options["price"] or 0)), "\n")
            for i = 1, #lines do
                love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
            end
            love.graphics.print("Yes", 60 + 420, 420 - 80)
            love.graphics.print("No",  60 + 420, 420 - 80 + 30)
        end
        Draw.setColor(COLORS.white)

        if (self.current_selecting <= #self.items) then
            local current_item = self.items[self.current_selecting]
            local box_left, box_top = self.info_box:getBorder()

            local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
            local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
            local width = self.info_box.width + box_left * 1.5
            local height = self.info_box.height + box_top * 1.5

            Draw.pushScissor()
            Draw.scissor(left, top, width, height)

            Draw.setColor(COLORS.white)
            love.graphics.print(current_item.options["description"], left + 32, top + 20)

            if current_item.item.type == "armor" or current_item.item.type == "weapon" then
                for i = 1, #Game.party do
                    -- Turn the index into a 2 wide grid (0-indexed)
                    local transformed_x = (i - 1) % 2
                    local transformed_y = math.floor((i - 1) / 2)

                    -- Transform the grid into coordinates
                    local offset_x = transformed_x * 100
                    local offset_y = transformed_y * 45

                    local party_member = Game.party[i]
                    local can_equip = party_member:canEquip(current_item.item)
                    local head_path = ""

                    love.graphics.setFont(self.plain_font)
                    Draw.setColor(COLORS.white)

                    if can_equip then
                        head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
                        if current_item.item.type == "armor" then
                            Draw.draw(self.stat_icons["defense_1"], offset_x + 470, offset_y + 127 + top)
                            Draw.draw(self.stat_icons["defense_2"], offset_x + 470, offset_y + 147 + top)

                            for j = 1, 2 do
                                self:drawBonuses(party_member, party_member:getArmor(j), current_item.options["bonuses"], "defense", offset_x + 470 + 21, offset_y + 127 + ((j - 1) * 20) + top)
                            end

                        elseif current_item.item.type == "weapon" then
                            Draw.draw(self.stat_icons["attack"], offset_x + 470, offset_y + 127 + top)
                            Draw.draw(self.stat_icons["magic" ], offset_x + 470, offset_y + 147 + top)
                            self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "attack", offset_x + 470 + 21, offset_y + 127 + top)
                            self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "magic",  offset_x + 470 + 21, offset_y + 147 + top)
                        end
                    else
                        head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
                    end

                    Draw.draw(head_path, offset_x + 426, offset_y + 132 + top)
                end
            end

            Draw.popScissor()

            Draw.setColor(COLORS.white)

            if not self.hide_storage_text then
                love.graphics.setFont(self.plain_font)

                local current_storage = Game.inventory:getDefaultStorage(current_item.item)
                local space = Game.inventory:getFreeSpace(current_storage)

                if space <= 0 then
                    love.graphics.print("NO SPACE", 521, 430)
                else
                    love.graphics.print("Space:" .. space, 521, 430)
                end
            end
        end
    elseif self.state == "SELLMENU" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 50, 230 + (self.sell_current_selecting * 40))
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        for i, v in ipairs(self.sell_options) do
            love.graphics.print(v[1], 80, 220 + (i * 40))
        end
        love.graphics.print("Return", 80, 220 + ((#self.sell_options + 1) * 40))
    elseif self.state == "SELLING" then
        if self.item_current_selecting - self.item_offset > 5 then
            self.item_offset = self.item_offset + 1
        end

        if self.item_current_selecting - self.item_offset < 1 then
            self.item_offset = self.item_offset - 1
        end

        local inventory = Game.inventory:getStorage(self.state_reason[2])

        if inventory and inventory.sorted then
            if self.item_offset + 5 > #inventory then
                if #inventory > 5 then
                    self.item_offset = self.item_offset - 1
                end
            end
            if #inventory == 5 then
                self.item_offset = 0
            end
        end

        Draw.setColor(Game:getSoulColor())

        Draw.draw(self.heart_sprite, 30, 230 + ((self.item_current_selecting - self.item_offset) * 40))
        if self.sell_confirming then
            Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
            Draw.setColor(COLORS.white)
            local lines = Utils.split(string.format(self.sell_confirmation_text, string.format(self.currency_text, inventory[self.item_current_selecting]:getSellPrice())), "\n")
            for i = 1, #lines do
                love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
            end
            love.graphics.print("Yes", 60 + 420, 420 - 80)
            love.graphics.print("No",  60 + 420, 420 - 80 + 30)
        end

        Draw.setColor(COLORS.white)

        if inventory then
            for i = 1 + self.item_offset, self.item_offset + math.min(5, inventory.max) do
                local item = inventory[i]
                love.graphics.setFont(self.font)

                if item then
                    Draw.setColor(COLORS.white)
                    love.graphics.print(item:getName(), 60, 220 + ((i - self.item_offset) * 40))
                    if item:isSellable() then
                        love.graphics.print(string.format(self.currency_text, item:getSellPrice()), 60 + 240, 220 + ((i - self.item_offset) * 40))
                    end
                else
                    Draw.setColor(COLORS.dkgray)
                    love.graphics.print("--------", 60, 220 + ((i - self.item_offset) * 40))
                end
            end

            local max = inventory.max
            if inventory.sorted then
                max = #inventory
            end

            Draw.setColor(COLORS.white)

            if max > 5 then

                for i = 1, max do
                    local percentage = (i - 1) / (max - 1)
                    local height = 129

                    local draw_location = percentage * height

                    local tocheck = self.item_current_selecting
                    if self.sell_confirming then
                        tocheck = self.current_selecting_choice
                    end

                    if i == tocheck then
                        love.graphics.rectangle("fill", 372, 292 + draw_location, 9, 9)
                    elseif inventory.sorted then
                        love.graphics.rectangle("fill", 372 + 3, 292 + 3 + draw_location, 3, 3)
                    end
                end

                -- Draw arrows
                if not self.sell_confirming then
                    local sine_off = math.sin((Kristal.getTime()*30)/6) * 3
                    if self.item_offset + 4 < (max - 1) then
                        Draw.draw(self.arrow_sprite, 370, 149 + sine_off + 291)
                    end
                    if self.item_offset > 0 then
                        Draw.draw(self.arrow_sprite, 370, 14 - sine_off + 291 - 25, 0, 1, -1)
                    end
                end
            end
        else
            love.graphics.print("Invalid storage", 60, 220 + (1 * 40))
        end
    elseif self.state == "TALKMENU" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 50, 230 + (self.current_selecting * 40))
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        for i = 1, math.max(4, #self.talks) do
            local v = self.talks[i]
            if v then
                Draw.setColor(v[2].color)
                love.graphics.print(v[1], 80, 220 + (i * 40))
            else
                Draw.setColor(COLORS.dkgray)
                love.graphics.print("--------", 80, 220 + (i * 40))
            end
        end
        Draw.setColor(COLORS.white)
        love.graphics.print("Exit", 80, 220 + ((math.max(4, #self.talks) + 1) * 40))
	elseif self.state == "BONUSCONFIRM" then
		Draw.setColor(COLORS.white)
		love.graphics.setFont(Assets.getFont("main", 16))
		love.graphics.print("Prize pool: " .. string.format(self.currency_text, self.bonus_money), 30, 450)
		love.graphics.setFont(self.font)
		love.graphics.print("Scratch a bonus card?", 60, 300)
		love.graphics.print("Yes", 80, 360)
		love.graphics.print("No", 300, 360)
		Draw.setColor(Game:getSoulColor())
		if self.current_x == 1 then
			Draw.draw(self.heart_sprite, 60, 370)
		else
			Draw.draw(self.heart_sprite, 280, 370)
		end
	elseif self.state == "BONUS" then
		Draw.setColor(COLORS.white)
		love.graphics.setFont(Assets.getFont("main", 16))
		love.graphics.print("Prize pool: " .. string.format(self.currency_text, self.bonus_money), 30, 450)
		love.graphics.setFont(self.font)
		for i = 1, #self.list do -- 60, 280
			local x = 60 + 60*((i-1)%self.card_width)
			local y = 280 + 50*math.floor((i-1)/self.card_width)
			local xfind = i%self.card_width
			if xfind == 0 then
				xfind = 5
			end
			if (not self.bonus_selected) or self.current_x ~= xfind or self.current_y ~= math.ceil(i/self.card_width) then
				love.graphics.rectangle("fill", x, y, 46, 40)
			else
				Draw.draw(self.images[self.list[i]+1], x, y, 0, 2, 2)
			end
		end
		if not self.bonus_selected then
			Draw.setColor(Game:getSoulColor())
			Draw.draw(self.heart_sprite, 75 + 60*(self.current_x-1), 292 + 50*(self.current_y-1))
		end
    end

    if self.state == "MAINMENU" 	or
       self.state == "BUYMENU"  	or
       self.state == "SELLMENU" 	or
       self.state == "SELLING"  	or
       self.state == "BONUSCONFIRM" or
       self.state == "BONUS"  		or
       self.state == "TALKMENU" 	then
        Draw.setColor(COLORS.white)
        love.graphics.setFont(self.font)
        love.graphics.print(string.format(self.currency_text, self:getMoney()), 440, 420)
    end

    Draw.setColor(0, 0, 0, self.fade_alpha)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	
	if self.can_haggle then
		love.graphics.setColor({1, 1, 1})
		love.graphics.setFont(Assets.getFont("main", 16))
		love.graphics.rectangle("fill", 38, 18, 564, 14)
		love.graphics.print("Hag-O-Bar: " .. self.haggle_current .. "/" .. self.haggle_max .. " (" .. math.floor(self.haggle_rate * 100) .. "% Price)", 38, 2)
		love.graphics.setColor({0, 0, 0})
		love.graphics.rectangle("fill", 40, 20, 560, 10)
		love.graphics.setColor({0, 1, 0})
		love.graphics.rectangle("fill", 40, 20, 560 * self.haggle_current / self.haggle_max, 10)
		love.graphics.setColor({1, 1, 1})
		for k,v in pairs(self.haggle_marks) do
			love.graphics.rectangle("fill", 39 + 560 * v[1] / self.haggle_max, 23, 2, 4)
		end
	end
end


return Shop