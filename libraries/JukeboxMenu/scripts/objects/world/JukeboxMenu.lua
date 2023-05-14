local JukeboxMenu, super = Class(Object)

function JukeboxMenu:init(jukebox)
    super:init(self, 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    
    self.layer = 100

    self.box = UIBox(210, 40, 240, 400)
    self.box.layer = -1
    self:addChild(self.box)
    
    self.font = Assets.getFont("menu")
    self.font_2 = Assets.getFont("plain")
    
    self.jukebox_title = "JUKEBOX"
    
    self.jukebox_text = Text(self.jukebox_title, 328, 30, 300, 200, {style = "menu"})
    local jukebox_text_obj = love.graphics.newText(self.jukebox_text:getFont(), self.jukebox_title)
    self.jukebox_text.x = 328 - Utils.round(jukebox_text_obj:getWidth()/2)
    self.jukebox_text.layer = 1
    self:addChild(self.jukebox_text)
    
    self.song_description = "Composer:\nReleased:\nOrigin:"
    
    self.song_description = Text(self.song_description, 200, 390, 300, 200, {font = "plain", style = "menu"})
    local song_description_obj = love.graphics.newText(self.song_description:getFont(), self.song_description)
    self.song_description.x = 200 - Utils.round(song_description_obj:getWidth()/2)
    self.song_description.layer = 1
    self:addChild(self.song_description)
    
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
    
    --Setting this to "false" will allow you to close the menu using the "X" button.
    self.back_button = true

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
    love.graphics.setLineWidth(4)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", 190, 380, 280, 1)
    left_arrow = Assets.getTexture("ui/flat_arrow_left")
    love.graphics.draw(left_arrow, 272, 358, 0, 1, 1)
    right_arrow = Assets.getTexture("ui/flat_arrow_right")
    love.graphics.draw(right_arrow, 372, 358, 0, 1, 1)
    --song 1 info
    love.graphics.print(self.songs[self.page][1].name, 250, 73, 0, 0.5, 1)
        if self.selected_index == 1 then
            love.graphics.print(self.songs[self.page][1].composer, 284, 390, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][1].released, 284, 410, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][1].origin, 264, 430, 0, 0.5, 0.5)
        end
    --song 2 info
    love.graphics.print(self.songs[self.page][2].name, 250, 113, 0, 0.5, 1)
        if self.selected_index == 2 then
            love.graphics.print(self.songs[self.page][2].composer, 284, 390, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][2].released, 284, 410, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][2].origin, 264, 430, 0, 0.5, 0.5)
        end
    --song 3 info
    love.graphics.print(self.songs[self.page][3].name, 250, 153, 0, 0.5, 1)
        if self.selected_index == 3 then
            love.graphics.print(self.songs[self.page][3].composer, 284, 390, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][3].released, 284, 410, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][3].origin, 264, 430, 0, 0.5, 0.5)
        end
    --song 4 info
    love.graphics.print(self.songs[self.page][4].name, 250, 193, 0, 0.5, 1)
        if self.selected_index == 4 then
            love.graphics.print(self.songs[self.page][4].composer, 284, 390, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][4].released, 284, 410, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][4].origin, 264, 430, 0, 0.5, 0.5)
        end
    --song 5 info
    love.graphics.print(self.songs[self.page][5].name, 250, 233, 0, 0.5, 1)
        if self.selected_index == 5 then
            love.graphics.print(self.songs[self.page][5].composer, 284, 390, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][5].released, 284, 410, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][5].origin, 264, 430, 0, 0.5, 0.5)
        end
    --song 6 info
    love.graphics.print(self.songs[self.page][6].name, 250, 273, 0, 0.5, 1)
        if self.selected_index == 6 then
            love.graphics.print(self.songs[self.page][6].composer, 284, 390, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][6].released, 284, 410, 0, 0.5, 0.5)
            love.graphics.print(self.songs[self.page][6].origin, 264, 430, 0, 0.5, 0.5)
        end
        if self.back_button == true then
            love.graphics.print("Back", 298, 318)
        end
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.setFont(self.font_2)
    love.graphics.print("Page "..self.page.."/"..#self.songs.."", 290, 356)
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
    if self.page > #self.songs then
        self.page = 1
    end
    if self.page < 1 then
        self.page = #self.songs
    end
end

return JukeboxMenu