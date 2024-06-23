local notesMenu, super = Class(Object)

function notesMenu:init(note)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.draw_children_below = 0
    self.font = Assets.getFont("times")
    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")
	self.parallax_x = 0
    self.parallax_y = 0
    self.layer = WORLD_LAYERS["top"]
	---------------------------------------
	
	self.note = note
	
    --self.page_bg = Rectangle(320/2, 0, 320+100, SCREEN_HEIGHT)
	self.page_bg = Rectangle((320/2)-50, 0, 320+100, SCREEN_HEIGHT)
    self.page_bg:setColor(1, 1, 1)
    self.page_bg.alpha = 1
    self.page_bg.parallax_x = 0
    self.page_bg.parallax_y = 0
    self.page_bg.layer = 900
    self:addChild(self.page_bg)

	self.content = bookText(self:getText("content"), 10, 10, 410, SCREEN_HEIGHT, {font = "times", color = { 0, 0, 0, 1 }})
    self.content.parallax_x = 0
    self.content.parallax_y = 0
    self.content.layer = 1000
    self.page_bg:addChild(self.content)

	---------------------------------------
	
    self.background = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.background:setColor(82/255, 86/255, 89/255)
    self.background.alpha = 1
    self.background.parallax_x = 0
    self.background.parallax_y = 0
    self.background.layer = 100
    self:addChild(self.background)

    -- MAIN, SELECT
    self.state = "MAIN"
end

function notesMenu:getText(type)
	if type == "content" then
        if self.note.show_details then
            return "[s:3][b]    "..self.note.title.."\n[s:3]    By "..self.note.author..[[[b]

]]..self.note:getText()
        else
            return self.note:getText()
        end
	end
end

function notesMenu:close()
    Game.world.menu = nil
    self:remove()
end

function notesMenu:onKeyPressed(key)
	if self.state == "MAIN" then
		if Input.pressed("confirm") then
		end
		if Input.pressed("cancel") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            Game.world:closeMenu()
            return
        end
	end
end

function notesMenu:update()
    super.update(self)
end

function notesMenu:draw()
    super.draw(self)
end

return notesMenu