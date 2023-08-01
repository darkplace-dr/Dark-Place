---@class Choicebox
local Choicebox, super = Class("Choicebox")

function Choicebox:init(x, y, width, height, battle_box, options)
    super.init(self, x, y, width, height, battle_box, options)

    self.font = Assets.getFont(
        (options and options["font"])
        or Kristal.callEvent("getDefaultDialogNonMonospacedFont")
        or Kristal.callEvent("getDefaultDialogTextFont")
        or "main"
    )
end

return Choicebox