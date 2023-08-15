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

-- Randomizes fun
function Mod:rollFun()
    Game:setFlag("fun", love.math.random(1, 100))
end

-- Adds a party member for selection in the DarkPartyMenu
function Mod:unlockPartyMember(id)
    table.insert(Game:getFlag("party"), id)
end