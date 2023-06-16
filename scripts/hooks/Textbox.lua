---@class Textbox_override : Textbox
local Textbox, super = Class("Textbox", true)

function Textbox:init(x, y, width, height, default_font, default_font_size, battle_box)
    default_font = default_font
        or Kristal.callEvent("getDefaultDialogTextFont")
    super.init(self, x, y, width, height, default_font, default_font_size, battle_box)
end

return Textbox