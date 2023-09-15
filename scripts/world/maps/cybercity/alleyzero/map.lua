local AlleyZero, super = Class(Map)

-- Only reason this should happen is if someone debugs into the room.
function AlleyZero:onEnter()
    error("This area is incomplete. Please come back later.")
end

return AlleyZero