function Mod:checkNoel()
    local noelsave = Mod:loadGameN()
    if not noelsave then return end
    if Game:hasPartyMember("noel") then
        if noelsave.SaveID ~= Game:getFlag("noel_SaveID") then
            Game:removePartyMember("noel")
            Game.world:removeFollower("noel")
            local noel = Game.world:getCharacter("noel")
            if noel then noel:remove() end
            Mod:loadNoel(noelsave)
        end
    end
end

function Mod:loadNoel(noelsave)
    local savedData = noelsave
    local map = Game.world.map.id

    if not Utils.containsValue(Game.party, "noel") then
        Game:setFlag("noel_party", false)
    else
        Game:setFlag("noel_party", true)
    end

    local inparty = Game:getFlag("noel_party")
    if savedData.Map == "devhotel/devdiner/partyroom" or Game:getFlag("noel_at") == "devhotel/devdiner/partyroom" then
        if inparty then
            Game:setFlag("noel_partyroom", false)
        else
            Game:setFlag("noel_partyroom", true)
            Game:setFlag("noel_party", false)
        end
    end
    if savedData.Map == map and savedData.SaveID ~= Game:getFlag("noel_SaveID") and not inparty then

        local w1, w2 = 514, 98
        if Game:getFlag("ceroba_party") then
            w1, w2 = 404, 98
        end
        local spawnPositions = {
            warphub = {384, 361, {cutscene = "noel.found_again", animation = "brella"}},
            saloon = {w1, w2},
            room1 = {400, 740},
            ["cybercity/alley2"] = {2110, 750},
            ["devhotel/devdiner/devstart"] = {320, 190},
            ["backrooms/entrance"] = {500, 420},
            ["floor2/lounge"] = {420, 385},
            ["floor3/pre_elevator"] = {640, 260},
            deoxtest = {1420, 180},
            ["cybercity/alley1"] = {210, 260},
            ["fwood/entry"] = {570, 140},
            ["castle_path/start"] = {150, 400},
            ["christmas/outside/outside_7"] = {150, 205},
            ["darkcade/floor1"] = {562, 438}
        }

        local position = spawnPositions[savedData.Map]
        if position then
            if position[3] then
                Mod:spawnNoel(position[1], position[2], position[3])
            else
                Mod:spawnNoel(position[1], position[2])
            end
        end
    else
        Mod:checkNoel()
    end
end

function Mod:spawnNoel(x, y, data)
    if Game:hasPartyMember("noel") then
        Mod:checkNoel()
    else
        if data then
            Game.world:spawnNPC("noel", x, y, data)
        else
            Game.world:spawnNPC("noel", x, y, {cutscene = "noel.found_again"})
        end
    end
end

local save_dir = "saves/"..Mod.info.id
local n_save = save_dir.."/null.char"

function Mod:saveGameN(data)
    local existingData = {}
    if love.filesystem.getInfo(n_save) then
        local contents, _ = love.filesystem.read(n_save)
        if contents then
            existingData = JSON.decode(contents)
        end
    end
    for k, v in pairs(data) do
        existingData[k] = v
    end

    love.filesystem.createDirectory(save_dir)
    love.filesystem.write(n_save, JSON.encode(existingData))
end

function Mod:loadGameN()
    if love.filesystem.getInfo(n_save) then
        local data = JSON.decode(love.filesystem.read(n_save))
        return data
    else
        return false
    end
end

function Mod:findDifferenceIndex(text, text2)
    local minLen = math.min(#text, #text2)
    for i = 1, minLen do
        if text:sub(i, i) ~= text2:sub(i, i) then
            return i
        end
    end
    return minLen
end