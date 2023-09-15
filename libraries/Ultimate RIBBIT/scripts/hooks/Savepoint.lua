if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("Savepoint")
end

local Savepoint, super = Class("Savepoint", true)

function Savepoint:onInteract(player, dir)
    if Kristal.callEvent("isLeaderRibbit") then
        Assets.playSound("powerfrog")
    elseif not Kristal.callEvent("isLeaderRibbit") then -- Don't know WHY I need to specify this, but "power" plays anyway if I make it just "else".
        Assets.playSound("power")
    end

    if self.text_once and self.used then
        self:onTextEnd()
        return
    end

    if self.text_once then
        self.used = true
    end

    super.super.onInteract(self, player, dir)
    return true
end

--[[
function Savepoint:onTextEnd()
    super.onTextEnd(self)

    Assets.stopSound("powerfrog")
end
--]]

return Savepoint