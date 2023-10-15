local AlleyZero, super = Class(Map)

function AlleyZero:onEnter()
    -- Only reason this should happen is if someone debugs into the room.
    --Game.world:loadMap("misc/dogcheck")

    if Game:getFlag("zero_defeated") == true then
        Game.world.map:getEvent(5):remove()
    end
    if Game.inventory:isFull("armors") then
        local textbox = Interactable(350, 240, 40, 120, {
            text1 = "* (The 48 ARMORs in your pockets seem to have tripped some kind of security measure.)"
        })
        Game.world:addChild(textbox)

    end
end

return AlleyZero