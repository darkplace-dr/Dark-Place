local Squeak, super = Class(Event)

function Squeak:init(data)
    super.init(self, data)
end

function Squeak:onInteract(player, dir)
    Assets.playSound("squeak")
    if not Kristal.libCall("achievements", "hasAch", "squeaks") then
        Kristal.callEvent("addAchProgress", "squeaks", 1)
    end
    return true
end

return Squeak