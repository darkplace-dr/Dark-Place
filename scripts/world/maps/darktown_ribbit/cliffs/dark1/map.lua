local Dark1, super = Class(Map)

function Dark1:onEnter()
    super.onEnter(self)
    Game:setFlag("footsteps", true)
end

function Dark1:onExit()
    super.onExit(self)
    Game:setFlag("footsteps", false)
end

return Dark1