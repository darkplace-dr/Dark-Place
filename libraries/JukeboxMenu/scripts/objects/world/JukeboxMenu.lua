local JukeboxMenu, super = Class(Object)

function JukeboxMenu:init(jukebox)
    super:init(self, 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    
    self.layer = 100

    self.box = UIBox(60, 40, 520, 350)
    self.box.layer = -1
    self:addChild(self.box)
    
    self.font = Assets.getFont("menu")
    self.font_2 = Assets.getFont("plain")
    
    self.jukebox_title = "JUKEBOX"
    
    self.jukebox_text = Text(self.jukebox_title, 320, 22, 300, 200, {style = "menu"})
    local jukebox_text_obj = love.graphics.newText(self.jukebox_text:getFont(), self.jukebox_title)
    self.jukebox_text.x = 320 - Utils.round(jukebox_text_obj:getWidth()/2)
    self.jukebox_text.layer = 1
    self:addChild(self.jukebox_text)
    
    self.heart = Sprite("player/heart_menu")
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setScale(2)
    self.heart:setColor(Game:getSoulColor())
    self.heart.layer = 100
    self:addChild(self.heart)
	
	--self.up_sprite = Assets.getTexture("ui/page_arrow_up")
	--self.down_sprite = Assets.getTexture("ui/page_arrow_down")
    
    self.selected_index = 1
    self.page = 1
    
    self.heart_target_x = 74
    self.heart_target_y = 110
    self.heart:setPosition(self.heart_target_x, self.heart_target_y)

    self.songs = modRequire("scripts.jukebox_songs")
end

function JukeboxMenu:draw()
    super:draw(self)    
    love.graphics.setLineWidth(1)
    love.graphics.setColor(0, 0.4, 0)

    love.graphics.rectangle("line", 62, 75, 230, 1)
    love.graphics.rectangle("line", 62, 115, 230, 1)
    love.graphics.rectangle("line", 62, 155, 230, 1)
    love.graphics.rectangle("line", 62, 195, 230, 1)
    love.graphics.rectangle("line", 62, 235, 230, 1)
    love.graphics.rectangle("line", 62, 275, 230, 1)
    love.graphics.rectangle("line", 62, 315, 230, 1)

    love.graphics.setLineWidth(4)
    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle("line", 44, 55, 552, 1)
    love.graphics.rectangle("line", 44, 360, 276, 1)
    love.graphics.rectangle("line", 320, 56, 1, 350)
	
    love.graphics.print("Composer:\nReleased:\nOrigin:", 330, 354, 0, 0.5, 0.5)

    --song 1 info
    love.graphics.print(self.songs[self.page][1].name, 100, 78, 0, 0.5, 1)
        if self.selected_index == 1 then
            love.graphics.print(self.songs[self.page][1].composer, 394, 354, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][1].released, 394, 370, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][1].origin, 380, 386, 0, 0.5, 0.5)
        end
    --song 2 info
    love.graphics.print(self.songs[self.page][2].name, 100, 118, 0, 0.5, 1)
        if self.selected_index == 2 then
            love.graphics.print(self.songs[self.page][2].composer, 394, 354, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][2].released, 394, 370, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][2].origin, 380, 386, 0, 0.5, 0.5)
        end
    --song 3 info
    love.graphics.print(self.songs[self.page][3].name, 100, 158, 0, 0.5, 1)
        if self.selected_index == 3 then
            love.graphics.print(self.songs[self.page][3].composer, 394, 354, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][3].released, 394, 370, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][3].origin, 380, 386, 0, 0.5, 0.5)
        end
    --song 4 info
    love.graphics.print(self.songs[self.page][4].name, 100, 198, 0, 0.5, 1)
        if self.selected_index == 4 then
            love.graphics.print(self.songs[self.page][4].composer, 394, 354, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][4].released, 394, 370, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][4].origin, 380, 386, 0, 0.5, 0.5)
        end
    --song 5 info
    love.graphics.print(self.songs[self.page][5].name, 100, 238, 0, 0.5, 1)
        if self.selected_index == 5 then
            love.graphics.print(self.songs[self.page][5].composer, 394, 354, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][5].released, 394, 370, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][5].origin, 380, 386, 0, 0.5, 0.5)
        end
    --song 6 info
    love.graphics.print(self.songs[self.page][6].name, 100, 278, 0, 0.5, 1)
        if self.selected_index == 6 then
            love.graphics.print(self.songs[self.page][6].composer, 394, 354, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][6].released, 394, 370, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][6].origin, 380, 386, 0, 0.5, 0.5)
        end
    love.graphics.print("[X] Back  [C] Info", 64, 370, 0, 1, 1)
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.setFont(self.font_2)
    love.graphics.print("Page "..self.page.."/"..#self.songs.."", 140, 326)
    love.graphics.setColor(1, 1, 1)
end

function JukeboxMenu:close()
    Game.world.menu = nil
    self:remove()
end

function JukeboxMenu:update()
    --play song
    if Input.pressed("confirm", true) then
        if self.selected_index == 1 then
            Game.world.music:play(self.songs[self.page][1].file, 1)
        end
        if self.selected_index == 2 then
            Game.world.music:play(self.songs[self.page][2].file, 1)
        end
        if self.selected_index == 3 then
            Game.world.music:play(self.songs[self.page][3].file, 1)
        end
        if self.selected_index == 4 then
            Game.world.music:play(self.songs[self.page][4].file, 1)
        end
        if self.selected_index == 5 then
            Game.world.music:play(self.songs[self.page][5].file, 1)
        end
        if self.selected_index == 6 then
            Game.world.music:play(self.songs[self.page][6].file, 1)
        end
    end
    --close menu
    if Input.pressed("cancel", false) then
        Assets.playSound("ui_cancel_small")
        Game.world:closeMenu()
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
        self.heart:setPosition(self.heart_target_x, 95)
    end
    if self.selected_index == 2 then
        self.heart:setPosition(self.heart_target_x, 135)
    end
    if self.selected_index == 3 then
        self.heart:setPosition(self.heart_target_x, 175)
    end
    if self.selected_index == 4 then
        self.heart:setPosition(self.heart_target_x, 215)
    end
    if self.selected_index == 5 then
        self.heart:setPosition(self.heart_target_x, 255)
    end
    if self.selected_index == 6 then
        self.heart:setPosition(self.heart_target_x, 295)
    end
    
    if self.selected_index > 6 then
        self.selected_index = 1
    end
    if self.selected_index < 1 then
        self.selected_index = 6
    end
    if self.page > #self.songs then
        self.page = 1
    end
    if self.page < 1 then
        self.page = #self.songs
    end
end

return JukeboxMenu
