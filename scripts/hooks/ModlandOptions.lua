---@class ModlandOptions : ModlandOptions
---@overload fun(menu: FileSelectMenu): ModlandOptions
local ModlandOptions, super = Class(ModlandOptions)

function ModlandOptions:onKeyPressed(key)
    super.onKeyPressed(self,key)
    if Input.isCancel(key) then
        Assets.stopSound("ui_move")
        Assets.stopAndPlaySound("ui_cancel")
    end
end

return ModlandOptions