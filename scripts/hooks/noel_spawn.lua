local null = {}

function Mod:onActionSelect(battler, button)
    if button.type == "tension" then
        Game.battle:pushAction("TENSION", nil, {tp = -32})
    end
end

    function Mod:getActionButtons(battler, buttons)
        
        if battler.chara.id == "noel" then
                return {"magic", "item", "spare", "tension"}
        end
        return buttons
    end

function Mod:checkNoel()
    local noelsave = Mod:loadGameN()
    if Game:hasPartyMember("noel") then
        if noelsave.SaveID ~= Game:getFlag("noel_SaveID") then
            Game:removePartyMember("noel")
            Game.world:removeFollower("noel")
            local noel = Game.world:getCharacter("noel")
            if noel then noel:remove() end
            Mod:LoadNoel(noelsave)
        end
    end
end

function Mod:LoadNoel(noelsave)
    local savedData = noelsave
    local map = Game.world.map.id

    local inparty = Game:getFlag("noel_party")

        if savedData.Map == "devhotel/devdiner/partyroom" or Game:getFlag("noel_at") == "devhotel/devdiner/partyroom" then
            if inparty then
                Game:setFlag("noel_partyroom", false)
            else
                Game:setFlag("noel_partyroom", true)
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

function Mod:onTextSound(typing_sound, current_node)
    if typing_sound == "noel" then
            
        Assets.playSound("voice/noel/"..string.lower(current_node.character), 1, 1)
        --print(string.lower(current_node.character))
    end
end

Utils.hook(Map, "onEnter", function(orig, self, ...)
    orig(self)

    -- its for the greater good, or somthin

    local noelsave = Mod:loadGameN()
    if noelsave then
        Mod:LoadNoel(noelsave)
    end

end)

function Mod:saveGameN(data)
    local existingData = {}
    if love.filesystem.getInfo("saves/dark_place/null.char") then
        local contents, size = love.filesystem.read("saves/dark_place/null.char")
        if contents then
            existingData = JSON.decode(contents)
        end

    end
    for k, v in pairs(data) do
        existingData[k] = v
    end

    love.filesystem.createDirectory("saves/dark_place")
    love.filesystem.write("saves/dark_place/null.char", JSON.encode(existingData))
end

function Mod:loadGameN()
    local path = "saves/dark_place/null.char"
    if love.filesystem.getInfo(path) then
        local data = JSON.decode(love.filesystem.read(path))
        return data
    else
        return false
    end
end


        function findDifferenceIndex(text, text2)
            local minLen = math.min(#text, #text2)
            for i = 1, minLen do
                if text:sub(i, i) ~= text2:sub(i, i) then
                    return i
                end
            end
            return minLen
        end


        function Mod:UndoMyFuckup(cutscene, text, text2, speaker, texts, faces)
            local len = string.len(text2)
            local len2 = string.len(text)

            local dif = findDifferenceIndex(text, text2)

            local fin2 = string.sub(text2, dif, len)

            local currentIndex = 1

            local function nextTag()
                local nextText = texts[currentIndex]
                currentIndex = (currentIndex % #texts) + 1
                return nextText
            end

            -- I feel like there should be a better way to do this.
            local isU = true
            local function toggleCase(text)
                if isU then
                    isU = false
                    return string.lower(text)
                else
                    isU = true
                    return string.upper(text)
                end
            end
            
            cutscene:text(text, "neutral", speaker, {auto = true})

            for i = 1, len2 do
                local rface = faces[math.random(1, #faces)]

                local current = string.sub(text, 1, dif - 1)
                local current2 = string.sub(text, dif, len2 - i)
                if i == len2 then
                    cutscene:showNametag("Noel", { top = true, right = false})
                    cutscene:text("[instant]"..current.."[stopinstant]"..fin2, "neutral", speaker)
                else
                    cutscene:showNametag(nextTag(), { top = true, right = false})
                    --I use speed instead of instant because of the funny sound it makes.
                    cutscene:text("[speed:30]"..toggleCase(current).."[shake:5]"..current2, rface, speaker, {auto = true})
                end
            end
        end
        
        -- This fucking scares me so much, but it works.





return null