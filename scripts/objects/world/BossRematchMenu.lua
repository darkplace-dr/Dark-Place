local BossRematchMenu, super = Class(Object)

function BossRematchMenu:init()
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
    self.soul = Assets.getTexture("player/heart")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    self.highest_index = 2
    self.currently_selected = 1
end

function BossRematchMenu:draw()
    love.graphics.setFont(self.font)
	
	love.graphics.print("Bosses", 180, -10)

    love.graphics.setFont(self.font_2)

    love.graphics.setColor(1, 0, 0)

    love.graphics.draw(self.soul, 0, self.currently_selected * 30)

    love.graphics.setColor(1, 1, 1)

    if Game:getFlag("spamgolor_defeated") == true then
        love.graphics.print("Spamgolor", 30, 30)
    else
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.print("?????????", 30, 30)
    end
    if Game:getFlag("mimic_defeated") == true then
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Mimic", 30, 60)
    else
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.print("?????", 30, 60)
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

function BossRematchMenu:onKeyPressed(key, repeatable)
    if Input.isMenu(key) or Input.isCancel(key) then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end
    if Input.is("up", key) then 
	if self.currently_selected > 1 then
	    self.currently_selected = self.currently_selected - 1
	    self.ui_move:stop()
	    self.ui_move:play()
	else
	    self.ui_cant_select:stop()
	    self.ui_cant_select:play()
	end
    end
    if Input.is("down", key) then
	if self.currently_selected < self.highest_index then
	    self.currently_selected = self.currently_selected + 1
	    self.ui_move:stop()
	    self.ui_move:play()
	else
	    self.ui_cant_select:stop()
            self.ui_cant_select:play()
        end
    end
    if Input.pressed("confirm") then
        if self.currently_selected == 1 then
            if Game:getFlag("spamgolor_defeated") == true then
                self.ui_select:stop()
                self.ui_select:play()
                Game.world:closeMenu()
                Game:encounter("spamgolor")
            else
                self.ui_cant_select:stop()
	            self.ui_cant_select:play()
            end
        elseif self.currently_selected == 2 then
            if Game:getFlag("mimic_defeated") == true then
                self.ui_select:stop()
                self.ui_select:play()
                Game.world:closeMenu()
                Game:encounter("mimicboss")
            else
                self.ui_cant_select:stop()
	            self.ui_cant_select:play()
            end
        end
    end
end

function BossRematchMenu:close()
    Game.world.menu = nil
    self:remove()
end

function BossRematchMenu:update()
end

return BossRematchMenu
