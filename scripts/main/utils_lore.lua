function Mod:isInRematchMode()
    return Game.world.map.id == "thearena"
end

function Mod:setOmori(omori)
    omori = omori or false
    self.omori = omori
end

function Mod:isOmori()
    return self.omori
end

function Mod:isNight()
    local hour = os.date("*t").hour
    return hour < 8 or hour >= 21
end

function Mod:addiSwitch()
    return Game:getFlag("AddiSwitchOn", false)
end

function Mod:rollFun()
    Game:setFlag("fun", love.math.random(1, 100))
end

---@param action? "reroll"|"reset"|"none" reroll is the default
function Mod:getFunAndRoll(action)
    action = (action or "reroll"):lower()

    local ret = Game:getFlag("fun", 0)

    if action == "reroll" then
        self:rollFun()
    elseif action == "reset" then
        Game:setFlag("fun", 0)
    end

    return ret
end