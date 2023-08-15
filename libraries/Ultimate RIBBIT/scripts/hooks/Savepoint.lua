if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("Savepoint")
end

local Savepoint, super = Class("Savepoint", true)

function Savepoint:onInteract(player, dir)
    Assets.playSound(Kristal.callEvent("isLeaderRibbit") and "powerfrog" or "power")

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

function Savepoint:onTextEnd()
    super.onTextEnd(self)

    Assets.stopSound("powerfrog")
end

return Savepoint