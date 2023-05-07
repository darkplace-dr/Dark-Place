local lib = {}

function lib:onTextSound(sound, node)
    if sound == "wingdings" then
        local ranNum = love.math.random(1, 7)
        if ranNum == 1 then
            Assets.playSound("voice/wingding_1")
        elseif ranNum == 2 then
            Assets.playSound("voice/wingding_2")
        elseif ranNum == 3 then
            Assets.playSound("voice/wingding_3")
        elseif ranNum == 4 then
            Assets.playSound("voice/wingding_4")
        elseif ranNum == 5 then
            Assets.playSound("voice/wingding_5")
        elseif ranNum == 6 then
            Assets.playSound("voice/wingding_6")
        elseif ranNum == 7 then
            Assets.playSound("voice/wingding_7")
        end
        return true
    end
end

return lib