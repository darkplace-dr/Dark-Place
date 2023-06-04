local JukeboxMenu, super = Class(Object)

function JukeboxMenu:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    self.layer = WORLD_LAYERS["ui"]

    self.box = UIBox(60, 40, 520, 350)
    self.box.layer = -1
    self:addChild(self.box)

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("plain")

    self.heart = Sprite("player/heart_menu")
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setScale(2)
    self.heart:setColor(Game:getSoulColor())
    self.heart.layer = 1
    self.heart_target_x = 74
    self.heart_target_y = 95
    self.heart:setPosition(self.heart_target_x, self.heart_target_y)
    self:addChild(self.heart)

    self.songs = modRequire("scripts.jukebox_songs")
    self.none_text = "---"
    self.default_song = {
        name = self.none_text,
        file = nil,
        composer = self.none_text,
        released = self.none_text,
        origin = self.none_text
    }

    self.selected_index = 1
    self.page = 1
    self.max_pages = math.ceil(#self.songs / 6)
    self.songs_per_page = 6

    self.selected_index_memory = {}
    for i = 1, self.max_pages do
        self.selected_index_memory[i] = 1
    end
end

function JukeboxMenu:getPage(page)
    local start_index = 1 + (page-1) * self.songs_per_page
    return {unpack(self.songs, start_index, math.min(start_index + self.songs_per_page, #self.songs))}
end

function JukeboxMenu:draw()
    super.draw(self)

	love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.printf("JUKEBOX", 60, 20, self.box.width, "center")

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

    local cur_page = self:getPage(self.page)
    for i = 1, self.songs_per_page do
        local cur_song = cur_page[i] or self.default_song
        local name = cur_song.name or self.none_text
        local scale_x = math.min(184 / self.font:getWidth(name), 1)
        love.graphics.print(name, 100, 78 + 40 * (i - 1), 0, scale_x, 1)
        love.graphics.setColor(1, 1, 1)
    end

    local cur_song = cur_page[self.selected_index] or self.default_song
    love.graphics.print("Composer:\nReleased:\nOrigin:", 330, 354, 0, 0.5, 0.5)
    love.graphics.print(cur_song.composer or self.none_text, 394, 354, 0, 0.5, 0.5)
    love.graphics.print(cur_song.released or self.none_text, 394, 370, 0, 0.5, 0.5)
    love.graphics.print(cur_song.origin or self.none_text, 380, 386, 0, 0.5, 0.5)

    love.graphics.print("[X] Back", 64, 370, 0, 1, 1)
    love.graphics.print("[C] Info", 200, 370, 0, 1, 1)

    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.setFont(self.font_2)
    love.graphics.print("Page "..self.page.."/"..self.max_pages.."", 140, 326)

    love.graphics.setColor(1, 1, 1)
end

function JukeboxMenu:update()
    --play song
    if Input.pressed("confirm", false) then
        local cur_song = self:getPage(self.page)[self.selected_index] or self.default_song
        if cur_song.file then
            Game.world.music:play(cur_song.file, 1)
        end
    end

    --close menu
    if Input.pressed("cancel", false) then
        Assets.playSound("ui_cancel_small")
        Game.world:closeMenu()
    end

    --page left
    if Input.pressed("left", true) then
        Assets.playSound("ui_move")
        self.page = self.page - 1
        self.selected_index = self.selected_index_memory[self.page]
    end
    --page right
    if Input.pressed("right", true) then
        Assets.playSound("ui_move")
        self.page = self.page + 1
        self.selected_index = self.selected_index_memory[self.page]
    end
    self.page = Utils.clamp(self.page, 1, self.max_pages)

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
    self.selected_index = Utils.clamp(self.selected_index, 1, self.songs_per_page)
    self.selected_index_memory[self.page] = self.selected_index

    --soul positions
    self.heart_target_y = 95 + 40 * (self.selected_index - 1)
    if (math.abs((self.heart_target_x - self.heart.x)) <= 2) then
        self.heart.x = self.heart_target_x
    end
    if (math.abs((self.heart_target_y - self.heart.y)) <= 2)then
        self.heart.y = self.heart_target_y
    end
    self.heart.x = self.heart.x + ((self.heart_target_x - self.heart.x) / 2) * DTMULT
    self.heart.y = self.heart.y + ((self.heart_target_y - self.heart.y) / 2) * DTMULT
end

function JukeboxMenu:close()
    Game.world.menu = nil
    self:remove()
end

return JukeboxMenu
