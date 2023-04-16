-- Warp Bin
-- god I am so sorry for how shitty this code is

-- I'm going to cause pain and suffering with one weird trick:
-- here's the table containing any and all warp codes for the warp bin
-- have fun :]   -Char
-- Also for reference: first in a table is the code, second in a table is the result, and third in a table is the marker you wanna go (optional but defaults to spawn).
-- If the result is a string then it goes to that map, if the last argument is a function it will run the function.
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

-- if you don't want to be cringe there's also this new totally cool helper function wowee
-- also returns success just in-case someone else steals your code before you get to use it.
function Mod:addBinCode(code, result, marker)
    if Mod:getBinCode(code) then
        -- whoops, no success
        return false
    end

    -- lmao
    Mod.warp_bin_codes[code:lower()] = { result = result, marker = marker or "spawn" }
    return true
end

-- and here's a function to get a Bin Code by its Code like lmao
function Mod:getBinCode(code)
    return Mod.warp_bin_codes[code:lower()]
end

-- and here's one to delete Bin Codes
function Mod:deleteBinCode(code)
    code = code:lower()

    if not Mod:getBinCode(code) then return false end
    Mod.warp_bin_codes[code] = nil
    return true
end