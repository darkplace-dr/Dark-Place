local Dark2, super = Class(Map)

function Dark2:onEnter()
    super.onEnter(self)
    Game:setFlag("footsteps", true)
end

function Dark2:onExit()
    super.onExit(self)
    Game:setFlag("footsteps", false)
end

return Dark2