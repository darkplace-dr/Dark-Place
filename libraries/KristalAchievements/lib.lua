local lib = {}
AchLib = lib

-- Called when the game is loaded. Registers achievement scripts.
function lib:onRegistered()
    self.achievements_data = {}
    for _, path, achievement_scr in Registry.iterScripts("ach/") do
        assert(achievement_scr, '"ach/' .. path .. '.lua" does not return value')
        self.achievements_data[path] = achievement_scr
    end

    if Kristal.getLibConfig("achievements", "cooperative_ordering") then
        self.ach_order = modRequire("scripts.ach_order")
    end

    self.global = Kristal.getLibConfig("achievements", "global_save")
end

-- Called when the game is started. Loads achievement objects (and order), then prints an intro.
function lib:init()
    self.achievements = {}
    for path, achievement_scr in pairs(self.achievements_data) do
        local achievement = achievement_scr()
        achievement.id = achievement.id or path
        self.achievements[achievement.id] = achievement
    end

    if self.ach_order then
        for i,v in ipairs(self.ach_order) do
            self.achievements[v].index = i
        end
    end

    if Kristal.getLibConfig("achievements", "print_console_intro") ~= false then
        print("Achievement library loaded - courtesy of SciSpace, BrendaK7200, AcousticJamm, and Dobby233Liu")
    end
end

-- Called after the game's initalization. Creates or loads the achievements savefile.
function lib:postInit()
    if self.global then
        if not love.filesystem.getInfo(self:getGlobalAchFile()) then
            love.filesystem.createDirectory("saves/" .. Mod.info.id)
            self:writeGlobalAchievements()
        else
            self:loadGlobalAchievements()
        end
    end
end

-- Called during saving. Writes the achievement savedata.
function lib:save(data)
    if self.global then
        self:writeGlobalAchievements()
    else
        data.achievements = self:generateAchSaveData()
    end
end

-- Called during loading. Loads the achievement savedata.
function lib:load(data)
    if self.global then
        return
    end

    if not data.achievements then
        data.achievements = self:generateAchSaveData()
    else
        self:loadAchievements(data.achievements)
    end
end

function lib:unload()
    if self.global then
        self:writeGlobalAchievements()
    end
end

-- Gets the achievement table from memory.
---@return table achievements
function lib:getAchievements()
    return self.achievements
end

-- Gets the path of the achievement savefile in the filesystem.
---@return string path
function lib:getGlobalAchFile()
    return "saves/" .. Mod.info.id .. "/achievements.json"
end

-- Loads data from the achievement savefile in the filesystem.
function lib:loadGlobalAchievements()
    local data_raw, info = love.filesystem.read(self:getGlobalAchFile())
    if not data_raw then
        print("ACH: error while loading global ach. file: " .. info)
        return false
    end
    local data = JSON.decode(data_raw)
    self:loadAchievements(data.achievements)
    return true
end

-- Loads data from a hashtable of achievements.
function lib:loadAchievements(data)
    for name, info in pairs(data) do
        local ach = self.achievements[name]
        if ach then
            ach:load(info)
        else
            print("ACH: tried to load completion data for nonexistent achievement - "..name)
        end
    end
end

-- Generates save data from the achievements.
---@return table data
function lib:generateAchSaveData()
    local data = {}
    for k, ach in pairs(self.achievements) do
        data[k] = ach:save()
    end
    return data
end

-- Writes data to the achievement savefile in the filesystem.
function lib:writeGlobalAchievements()
    local data = { achievements = self:generateAchSaveData() }

    local success, info = love.filesystem.write(self:getGlobalAchFile(), JSON.encode(data))
    if not success then
        print("ACH: error while writing global ach. file: " .. info)
    end
    return success
end

-- Gets a specific achievement from memory.
---@param achievement string
---@return Achievement ach
function lib:getAchievement(achievement)
    if type(achievement) ~= "string" then
        error(string.format("Expected param 1 to be a string, got a %s", type(achievement)))
    end

    return self.achievements[achievement]
end

---@param id_or_ach Achievement|string
local function getAchievement(id_or_ach)
    if type(id_or_ach) == "table" then
        return id_or_ach
    end
    return lib:getAchievement(id_or_ach)
end

-- Returns whether a achievement was completed or not.
function lib:earnedAch(achievement)
    self:checkAchProgression(achievement, true)
    return getAchievement(achievement).earned
end

---@deprecated
-- Returns whether a achievement was completed or not.
-- For compatability with old DP code.
function lib:hasAch(achievement)
    return self:earnedAch(achievement)
end

-- Gets the progression of a specific achievement.
---@return boolean|number progress
function lib:getAchProgress(achievement)
    return getAchievement(achievement).progress
end

-- Adds progression to a specific achievement.
function lib:addAchProgress(achievement, number, silent)
    local ach_obj = getAchievement(achievement)

    if type(ach_obj.completion) ~= "number" then
        error("Achievement " + achievement + " doesn't use progress")
    end

    ach_obj.progress = math.min(ach_obj.progress + number, ach_obj.completion)

    self:checkAchProgression(achievement, silent)
end

-- Decides if a specific achievement is complete or not.
function lib:checkAchProgression(achievement, silent)
    local ach_obj = getAchievement(achievement)

    local completion = ach_obj.completion
    local progress = ach_obj.progress
    if type(completion) == "number" then
        if progress >= completion then
            self:completeAchievement(achievement, silent)
        end
    elseif progress then
        self:completeAchievement(achievement, silent)
    end
end

-- Marks an achievement as complete.
function lib:completeAchievement(achievement, silent)
    local ach_obj = getAchievement(achievement)

    if ach_obj.earned then
        return
    end

    ach_obj.earned = true
    ach_obj.progress = type(ach_obj.completion) == "number" and ach_obj.completion or true

    if not silent then
        Game.stage:addChild(AchievementPopUp(achievement))
    end

    if self.global then
        self:writeGlobalAchievements()
    end
end

-- Marks an achievement as incomplete.
function lib:removeAchievement(achievement)
    local ach_obj = getAchievement(achievement)

    if not ach_obj.earned then
        return
    end

    ach_obj.earned = false
    if ach_obj.completion == false or ach_obj.completion == true then
        ach_obj.progress = false
    else
        ach_obj.progress = 0
    end

    if self.global then
        self:writeGlobalAchievements()
    end
end

return lib
