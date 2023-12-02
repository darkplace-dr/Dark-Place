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
---@field marker? string in case result is a string, the name of the marker you want to teleport the player to
---@field cond? fun():boolean If defined, this must return true for the player to be allowed to warp.
---@field flagcheck? string the name of a flag that must be true or be equal to flagvalue for the player to be allowed to warp. If this is prefixed with an !, then the condition is inverted
---@field flagvalue? any the value that the flag in flagcheck should be equal to

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
    ["WTF1998S"] = {
        result = function(cutscene)
            Game:setFlag("wb_wtf1998s", true)
            cutscene:text("* Wow![wait:10]\n* You found a secret![wait:10]\n* Awesome!")
        end
    },
    ["SPPISPOD"] = {
        result = function(cutscene)
            cutscene:text("* Since you found another one...")
            cutscene:text("* Here's a fun fact:")
            cutscene:text("* This was made as a way to showcase what the warp bin can do!")
        end,
        flagcheck = "wb_wtf1998s"
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
    ["CASTLERD"] = { result = "castle_path/start" }
}

--- get a Bin Code's info
---@param code WarpBinCode
---@return WarpBinCodeInfo info
function Mod:getBinCode(code)
    code = code:upper()

    return Mod.warp_bin_codes[code]
end

-- the actual logic is implemented in scripts/world/cutscenes/spamroom.lua -> warpbin