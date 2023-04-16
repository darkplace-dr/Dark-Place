-- Warp Bin
-- god I am so sorry for how shitty this code is

---@class WarpBinCodeInfo
--- what to do after the code is entered. \
--- if a string, treated as a map's id and the player is teleported there; \
--- if the last argument is a function, the function is run
---@field result string|function
---@field marker string|nil in case result is a string, the name of the marker you want to teleport the player to

-- I'm going to cause pain and suffering with one weird trick:
-- here's the table containing any and all warp codes for the warp bin
-- have fun :]   -Char
-- well its NOT that bad

-- for reference, to add new codes you'd add tables to the table below
-- see Mod:addBinCode for
---@type table<string, WarpBinCodeInfo>
Mod.warp_bin_codes = {
    ["00000000"] = { result = "warphub" },
    ["spamroom"] = { result = "spamroom" },
    ["desshere"] = { result = "dessstuff/dessstart" },
    ["wtf1998s"] = {
        result = function(cutscene)
            cutscene:text("* Wow![wait:10]\n* You found a secret![wait:10]\n* Awesome!")
            Mod:addBinCode("sppispod", function(cutscene2)
                cutscene2:text({
                    "* Since you found another one...",
                    "* Here's a fun fact:",
                    "* This was made as a way to showcase what the warp bin can do!"
                })
            end)
        end
    },
    ["bossrush"] = { result = "thearena" },
    ["devdiner"] = { result = "devstart" },
}

-- heres some new totally cool helper functions wowee

--- get a Bin Code's info
---@param code string
---@return WarpBinCodeInfo info
function Mod:getBinCode(code)
    return Mod.warp_bin_codes[code:lower()]
end

--- adds a code to the warp bin code table
---
---@param code string if you came from the raw table, put this as the key of your new entry
---@param result string|function see WarpBinCodeInfo.result
---@param marker? string see WarpBinCodeInfo.marker
---@param overwrite? boolean whether to overwrite existing entries or not
---@return boolean success false if the code already exists and overwrite is false. just in-case someone else steals your code before you get to use it.
function Mod:addBinCode(code, result, marker, overwrite)
    if Mod:getBinCode(code) and not overwrite then
        -- whoops, no success
        return false
    end

    -- lmao
    Mod.warp_bin_codes[code:lower()] = { result = result, marker = marker or "spawn" }
    return true
end

--- delets a Bin Code
---@param code string
---@return boolean success false if the code doesnt exist
function Mod:deleteBinCode(code)
    code = code:lower()

    if not Mod:getBinCode(code) then return false end
    Mod.warp_bin_codes[code] = nil
    return true
end