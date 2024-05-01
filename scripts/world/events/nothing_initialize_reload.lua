---@class NothingMapInitializeReload : Interactable
local NothingMapInitializeReload, super = Class("Interactable")

function NothingMapInitializeReload:onInteract(...)
    Kristal.quickReload("save")
    return true
end

return NothingMapInitializeReload