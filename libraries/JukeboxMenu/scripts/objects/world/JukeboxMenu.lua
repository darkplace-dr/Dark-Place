local JukeboxMenu, super = Class(Object)

function JukeboxMenu:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    self.layer = 100

    self.box = UIBox(60, 40, 520, 350)
    self.box.layer = -1
    self:addChild(self.box)

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("plain")

    self.jukebox_title = "JUKEBOX"

    self.jukebox_text = Text(self.jukebox_title, 60, 20, 520, 32, {style = "menu", align = "center"})
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
    self.songs_per_page = 6

    self.heart_target_x = 74
    self.heart_target_y = 110
    self.heart:setPosition(self.heart_target_x, self.heart_target_y)

    self.songs = modRequire("scripts.jukebox_songs")
    self.none_text = "---"
    self.default_song = {
        name = self.none_text,
        file = nil,
        composer = self.none_text,
        released = self.none_text,
        origin = self.none_text
    }
end

function JukeboxMenu:draw()
    super.draw(self)

    love.graphics.setLineWidth(1)
    love.graphics.setColor(0, 0.4, 0)

    for i = 1, self.songs_per_page + 1 do
        love.graphics.rectangle("line", 62, 75 + 40 * (i - 1), 230, 1)
    end

    love.graphics.setLineWidth(4)
    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle("line", 44, 55, 552, 1)
    love.graphics.rectangle("line", 44, 360, 276, 1)
    love.graphics.rectangle("line", 320, 56, 1, 350)

    love.graphics.setFont(self.font)
    local cur_page = self.songs[self.page]
    for i = 1, self.songs_per_page do
        local cur_song = cur_page[i] or self.default_song
        local name = cur_song.name or self.none_text
        local scale_x = math.min(184 / self.font:getWidth(name), 1)
        love.graphics.print(name, 100, 78 + 40 * (i - 1), 0, scale_x, 1)
    end

    local cur_song = cur_page[self.selected_index] or self.default_song
    love.graphics.print("Composer:\nReleased:\nOrigin:", 330, 354, 0, 0.5, 0.5)
    love.graphics.print(cur_song.composer or self.none_text, 394, 354, 0, 0.5, 0.5)
    love.graphics.print(cur_song.released or self.none_text, 394, 370, 0, 0.5, 0.5)
    love.graphics.print(cur_song.origin or self.none_text, 380, 386, 0, 0.5, 0.5)

    love.graphics.print("[X] Back", 64, 370, 0, 1, 1)
    love.graphics.print("[C] Info", 210, 370, 0, 1, 1)

    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.setFont(self.font_2)
    love.graphics.print("Page "..self.page.."/"..#self.songs.."", 140, 326)

    love.graphics.setColor(1, 1, 1)
end

function JukeboxMenu:update()
    --play song
    if Input.pressed("confirm", false) then
        local cur_song = self.songs[self.page][self.selected_index] or self.default_song
        if cur_song.file then
            Game.world.music:play(cur_song.file, 1)
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
    if self.selected_index > self.songs_per_page then
        self.selected_index = 1
    end
    if self.selected_index < 1 then
        self.selected_index = self.songs_per_page
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
    if self.page > #self.songs then
        self.page = 1
    end
    if self.page < 1 then
        self.page = #self.songs
    end

    --soul positions
    self.heart:setPosition(self.heart_target_x, 95 + 40 * (self.selected_index - 1))
end

function JukeboxMenu:close()
    Game.world.menu = nil
    self:remove()
end

return JukeboxMenu
