if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return SimpleSaveMenu
end

---@class SimpleSaveMenu
local SimpleSaveMenu, super = Class("SimpleSaveMenu", true)

function SimpleSaveMenu:update()
    -- yes
    local _playSound = Assets.playSound
    Assets.playSound = function(sound, ...)
        if sound == "save" and Kristal.callEvent("isLeaderRibbit") then
            sound = "savefrog"
        end
        return _playSound(sound, ...)
    end
    local result, info = pcall(super.update, self)
    Assets.playSound = _playSound
    if not result then error(info) end
end

return SimpleSaveMenu