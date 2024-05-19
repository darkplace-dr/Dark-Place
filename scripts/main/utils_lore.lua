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

-- Removes a party member from selection in the DarkPartyMenu
function Mod:lockPartyMember(id)
    Utils.removeFromTable(Game:getFlag("party"), id)
end

-- Sets a random title and icon to the game window.
function Mod:funnytitle()
    love.window.setIcon(Kristal.icon)
    love.window.setTitle(Kristal.getDesiredWindowTitle())
    if Utils.random() < 0.5 then return end
    local funnytitles = {
        "Deltarune",
        "Half-Life",
        "* GOD damnit KRIS where the HELL are WE!?",
        "* GOD damn YOU where the HELL are WE!?",
        "* SO, I have no fucking clue where we are.",
        "* z...z.....z.....z.......Z.........Z",
        "Kristale",
        "* \z
        WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? \z
        WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? \z
        WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT?",
        "Kris Tea",
        "* REDDIT GOLD POG!!",
        "LOOK ITS BrACON and MEGALORE!!!",
        "...",
        "Kristal",
        "Spamton Sweepstakes",
        "Includes Darkness!",
        "It's raining somewhere else...",
        "Minecraft",
        "Counter Strike Source Not Found()",
        "Grian Is Watching You.",
        "PLAY THE RIBBIT MOD, NOW!!!",
        Mod.info.name,
        "Thetaseal",
        "Undertale Yellow: The Roba Edition"
    }
    local funnytitle_rand = love.math.random(#funnytitles)
    local funnytitle = funnytitles[funnytitle_rand] or "Depa Runts"
    local funnyicon = Assets.getTextureData("ui/funny_window_icons/icon_"..tostring(funnytitle_rand)) or Kristal.icon
    love.window.setTitle(funnytitle)
    love.window.setIcon(funnyicon)
end

function Mod:isTauntingAvaliable()
    if self.let_me_taunt then return true end
    if Game.save_name:upper() == "PEPPINO" then return true end

    for _,party in ipairs(Game.party) do
        if party:checkArmor("pizza_toque") then return true end
    end
    return false
end
