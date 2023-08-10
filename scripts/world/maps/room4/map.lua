local Room1, super = Class(Map)

function Room1:onEnter()
    super.onEnter(self)

    if Game:getFlag("mrbeast_greatdoorunlocked", false) == true then
        Game.world.map:getEvent("giantdarkdoor").tile = 1
    else
        Game.world.map:getEvent("giantdarkdoor").tile = 0
    end

end

function Room1:onExit()
    super.onExit(self)
end

return Room1