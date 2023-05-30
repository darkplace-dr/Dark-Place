local Dark1A, super = Class(Map)

function Dark1A:onEnter()
    super.onEnter(self)
    Game:setFlag("footsteps", true)
end

function Dark1A:onExit()
    super.onExit(self)
    Game:setFlag("footsteps", false)
end

return Dark1A