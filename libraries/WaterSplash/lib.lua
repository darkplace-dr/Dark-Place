local lib = {}

function lib:onFootstep(char, num)
    if char == Game.world.player and char.watersplash_onwater == true then
        Assets.playSound("splash")
    end
end

return lib