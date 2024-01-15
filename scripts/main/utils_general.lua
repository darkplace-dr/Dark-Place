function Mod:registerShaders()
    self.shaders = {}
    for _,path,shader in Registry.iterScripts("shaders/") do
        assert(shader ~= nil, '"shaders/'..path..'.lua" does not return value')
        self.shaders[path] = shader
    end
end

--- Returns the current party leader's PartyMember, Actor, ActorSprite, Character or PartyBattler object
---@param kind? "partymember"|"party"|"character"|"chara"|"actor"|"sprite"|"actorsprite"|"battler"|"partybattler" The kind of object that will be gathered, "partymember" by default
---@return PartyMember|Actor|ActorSprite|Character|PartyBattler|nil obj A object related to the leader.
function Mod:getLeader(kind)
    kind = (kind or "partymember"):lower()

    local leader = Game.party[1]
    if not leader then return nil end

    if kind == "character" or kind == "chara" then
        if not Game.world then return nil end
        return Game.world:getCharacter(leader.id)
    elseif kind == "actor" then
        return leader.actor
    elseif kind == "sprite" or kind == "actorsprite" then
        local chara = self:getLeader("character")
        if not chara then return nil end
        return chara.sprite
    elseif kind == "battler" or kind == "partybattler" then
        if not Game.battle then return nil end
        return Game.battle:getPartyBattler(leader.id)
    end
    return leader --[[ if kind == "partymember" or kind == "party" ]]
end

-- Get the average LOVE for the whole party \
-- Note that the result absolutely can be a double. Round if necessary.
--- @return number love # The LOVE of the party
function Mod:getPartyLove()
    local sum_love = 0
    for _,char in ipairs(Game.party) do
        sum_love = sum_love + char:getLOVE()
    end
    return sum_love/#Game.party
end

-- Check if a file exists in the AppData/Home folder.
-- Can/Will be used to check if the player has played certain games like Undertale or Deltarune.
--- @return boolean exists
function Mod:fileExists(name)
    local f
    local path = ""
    if love.system.getOS() == "Windows" then
        path = string.gsub(os.getenv('UserProfile'), "\\", "/").."/AppData/"..name
    elseif love.system.getOS() == "OS X" then
        path = os.getenv('HOME').."/Library/"..name
    elseif love.system.getOS() == "Linux" then
        path = os.getenv('HOME').."/"..name
    end
    f = io.open(path, "r")
    return f ~= nil and io.close(f)
end

-- Directly check if a Kristal mod has any save files using Mod:fileExists()
--- @return boolean exists
function Mod:hasSaveFiles(id)
    local paths = {
        "LOVE/kristal/saves/", -- Source code version
        "kristal/saves/",      -- Executable version
        id.."/saves/",         -- Executable version but changed Kristal's id in conf.lua
    }

    for i,v in ipairs(paths) do
        if love.system.getOS() == "Windows" then
            paths[i] = "Roaming/"..v
        elseif love.system.getOS() == "OS X" then
            paths[i] = "Application Support/"..v
        elseif love.system.getOS() == "Linux" then
            paths[i] = ".local/share/"..v
        end
    end

    for i,path in ipairs(paths) do
        for i=1,3 do
            if Mod:fileExists(path..id.."/file_"..i..".json") then
                return true
            end
        end

        if Mod:fileExists(path..id.."/file_wii.json") then
            return true
        end
    end

    return false
end