local AchievementsMenu, super = Class(Object)

function AchievementsMenu:init()
    super.init(self, 82, 112, 477, 277)

	self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("plain")

    -- The color of the progress bar for achievements.
    -- `progress_color_bg` is the background color for the bar, while `progress_color` is the color of the progress bar.
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

    self.achievements = Kristal.callEvent("getAchievements")
    self.achievements_sorted = {}
    for _,v in pairs(self.achievements) do
        table.insert(self.achievements_sorted, v)
    end
    table.sort(self.achievements_sorted, function(a,b) return a.index < b.index end)

    self.items_per_page = 3
end

function AchievementsMenu:draw()
    love.graphics.setFont(self.font)
	love.graphics.print("Achievements", 150, -10)

    love.graphics.setFont(self.font_2)
    local achs_to_display = { unpack(self.achievements_sorted, self.page, self.page + (self.items_per_page - 1) )}
    for _,ach in ipairs(achs_to_display) do
        local frame = Assets.getTexture("achievements/frames/"..ach.rarity)
        local hide = ach.hidden and not ach.earned
        local percent_color = hide and {0.5, 0.5, 0.5} or {1, 1, 1}
        local body_color = ach.earned and {0.5, 0.5, 0.5} or {1, 1, 1}
        local name = hide and "???" or ach.name
        local desc = hide and ach.hint or ach.desc

        love.graphics.draw(frame, 0, 30, 0, 2, 2)

        if ach.completion ~= false then
            local completion_percent = ach.progress / ach.completion

            love.graphics.setColor(self.progress_color_bg)
            love.graphics.rectangle("fill", 90, 90, 150, 12)

            love.graphics.setColor(self.progress_color)
            love.graphics.rectangle("fill", 90, 90, (completion_percent * 150), 12)
            love.graphics.setColor(percent_color)
            local completion_percent_2 = completion_percent * 100
            love.graphics.print(completion_percent_2.."%", 245, 87)
        end

        love.graphics.setColor(body_color)
        if not hide and ach.icon then
            local icon = Assets.getTexture(ach.icon)
            love.graphics.draw(icon, 8, 38, 0, 2, 2)
        end
        love.graphics.print(name, 90, 35)
        love.graphics.print(desc, 90, 55)
    end

	love.graphics.setColor(1, 1, 1)
	if self.page > 1 then
		love.graphics.draw(self.up_sprite, 470, 0, 0, 1, 1)
	end
    local rem = #self.achievements_sorted % self.items_per_page
	if self.page < (#self.achievements_sorted - rem) then
		love.graphics.draw(self.down_sprite, 470, 262, 0, 1, 1)
	end

    super.draw(self)
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
        local rem = #self.achievements_sorted % self.items_per_page
        if self.page < (#self.achievements_sorted - rem) then
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

return AchievementsMenu
