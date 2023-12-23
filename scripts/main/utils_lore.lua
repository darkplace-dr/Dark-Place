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

-- Randomizes fun
---@param avoid_collide? boolean whether to ensure that the new value is different from the last one. defaults to true
function Mod:rollFun(avoid_collide)
    if avoid_collide == nil then avoid_collide = true end

    local min, max = 1, 100
    if not avoid_collide then
        Game:setFlag("fun", love.math.random(min, max))
    else
        local old_fun = Game:getFlag("fun")
        local new_fun
        while new_fun == nil or new_fun == old_fun do
            new_fun = love.math.random(min, max)
        end
        Game:setFlag("fun", new_fun)
    end

    return Game:getFlag("fun")
end

-- Adds a party member for selection in the DarkPartyMenu
function Mod:unlockPartyMember(id)
    table.insert(Game:getFlag("party"), id)
end