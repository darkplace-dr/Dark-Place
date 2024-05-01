---@class DialogueText
local DialogueText, super = Class("DialogueText")

function DialogueText:init(text, x, y, w, h, options)
    if type(w) == "table" then
        options = w
        w, h = SCREEN_WIDTH, SCREEN_HEIGHT
    end
    options = options or {}

    options["style"] = options["style"]
        or Kristal.callEvent("getDefaultDialogTextStyle")
        or (Game:isLight() and "none" or "dark")
    options["font"] = options["font"]
        or Kristal.callEvent("getDefaultDialogTextFont")
        or "main_mono"

    super.init(self, text, x, y, w, h, options)
end

function DialogueText:update()
    local speed = self.state.speed

    if not OVERLAY_OPEN then
        if Input.pressed("menu") then
            self.fast_skipping_timer = 1
        end

        local input = self.can_advance and
            -- Prevent wrist protector skipping if a menu is waiting for an input. There's probably a better way to check for this, but I can't be assed.
            (Input.pressed("confirm") or (Input.down("menu") and self.fast_skipping_timer >= 1 and not Input.component_stack[1]))

        if input or self.auto_advance or self.should_advance then
            self.should_advance = false
            if not self.state.typing then
                self:advance()
            end
        end

        if Input.down("menu") then
            if self.fast_skipping_timer < 1 then
                self.fast_skipping_timer = self.fast_skipping_timer + DTMULT
            end
        else
            self.fast_skipping_timer = 0
        end

        if self.skippable and ((Input.down("cancel") and not self.state.noskip) or (Input.down("menu") and not self.state.noskip)) then
            if not self.skip_speed then
                self.state.skipping = true
            else
                speed = speed * 2
            end
        end
    end

    if self.state.waiting == 0 then
        self.state.progress = self.state.progress + (DT * 30 * speed)
    else
        self.state.waiting = math.max(0, self.state.waiting - DT)
    end

    if self.state.typing then
        self:drawToCanvas(function ()
            while (math.floor(self.state.progress) > self.state.typed_characters) or self.state.skipping do
                local current_node = self.nodes[self.state.current_node]

                if current_node == nil then
                    self.state.typing = false
                    break
                end

                self:playTextSound(current_node)
                self:processNode(current_node, false)

                if self.state.skipping then
                    self.state.progress = self.state.typed_characters
                end

                self.state.current_node = self.state.current_node + 1
            end
        end)
    end

    self:updateTalkSprite(self.state.talk_anim and self.state.typing)

    super.super.update(self)

    self.last_talking = self.state.talk_anim and self.state.typing
end

return DialogueText