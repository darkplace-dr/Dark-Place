---@class WarpBinInputMenu : Object
---@field finish_cb? fun(action?: WarpBinCodeInfo, raw_input?: string)
local WarpBinInputMenu, super = Class("Object")

function WarpBinInputMenu:init(length)
    length = length or 8
    super.init(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 36 * length, 40)

    self:setParallax(0, 0)
    self:setOrigin(0.5, 0.5)

    self.draw_children_below = 0
    self.box = UIBox(0, 0, self.width, self.height)
    self.box.layer = -1
    self.box.debug_select = false
    self:addChild(self.box)

    ---@type love.Font
    self.font = Assets.getFont("main_mono", 32)
    self.char_w = 32
    self.char_h = self.char_w
    self.char_spacing = 5

    -- yes, a table of lines. that's what the TextInput API
    -- asks for
    self.input = {""}
    self.code_len = length

    self.cancellable = true

    -- affects whether we query the bincode list or not
    self.as_warp_bin_ui = true
    self.finish_cb = nil
end

function WarpBinInputMenu:onAdd(...)
    super.onAdd(...)

    TextInput.attachInput(self.input, {
        multiline = false,
        enter_submits = true,
        text_restriction = function(c)
            if utf8.len(self.input[1]) == self.code_len then return false end
            if c == " " then return false end
            return c:upper()
        end
    })
    TextInput.text_callback = function()
        self.input[1] = Utils.sub(self.input[1], 1, self.code_len)
    end
    TextInput.submit_callback = function()
        if self.finish_cb then
            self.finish_cb((self.as_warp_bin_ui or nil) and Mod:getBinCode(self.input[1]), self.input[1])
        end
        self:remove()
    end
end

function WarpBinInputMenu:draw()
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

        if i ~= math.min(TextInput.cursor_x + 1, self.code_len) or TextInput.flash_timer < 0.5 then
            local line_y = draw_y + self.char_h + 2
            love.graphics.line(draw_x, line_y, draw_x + self.char_w, line_y)
        end

        draw_x = draw_x + self.char_w + self.char_spacing
    end

    super.draw(self)
end

function WarpBinInputMenu:update()
    if not OVERLAY_OPEN then
        if self.cancellable
            -- FIXME
            and (Input.pressed("shift") or Input.pressed("gamepad:b")) then
            if self.finish_cb then
                self.finish_cb(nil, nil)
            end
            self:remove()
        end
    end

    super.update(self)
end

function WarpBinInputMenu:endInput()
    TextInput.endInput()
end

function WarpBinInputMenu:onRemove(parent)
    super.onRemove(self, parent)

    self:endInput()
end

return WarpBinInputMenu