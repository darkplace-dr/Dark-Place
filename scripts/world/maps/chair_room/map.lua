local Chair_Room, super = Class(Map)

function Chair_Room:onEnter()
    Game:setFlag("gonergirl", nil)

    for i,v in ipairs(Game.world.followers) do
        v:remove()
    end

    local transition = Game.world.map:getEvent("transition")
    if transition then
        transition.target.map = Mod.lastMap
    end
end

return Chair_Room