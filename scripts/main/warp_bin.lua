-- Warp Bin
-- god I am so sorry for how shitty this code is

--- The thing you put in the Warp Bin to warp to places \
--- must be 8 characters long and be in upper case
---@alias WarpBinCode string

--- defines the behavior of a Warp Bin code
---@class WarpBinCodeInfo
--- what to do after the code is entered \
--- if a string, treated as a map's id and the player is teleported there \
--- if the last argument is a function, the function is run
---@field result string|fun(cutscene: WorldCutscene)
---@field marker string|nil in case result is a string, the name of the marker you want to teleport the player to

-- I'm going to cause pain and suffering with one weird trick:
-- here's the table containing any and all warp codes for the 
-- warp bin.
-- have fun :]   -Char                 (well its NOT that bad) \
-- to add new codes you'd add new entries of "type" WarpBinCodeInfo to the table below.
-- If you have sumneko's Lua LS you should be able to get nice annonations
---@type table<WarpBinCode, WarpBinCodeInfo>
Mod.warp_bin_codes = {
    ["00000000"] = { result = "warphub" },
    ["SPAMROOM"] = { result = "spamroom" },
    ["DESSHERE"] = { result = "dessstuff/dessstart" },
    ["BOSSRUSH"] = { result = "thearena" },
    ["DEVDINER"] = { result = "devhotel/devdiner/devstart" },
    ["MAUSHOLE"] = { result = "chevroom" },
    ["WIFIDOWN"] = { result = "googlefield" },
    ["UWFOREST"] = { result = "underworld_forest/uwforest_startbin" },
    ["SEAWORLD"] = { result = "underwater_temple/underwater_startbin" },
	["_CHCKPNT"] = { result = "field" },
	["DARKCADE"] = { result = "darkcade/outside", marker = "warp" },
    ["DUMBIERM"] = { result = "dumbierm" },
	["GARRYMOD"] = { result = "missing" },
	["JOHNWICK"] = { result = "archives/starting_room" },
    ["TOMBSITE"] = { result = "fwood/entry", marker = "warp" },
    ["MIRRORED"] = { result = "water_mirror", marker = "warp"},
    ["WTF1998S"] = {
        result = function(cutscene)
            cutscene:text("* Wow![wait:10]\n* You found a secret![wait:10]\n* Awesome!")
            Mod:addBinCode("SPPISPOD", function(cutscene2)
                cutscene2:text({
                    "* Since you found another one...",
                    "* Here's a fun fact:",
                    "* This was made as a way to showcase what the warp bin can do!"
                })
            end)
        end
    },
    ["SCRTACHV"] = {
        result = function(cutscene)
            if not Kristal.callEvent("earnedAch", "codebreaker") then
                Kristal.callEvent("completeAchievement", "codebreaker")
                cutscene:text("* Congratulations![wait:10] We're all so proud of you![wait:10] What a crazy achievement!")
            else
                cutscene:text("* Okay,[wait:5] are you fucking done?")
            end
        end
    },
    ["WWC1YEAR"] = { result = "dinder" },
    ["PIKNF404"] = {
        result = function(cutscene)
            cutscene:text("* Area not complete yet,[wait:5] check back in a later commit.[wait:10] -BrandonK7200")
        end
    },
}

-- heres some new totally cool helper functions wowee

--- get a Bin Code's info
---@param code WarpBinCode
---@return WarpBinCodeInfo info
function Mod:getBinCode(code)
    code = code:upper()

    return Mod.warp_bin_codes[code]
end

--- adds a code to the warp bin code table
---@param code WarpBinCode if you came from the raw table, put this as the key of your new entry
---@param result string|fun(cutscene: WorldCutscene) see WarpBinCodeInfo.result
---@param marker? string see WarpBinCodeInfo.marker
---@param overwrite? boolean whether to overwrite existing entries or not
---@return boolean success false if the code already exists and overwrite is false. just in-case someone else steals your code before you get to use it.
function Mod:addBinCode(code, result, marker, overwrite)
    code = code:upper()

    if self:getBinCode(code) and not overwrite then
        -- whoops, no success
        return false
    end

    -- lmao
    Mod.warp_bin_codes[code] = { result = result, marker = marker or "spawn" }
    return true
end

--- deletes a Bin Code
---@param code WarpBinCode
---@return boolean success false if the code doesnt exist
function Mod:deleteBinCode(code)
    code = code:upper()

    if not self:getBinCode(code) then return false end
    Mod.warp_bin_codes[code] = nil
    return true
end
