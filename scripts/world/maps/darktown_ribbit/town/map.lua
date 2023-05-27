local Town, super = Class(Map)

function Town:onEnter()
    super.onEnter(self)
    Game:setFlag("footsteps", true)
end

function Town:onExit()
    super.onExit(self)
    Game:setFlag("footsteps", false)
end

return Town