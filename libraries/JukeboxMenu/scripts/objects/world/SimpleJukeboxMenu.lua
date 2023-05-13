local JukeboxMenu, super = Class(Object)

function JukeboxMenu:init(jukebox)
    super:init(self, 0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
	
	self.layer = 100

    self.box = UIBox(210, 40, 240, 320)
    self.box.layer = -1
    self:addChild(self.box)
	
	self.font = Assets.getFont("menu")
	self.font_2 = Assets.getFont("plain")
	
	self.jukebox_title = "JUKEBOX"
	
	self.jukebox_text = Text(self.jukebox_title, 330, 30, 300, 200, {style = "menu"})
	local jukebox_text_obj = love.graphics.newText(self.jukebox_text:getFont(), self.jukebox_title)
    self.jukebox_text.x = 330 - Utils.round(jukebox_text_obj:getWidth()/2)
    self.jukebox_text.layer = 1
    self:addChild(self.jukebox_text)
	
    self.heart = Sprite("player/heart_menu")
    self.heart:setOrigin(0.5, 0.5)
	self.heart:setScale(2)
    self.heart:setColor(Game:getSoulColor())
    self.heart.layer = 100
    self:addChild(self.heart)
	
	self.selected_index = 1
	self.page = 1
	
	self.heart_target_x = 224
	self.heart_target_y = 110
	self.heart:setPosition(self.heart_target_x, self.heart_target_y)
	
	--Setting this to "false" will allow you to close the menu using "X".
	self.back_button = true
	
	--"self.songs" is a table that contains all the songs that are in the jukebox.
	--"[1]" and other variables like this in "self.songs" are the page number that the song will display on.
	--name is the title of the song that will be displayed
	--file is the filename for the song that Game.world.music:play() fetches in the update function.

    self.songs = modRequire("scripts.jukebox_songs")
end

function JukeboxMenu:draw()
    super:draw(self)	
	love.graphics.setLineWidth(1)
	love.graphics.setColor(0, 0.4, 0)
	love.graphics.rectangle("line", 212, 70, 230, 1)
	love.graphics.rectangle("line", 212, 110, 230, 1)
	love.graphics.rectangle("line", 212, 150, 230, 1)
	love.graphics.rectangle("line", 212, 190, 230, 1)
	love.graphics.rectangle("line", 212, 230, 230, 1)
	love.graphics.rectangle("line", 212, 270, 230, 1)
	love.graphics.rectangle("line", 212, 310, 230, 1)
	love.graphics.setColor(1, 1, 1)
	left_arrow = Assets.getTexture("ui/flat_arrow_left")
    love.graphics.draw(left_arrow, 230, 340, 0, 2, 2)
	right_arrow = Assets.getTexture("ui/flat_arrow_right")
    love.graphics.draw(right_arrow, 410, 340, 0, 2, 2)
    --song 1 info
    love.graphics.print(self.songs[self.page][1].name, 250, 73, 0, 0.5, 1)
	--song 2 info
    love.graphics.print(self.songs[self.page][2].name, 250, 113, 0, 0.5, 1)
    --song 3 info
    love.graphics.print(self.songs[self.page][3].name, 250, 153, 0, 0.5, 1)
	--song 4 info
    love.graphics.print(self.songs[self.page][4].name, 250, 193, 0, 0.5, 1)
    --song 5 info
    love.graphics.print(self.songs[self.page][5].name, 250, 233, 0, 0.5, 1)
    --song 6 info
    love.graphics.print(self.songs[self.page][6].name, 250, 273, 0, 0.5, 1)
        if self.back_button == true then
            love.graphics.print("Back", 298, 318)
		end
	love.graphics.setColor(0.4, 0.4, 0.4)
	love.graphics.setFont(self.font_2)
	love.graphics.print("Page "..self.page.."/5", 290, 356)
	love.graphics.setColor(1, 1, 1)
end

function JukeboxMenu:onKeyPressed(key, repeatable)
    if Input.is("cancel", false) then
        Game.world:closeMenu()
    end
end

function JukeboxMenu:close()
    Game.world.menu = nil
    self:remove()
end

function JukeboxMenu:update()
    --play song
    if Input.pressed("confirm", true) then
        if self.selected_index == 1 then
            Game.world.music:play(self.songs[self.page][1].file)
        end
        if self.selected_index == 2 then
            Game.world.music:play(self.songs[self.page][2].file)
        end
        if self.selected_index == 3 then
            Game.world.music:play(self.songs[self.page][3].file)
        end
        if self.selected_index == 4 then
            Game.world.music:play(self.songs[self.page][4].file)
        end
        if self.selected_index == 5 then
            Game.world.music:play(self.songs[self.page][5].file)
        end
        if self.selected_index == 6 then
            Game.world.music:play(self.songs[self.page][6].file)
        end
		if self.selected_index == 7 then
            Assets.playSound("ui_cancel_small")
            Game.world:closeMenu()
        end
    end
	--exit menu
	if self.back_button == false then
        if Input.pressed("cancel") then
		    Assets.playSound("ui_cancel_small")
            Game.world:closeMenu()
		end
	end
	--move up
	if Input.pressed("up", true) then
		Assets.playSound("ui_move")
	    self.selected_index = self.selected_index - 1
    end
	--move down
	if Input.pressed("down", true) then
		Assets.playSound("ui_move")
	    self.selected_index = self.selected_index + 1
    end
	--page left
	if Input.pressed("left", true) then
		Assets.playSound("ui_move")
	    self.page = self.page - 1
		self.selected_index = 1
    end
	--page right
	if Input.pressed("right", true) then
		Assets.playSound("ui_move")
	    self.page = self.page + 1
		self.selected_index = 1
    end
	--soul positions
    if self.selected_index == 1 then
		self.heart:setPosition(self.heart_target_x, 90)
	end
	if self.selected_index == 2 then
		self.heart:setPosition(self.heart_target_x, 130)
	end
	if self.selected_index == 3 then
		self.heart:setPosition(self.heart_target_x, 170)
    end
	if self.selected_index == 4 then
		self.heart:setPosition(self.heart_target_x, 210)
    end
	if self.selected_index == 5 then
		self.heart:setPosition(self.heart_target_x, 250)
    end
	if self.selected_index == 6 then
		self.heart:setPosition(self.heart_target_x, 290)
    end
	if self.selected_index == 7 then
		self.heart:setPosition(274, 335)
    end
	
	if self.back_button == true then
	    if self.selected_index > 7 then
            self.selected_index = 1
		end
	    if self.selected_index < 1 then
		    self.selected_index = 7
		end
    end
	if self.back_button == false then
	    if self.selected_index > 6 then
            self.selected_index = 1
		end
	    if self.selected_index < 1 then
		    self.selected_index = 6
		end
    end
	-- if you want to have more pages, you can change the maximum number to increase the number of pages in the menu.
	if self.page > 5 then
		self.page = 1
    end
	if self.page < 1 then
		self.page = 5
    end
end

return JukeboxMenu