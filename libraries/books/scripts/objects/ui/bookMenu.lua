local bookMenu, super = Class(Object)

function bookMenu:init(book)
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
	
	self.book = book
	self.current_page = self.book:getProgress()
	
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

    self.info = Text(self:getText("side"), 10, 10, 410, SCREEN_HEIGHT, {font = "times_b", color = { 1, 1, 1, 1 }})
    self.info.parallax_x = 0
    self.info.parallax_y = 0
    self.info.layer = 1000
    self.background:addChild(self.info)

    -- MAIN, SELECT
    self.state = "MAIN"
end

function bookMenu:getText(type)
	if type == "content" then
		if self.book.show_details then
            return "[s:3][b]    "..self.book.title.."\n[s:3]    By "..self.book.author..[[[b]

]]..self.book:getPageText(self.current_page)
        else
            return self.book:getPageText(self.current_page)
        end
	elseif type == "side" then
		return "Pg."..self.current_page.."/"..#self.book.pages
	end
end

function bookMenu:close()
	booksLib.bookprogress[self.book.id] = self.current_page
    Game.world.menu = nil
    self:remove()
end

function bookMenu:onKeyPressed(key)
	if self.state == "MAIN" then
		if Input.pressed("right") then
			self.ui_move:stop()
			self.ui_move:play()
			if self.current_page < #self.book.pages then
                self.current_page = self.current_page + 1
				self.content:setText(self:getText("content"))
				self.info:setText(self:getText("side"))
			end
		end
		if Input.pressed("left") then
			self.ui_move:stop()
			self.ui_move:play()
			if self.current_page > 1 then
                self.current_page = self.current_page - 1
				self.content:setText(self:getText("content"))
				self.info:setText(self:getText("side"))
			end
		end
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

function bookMenu:update()
    super.update(self)
end

function bookMenu:draw()
    super.draw(self)
end

return bookMenu