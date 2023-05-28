local WobblyThingMap, super = Class(Map)

function WobblyThingMap:onEnter()
    super.onEnter(self)
    Game:setFlag("footsteps", true)
end

function WobblyThingMap:onExit()
    super.onExit(self)
    Game:setFlag("footsteps", false)
end

return WobblyThingMap