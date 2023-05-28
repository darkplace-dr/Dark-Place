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

    self.achievements = {}
    for _,v in pairs(Kristal.callEvent("getAchievements")) do
        table.insert(self.achievements, v)
    end
    table.sort(self.achievements, function(a,b) return a.index < b.index end)

    self.items_per_page = 3
    self.ach_num = #self.achievements
    self.max_page = math.max(self.ach_num - (self.items_per_page - 1), 1)
    self.line_height = 90

    self.anim_timer = 0
end

function AchievementsMenu:update()
    self.anim_timer = self.anim_timer + DT
end

function AchievementsMenu:draw()
    love.graphics.setFont(self.font)
	love.graphics.print("Achievements", 150, -10)

    love.graphics.setFont(self.font_2)
    for i = self.page, self.page + (self.items_per_page - 1) do
        if i > self.ach_num then break end

        local ach = self.achievements[i]

        local ri = i - self.page
        local rel_y = 30 + ri * self.line_height

        local frame = Assets.getTexture("achievements/frames/" .. ach.rarity)
        local hide = ach.hidden and not ach.earned
        local percent_color = hide and {0.5, 0.5, 0.5} or {1, 1, 1}
        local body_color = ach.earned and {1, 1, 1} or {0.5, 0.5, 0.5}
        local name = hide and "???" or ach.name
        local desc = (hide and ach.hint) and ach.hint or (ach.menudesc or ach.desc)

        love.graphics.draw(frame, 0, rel_y, 0, 2, 2)

        love.graphics.setColor(body_color)
        if not hide and (ach.menuicon or ach.icon) then
            local icon = Assets.getFramesOrTexture(ach.menuicon or ach.icon)
            local icon_anim_delay = ach.menuicon_anim_delay ~= nil and ach.menuicon_anim_delay or ach.icon_anim_delay
            local icon_frame = Utils.clampWrap(math.floor(self.anim_timer / icon_anim_delay) + 1, #icon)
            love.graphics.draw(icon[icon_frame], 8, rel_y + 8, 0, 2, 2)
        end
        love.graphics.print(name, 90, rel_y + 5)
        love.graphics.print(desc, 90, rel_y + 25)

        if type(ach.completion) == "number" then
            local completion_percent = ach.progress / ach.completion

            love.graphics.setColor(self.progress_color_bg)
            love.graphics.rectangle("fill", 90, rel_y + 60, 150, 12)

            love.graphics.setColor(self.progress_color)
            love.graphics.rectangle("fill", 90, rel_y + 60, (completion_percent * 150), 12)
            love.graphics.setColor(percent_color)
            local completion_percent_2 = completion_percent * 100
            love.graphics.print(tostring(completion_percent_2).."%", 245, rel_y + 57)
        end

        love.graphics.setColor(1, 1, 1)
    end

	if self.page > 1 then
		love.graphics.draw(self.up_sprite, 470, 0, 0, 1, 1)
	end
    local rem = #self.achievements % self.items_per_page
	if self.page < (#self.achievements - rem) then
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
        local rem = #self.achievements % self.items_per_page
        if self.page < (#self.achievements - rem) then
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
