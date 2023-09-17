local AlleyZero, super = Class(Map)

-- Only reason this should happen is if someone debugs into the room.
function AlleyZero:onEnter()
    --Game.world:loadMap("misc/dogcheck")
end

return AlleyZero