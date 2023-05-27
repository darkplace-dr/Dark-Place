-- Warp Bin? More like......... BOR DOOR!!!!!! Hahahahaha i love duplicating code :smiling_imp: :fire: :trollface~1:
-- god I am so sorry for how shitty this code is... IS WHAT THE ORIGINAL WARP BIN FILE WOULD SAY!!! NOT THIS TIME AROUND, BLUD!

--- The thing you put in the Warp Bin to warp to places like yeah \
--- must be 8-characters and be in lower case
---@alias BorDoorCode string

--- defines the behavior of a Warp Bin code
---@class BorDoorCodeInfo
--- what to do after the code is entered. \
--- if a string, treated as a map's id and the player is teleported there; \
--- if the last argument is a function, the function is run
---@field result string|fun(cutscene: WorldCutscene)
---@field marker string|nil in case result is a string, the name of the marker you want to teleport the player to

-- I'm going to cause pain and suffering with one weird trick:
-- here's the table containing any and all warp codes for the 
-- warp bin.
-- have fun :]   -Char                 (well its NOT that bad) \
-- to add new codes you'd add new entries of "type" BorDoorCodeInfo to the table below.
-- If you have sumneko's Lua LS you should be able to get nice annonations
---@type table<BorDoorCode, BorDoorCodeInfo>
Mod.bor_codes = {
    ["isuckass"] = { result = "floor2/roombor" },
}

-- heres some new totally cool helper functions wowee

--- get a Bin Code's info
---@param code BorDoorCode
---@return BorDoorCodeInfo info
function Mod:getBorCode(code)
    return Mod.bor_codes[code:lower()]
end

--- adds a code to the warp bin code table
---@param code BorDoorCode if you came from the raw table, put this as the key of your new entry
---@param result string|fun(cutscene: WorldCutscene) see BorDoorCodeInfo.result
---@param marker? string see BorDoorCodeInfo.marker
---@param overwrite? boolean whether to overwrite existing entries or not
---@return boolean success false if the code already exists and overwrite is false. just in-case someone else steals your code before you get to use it.
function Mod:addBorCode(code, result, marker, overwrite)
    if Mod:getBorCode(code) and not overwrite then
        -- whoops, no success
        return false
    end

    -- lmao
    Mod.bor_codes[code:lower()] = { result = result, marker = marker or "spawn" }
    return true
end

--- delets a Bin Code
---@param code BorDoorCode
---@return boolean success false if the code doesnt exist
function Mod:deleteBorCode(code)
    code = code:lower()

    if not Mod:getBorCode(code) then return false end
    Mod.bor_codes[code] = nil
    return true
end
