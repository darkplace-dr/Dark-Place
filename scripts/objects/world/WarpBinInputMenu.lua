local WarpBinInputMenu, super = Class(Object)

function WarpBinInputMenu:init()
    super.init(self, SCREEN_WIDTH / 2 - 288 / 2, SCREEN_HEIGHT / 2 - 40 / 2, 288, 40)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0
    self.box = UIBox(0, 0, self.width, self.height)
    self.box.layer = -1
    self.box.debug_select = false
    self:addChild(self.box)

    self.caret_flash_timer = 0

    self.font = Assets.getFont("main_mono", 32)
    self.char_w = 32
    self.char_h = self.char_w
    self.char_spacing = 5

    -- a table of lines
    self.input = {""}
    self.code_len = 8

    TextInput.attachInput(self.input, {
        multiline = false,
        enter_submits = true
    })
    TextInput.text_callback = function()
        -- Limit the Bin's Digits
        -- only uppercase letters
        self.input[1] = string.upper(string.sub(self.input[1], 1, 8))
        self.caret_flash_timer = 0
    end
    TextInput.submit_callback = function()
        if self.finish_cb then
            self.finish_cb(Mod:getBinCode(self.input[1]))
        end
        self:close()
    end

    self.finish_cb = nil
end

function WarpBinInputMenu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)

    local draw_x = 0
    local draw_y = 0
    local actual_input_len = utf8.len(self.input[1])
    for i = 1, self.code_len do
        if actual_input_len >= i then
            local char_off = utf8.offset(self.input[1], i)
            local char = self.input[1]:sub(char_off, char_off)
            love.graphics.printf(char, draw_x, draw_y, self.char_w, "center")
        end

        if i ~= (actual_input_len == self.code_len and actual_input_len or actual_input_len + 1)
            or self.caret_flash_timer <= 15 then
            local line_y = draw_y + self.char_h + 2
            love.graphics.line(draw_x, line_y, draw_x + self.char_w, line_y)
        end

        draw_x = draw_x + self.char_w + self.char_spacing
    end

    self.caret_flash_timer = (self.caret_flash_timer + 1 * DTMULT) % 30

    super.draw(self)
end

function WarpBinInputMenu:close()
    TextInput.endInput()
    Game.world.menu = nil
    self:remove()
end

return WarpBinInputMenu