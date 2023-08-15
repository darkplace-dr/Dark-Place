if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("LightSaveMenu")
end

---@class LightSaveMenu
local LightSaveMenu, super = Class("LightSaveMenu", true)

function LightSaveMenu:update()
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

return LightSaveMenu