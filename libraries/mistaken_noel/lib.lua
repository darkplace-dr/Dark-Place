local lib = {}



    function lib:onTextSound(typing_sound, current_node)
        if typing_sound == "noel" then
            Assets.playSound("voice/"..typing_sound.."-"..string.lower(current_node.character))
        end
    end

return lib