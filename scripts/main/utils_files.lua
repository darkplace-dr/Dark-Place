-- Check if a file exists in the AppData/Home folder.
-- Can/Will be used to check if the player has played certain games like Undertale or Deltarune.
---@param try_wine_route? boolean # If true, an attempt to check wineprefixs for the file will be made on Linux. In this case name should be a path for Windows.
---@param wine_steam_appid? number # The Steam AppID of the game to check for; if specified, wine route will also check the wineprefix corresponding to that AppID.
---@return boolean exists
---@return string? path
function Mod:fileExists(name, try_wine_route, wine_steam_appid)
    local path = ""

    local function fileExists(path)
        local f = io.open(path, "r")
        return f ~= nil and io.close(f)
    end
    local function directoryExists(file)
        local ok, err, code = os.rename(file, file)
        if not ok then
            if code == 13 then
                -- Permission denied, but it exists
                return true
            end
        end
        return ok, err
    end

    if love.system.getOS() == "Windows" then
        local function unixizePathSep(path)
            return string.gsub(path, "\\", "/")
        end
        local appdata = (
            os.getenv("APPDATA") and (unixizePathSep(os.getenv("APPDATA")).."/../")
            or (unixizePathSep(os.getenv("USERPROFILE")).."/AppData/")
        )
        path = appdata..name
    elseif love.system.getOS() == "OS X" then
        if try_wine_route then return false end -- UNIMPLEMENTED

        path = os.getenv("HOME").."/Library/Application Support/"..name
    elseif love.system.getOS() == "Linux" then
        if not try_wine_route then
            -- don't ask why %
            name = string.gsub(name, "%XDG_CONFIG_HOME%", os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME").."/.config")
            local starts_at_root, _ = Utils.startsWith(name, "/")
            if not starts_at_root then
                path = os.getenv("HOME").."/"..name
            else
                path = name
            end
        else -- assuming that a Windows path is passed
            local wineprefix = os.getenv("WINEPREFIX") or os.getenv("HOME").."/.wine"
            local user_wineprefix = wineprefix.."/drive_c/users/"..os.getenv("USER")
            local appdata_wineprefix = user_wineprefix.."/Local Settings/Application Data/" -- 2k3
            if not directoryExists(appdata_wineprefix) then
                appdata_wineprefix = user_wineprefix.."/AppData/" -- vista
            end
            local path_wineprefix = appdata_wineprefix..name
            if fileExists(path_wineprefix) then return true, path_wineprefix end

            if wine_steam_appid then
                local steamroot = os.getenv("STEAMROOT") or os.getenv("HOME").."/.steam"
                local steampfx = steamroot.."/steam/steamapps/compatdata/"..tostring(wine_steam_appid).."/pfx"
                local user_steampfx = steampfx.."/drive_c/users/steamuser"
                local appdata_steampfx = user_steampfx.."/Local Settings/Application Data/" -- 2k3
                if not directoryExists(appdata_steampfx) then
                    appdata_steampfx = user_steampfx.."/AppData/" -- vista
                end
                local path_steampfx = appdata_steampfx..name
                if fileExists(path_steampfx) then return true, path_steampfx end
            end
            return false
        end
    end

    if fileExists(path) then return true, path end
    return false
end

-- Directly check if a Kristal mod has any save files using Mod:fileExists()
--- @return boolean exists
function Mod:hasSaveFiles(id, specific_file, fused_identify)
    local paths = {
        "LOVE/kristal/saves/",                      -- Source code version
        "kristal/saves/",                           -- Executable version
        "LOVE/"..(fused_identify or id).."/saves/", -- Source code version but changed Kristal's id in conf.lua
        (fused_identify or id).."/saves/",  		-- Executable version but changed Kristal's id in conf.lua
    }

    for i,v in ipairs(paths) do
        if love.system.getOS() == "Windows" then
            paths[i] = "Roaming/"..v
        elseif love.system.getOS() == "OS X" then
            paths[i] = v
        elseif love.system.getOS() == "Linux" then
            local data_home = os.getenv("XDG_DATA_HOME") or os.getenv("HOME").."/.local/share"
            paths[i] = data_home..v
        end
    end

    for _,path in ipairs(paths) do
        if specific_file then
            if Mod:fileExists(path..id.."/"..specific_file) then
                return true
            end
        else
            for i = 0 --[[ for Wii BIOS mod ]], 3 do
                if Mod:fileExists(path..id.."/file_"..i..".json") then
                    return true
                end
            end
        end
    end

    return false
end

function Mod:hasWiiBIOS()
    return not not love.filesystem.getInfo("wii_settings.json")
end

-- Check if the SnowGrave route has been progressed (flag[915] > 0) in any Deltarune save the player has
---@see https://github.com/Jacky720/FloweysTimeMachine/blob/deltarune/flags.js#L903
function Mod:hasDRSidebSave()
    if love.system.getOS() == "Android" or love.system.getOS() == "iOS" then
        return false
    end

    local found = false

    local info = Mod.pc_gifts_data["DELTARUNE"]

    for i = 0, 3 - 1 do -- this checks the main files, not the completion files
        local save_file = "filech2_".. i

        local os = love.system.getOS():gsub(" ", "_")
        assert(info.prefix_os[os])
        local exists, true_path = Mod:fileExists(info.prefix_os[os].."/"..save_file)
        if not exists and love.system.getOS() == "Linux" and info.prefix_os["Windows"] then
            exists, true_path = Mod:fileExists(info.prefix_os["Windows"].."/"..save_file, true, info.wine_steam_appid)
        end

        if exists then
            local f = io.open(true_path, "r")
            if f then
                local line_c = 1
                for line in f:lines() do
                    if line_c == 553 --[[ global.flag array start ]] + 915 then
                        found = tonumber(line) > 0
                    end
                    line_c = line_c + 1
                end

                f:close()
            end
        end

        if found then break end
    end

    return found
end