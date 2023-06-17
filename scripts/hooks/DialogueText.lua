---@class DialogueText_override : DialogueText
---@overload fun(...) : DialogueText
local DialogueText, super = Class("DialogueText", true)

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

return DialogueText