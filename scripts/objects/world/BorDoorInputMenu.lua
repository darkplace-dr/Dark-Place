---@class BorDoorInputMenu : Object
local BorDoorInputMenu, super = Class(Object)

function BorDoorInputMenu:init()
    local w = 288
    local h = 40
    super.init(self, SCREEN_WIDTH / 2 - w / 2, SCREEN_HEIGHT / 2 - h / 2, w, h)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0
    self.box = UIBox(0, 0, self.width, self.height)
    self.box.layer = -1
    self.box.debug_select = false
    self:addChild(self.box)

    self.caret_flash_time = 30
    self.caret_flash_timer = 0

    self.font = Assets.getFont("main_mono", 32)
    self.char_w = 32
    self.char_h = self.char_w
    self.char_spacing = 5

    -- a table of lines (except our input is not multiline)
    self.input = {""}
    self.code_len = 8

    ---@type function|nil
    self.finish_cb = nil

    TextInput.attachInput(self.input, {
        multiline = false,
        enter_submits = true,
        text_restriction = function(c)
            if utf8.len(self.input[1]) == self.code_len then return end
            self.caret_flash_timer = 0
            return c:upper()
        end
    })
    TextInput.pressed_callback = function(c)
        self.caret_flash_timer = 0
    end
    TextInput.text_callback = function()
        self.input[1] = Utils.sub(self.input[1], 1, self.code_len)
    end
    TextInput.submit_callback = function()
        if self.finish_cb then
            --self.finish_cb(Mod:getBinCode(self.input[1]))
            self.finish_cb("isuckass")
        end
        Game.world:closeMenu()
    end
end

function BorDoorInputMenu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)

    local draw_x = 0
    local draw_y = 0
    local actual_input_len = utf8.len(self.input[1])
    assert(actual_input_len <= self.code_len)
    for i = 1, self.code_len do
        if actual_input_len >= i then
            local char = Utils.sub(self.input[1], i, i)
            love.graphics.printf(char, draw_x, draw_y, self.char_w, "center")
        end

        if i ~= (actual_input_len == self.code_len and actual_input_len or actual_input_len + 1)
            or self.caret_flash_timer <= self.caret_flash_time / 2 then
            local line_y = draw_y + self.char_h + 2
            love.graphics.line(draw_x, line_y, draw_x + self.char_w, line_y)
        end

        draw_x = draw_x + self.char_w + self.char_spacing
    end

    self.caret_flash_timer = (self.caret_flash_timer + 1 * DTMULT) % self.caret_flash_time

    super.draw(self)
end

function BorDoorInputMenu:close()
    TextInput.endInput()
    Game.world.menu = nil
    self:remove()
end

return BorDoorInputMenu
