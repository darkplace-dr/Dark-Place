local Squeak, super = Class(Event)

function Squeak:init(data)
    super.init(self, data)
end

function Squeak:onInteract(player, dir)
    Assets.playSound("squeak")
    Kristal.callEvent("addAchProgress", "squeaks", 1)
    return true
end

return Squeak