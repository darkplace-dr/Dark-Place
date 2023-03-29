local AchievementsMenu, super = Class(Object)

function AchievementsMenu:init()
    super:init(self, 82, 112, 477, 277)
	
	self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("plain")

    -- The color of the progress bar for achievements. `progress_color_bg` is the background color for the bar, while `progress_color` is the color of the progress bar.
    self.progress_color_bg = {0.2,0.2,0.2}
    self.progress_color = {1,1,1}

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.page = 1
	
	self.up_sprite = Assets.getTexture("ui/page_arrow_up")
	self.down_sprite = Assets.getTexture("ui/page_arrow_down")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    self.data = Kristal.callEvent("getAchievements")
	
    self.highest_index = 0
    for k,v in pairs(self.data.achievements) do -- k is the ID, v is the info
	if v.index > self.highest_index then
	    self.highest_index = v.index
	end
    end
end

function AchievementsMenu:draw()
    love.graphics.setFont(self.font)
	
	love.graphics.print("Achievements", 150, -10)

    love.graphics.setFont(self.font_2)

    for k,v in pairs(self.data.achievements) do -- k is the ID, v is the info
        if v.index == 1 + (self.page - 1) then
            local raritysprite = Assets.getTexture("achievements/frames/"..v.rarity)
            local iconsprite = Assets.getTexture(v.icon)
            love.graphics.draw(raritysprite, 0, 30, 0, 2, 2)
            if v.earned == false and v.hidden == true then
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 90, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 90, (completion_percent * 150), 12)
                    love.graphics.setColor(0.5, 0.5, 0.5)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 87)
                end
                love.graphics.setColor(0.5, 0.5, 0.5)
                love.graphics.print("???", 90, 35)
                love.graphics.print(v.hint, 90, 55)
            elseif v.earned == false and v.hidden ~= true then
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 90, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 90, (completion_percent * 150), 12)
                    love.graphics.setColor(1, 1, 1)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 87)
                end
                love.graphics.setColor(0.5, 0.5, 0.5)
                if v.icon then
                    love.graphics.draw(iconsprite, 8, 38, 0, 2, 2)
                end
                love.graphics.print(v.name, 90, 35)
                love.graphics.print(v.desc, 90, 55)
            else
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 90, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 90, (completion_percent * 150), 12)
                    love.graphics.setColor(1, 1, 1)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 87)
                end
                love.graphics.setColor(1, 1, 1)
                if v.icon then
                    love.graphics.draw(iconsprite, 8, 38, 0, 2, 2)
                end
                love.graphics.print(v.name, 90, 35)
                love.graphics.print(v.desc, 90, 55)
            end
        end
    end

    for k,v in pairs(self.data.achievements) do -- k is the ID, v is the info
        if v.index == 2 + (self.page - 1) then
			love.graphics.setColor(1, 1, 1)
            local raritysprite = Assets.getTexture("achievements/frames/"..v.rarity)
            local iconsprite = Assets.getTexture(v.icon)
            love.graphics.draw(raritysprite, 0, 110, 0, 2, 2)
            if v.earned == false and v.hidden == true then
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 170, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 170, (completion_percent * 150), 12)
                    love.graphics.setColor(0.5, 0.5, 0.5)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 167)
                end
                love.graphics.setColor(0.5, 0.5, 0.5)
                love.graphics.print("???", 90, 115)
                love.graphics.print(v.hint, 90, 135)
            elseif v.earned == false and v.hidden ~= true then
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 170, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 170, (completion_percent * 150), 12)
                    love.graphics.setColor(0.5, 0.5, 0.5)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 167)
                end
                love.graphics.setColor(0.5, 0.5, 0.5)
                if v.icon then
                    love.graphics.draw(iconsprite, 8, 118, 0, 2, 2)
                end
                love.graphics.print(v.name, 90, 115)
                love.graphics.print(v.desc, 90, 135)
            else
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 170, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 170, (completion_percent * 150), 12)
                    love.graphics.setColor(1, 1, 1)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 167)
                end
                love.graphics.setColor(1, 1, 1)
                if v.icon then
                    love.graphics.draw(iconsprite, 8, 118, 0, 2, 2)
                end
                love.graphics.print(v.name, 90, 115)
                love.graphics.print(v.desc, 90, 135)
            end
        end
    end

    for k,v in pairs(self.data.achievements) do -- k is the ID, v is the info
        if v.index == 3 + (self.page - 1) then
			love.graphics.setColor(1, 1, 1)
            local raritysprite = Assets.getTexture("achievements/frames/"..v.rarity)
            local iconsprite = Assets.getTexture(v.icon)
            love.graphics.draw(raritysprite, 0, 190, 0, 2, 2)
            if v.earned == false and v.hidden == true then
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 250, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 250, (completion_percent * 150), 12)
                    love.graphics.setColor(0.5, 0.5, 0.5)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 247)
                end
                love.graphics.setColor(0.5, 0.5, 0.5)
                love.graphics.print("???", 90, 195)
                love.graphics.print(v.hint, 90, 215)
            elseif v.earned == false and v.hidden ~= true then
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 250, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 250, (completion_percent * 150), 12)
                    love.graphics.setColor(0.5, 0.5, 0.5)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 247)
                end
                love.graphics.setColor(0.5, 0.5, 0.5)
                if v.icon then
                    love.graphics.draw(iconsprite, 8, 198, 0, 2, 2)
                end
                love.graphics.print(v.name, 90, 195)
                love.graphics.print(v.desc, 90, 215)
            else
                if v.completion ~= false then
                    local completion_percent = v.progress / v.completion

                    love.graphics.setColor(self.progress_color_bg)
                    love.graphics.rectangle("fill", 90, 250, 150, 12)

                    love.graphics.setColor(self.progress_color)
                    love.graphics.rectangle("fill", 90, 250, (completion_percent * 150), 12)
                    love.graphics.setColor(1, 1, 1)
                    local completion_percent_2 = completion_percent * 100
                    love.graphics.print(completion_percent_2.."%", 245, 247)
                end
                love.graphics.setColor(1, 1, 1)
                if v.icon then
                    love.graphics.draw(iconsprite, 8, 198, 0, 2, 2)
                end
                love.graphics.print(v.name, 90, 195)
                love.graphics.print(v.desc, 90, 215)
            end
        end
    end
    
	love.graphics.setColor(1, 1, 1)
	if self.page > 1 then
		love.graphics.draw(self.up_sprite, 470, 0, 0, 1, 1)
	end
	if self.page < self.highest_index - 2 then
		love.graphics.draw(self.down_sprite, 470, 262, 0, 1, 1)
	end
	
    super:draw(self)
end

function AchievementsMenu:onKeyPressed(key, repeatable)
    if Input.isMenu(key) or Input.isCancel(key) then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end
    if Input.is("up", key) then 
	if self.page > 1 then
	    self.page = self.page - 1
	    self.ui_move:stop()
	    self.ui_move:play()
	else
	    self.ui_cant_select:stop()
	    self.ui_cant_select:play()
	end
    end
    if Input.is("down", key) then
	if self.page < self.highest_index - 2 then
	    self.page = self.page + 1
	    self.ui_move:stop()
	    self.ui_move:play()
	else
	    self.ui_cant_select:stop()
            self.ui_cant_select:play()
        end
    end
end

function AchievementsMenu:close()
    Game.world.menu = nil
    self:remove()
end

function AchievementsMenu:update()
end

return AchievementsMenu
