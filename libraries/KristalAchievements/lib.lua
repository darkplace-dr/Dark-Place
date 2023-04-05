local lib = {}

--- Called when the game is loaded. Registers achievement scripts.
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

--- Called when the game is started. Loads achievement objects (and order), then prints an intro.
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

    print("[ACH] Achievement library loaded - courtesy of SciSpace, BrandonK7200, AcousticJamm, and Dobby233Liu")
end

--- Called after the game's initalization. Creates or loads the achievements savefile.
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

--- Called during loading. Loads the achievement savedata.
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

--- Called during saving. Writes the achievement savedata.
function lib:save(data)
    if self.global then
        self:writeGlobalAchievements()
    else
        data.achievements = self:generateAchSaveData()
    end
end

--- Gets the achievement table from memory.
---@return table achievements
function lib:getAchievements()
    return self.achievements
end

--- Gets the path of the achievement savefile in the filesystem.
---@return string path
function lib:getGlobalAchFile()
    return "saves/" .. Mod.info.id .. "/achievements.json"
end

--- Loads data from the achievement savefile in the filesystem.
function lib:loadGlobalAchievements()
    local data = JSON.decode(love.filesystem.read(self:getGlobalAchFile()))
    self:loadAchievements(data.achievements)
end

--- Loads data from a hashtable of achievements.
function lib:loadAchievements(data)
    for name, info in pairs(data) do
        local ach = self.achievements[name]
        if ach then
            ach:load(info)
        else
            print("[ACH][WARNING] Tried to load completion data for nonexistent achievement: "..name)
        end
    end
end

--- Generates save data from the achievements.
---@return table data
function lib:generateAchSaveData()
    local data = {}
    for k, ach in pairs(self.achievements) do
        data[k] = ach:save()
    end
    return data
end

--- Writes data to the achievement savefile in the filesystem.
function lib:writeGlobalAchievements()
    local data = { achievements = self:generateAchSaveData() }

    love.filesystem.write(self:getGlobalAchFile(), JSON.encode(data))
end

--- Gets a specific achievement from memory.
---@return Achievement ach
function lib:getAchievement(achievement)
    for name, ach in pairs(self.achievements) do
        if name == achievement then
            return ach
        end
    end

    error("Achievement "..achievement.." does not exist")
end

--- Gets the progression of a specific achievement.
---@return boolean|number progress
function lib:getAchProgress(achievement)
    return self:getAchievement(achievement).progress
end

--- Adds progression to a specific achievement.
function lib:addAchProgress(achievement, number, slient)
    local ach_obj = self:getAchievement(achievement)

    ach_obj.progress = ach_obj.progress + number
    self:checkAchProgression(achievement, slient)
end

--- Decides if a specific achievement is complete or not.
function lib:checkAchProgression(achievement, slient)
    local ach_obj = self:getAchievement(achievement)

    local completion = ach_obj.completion
    local progress = ach_obj.progress
    if type(completion) == "number" and progress >= completion then
        self:completeAchievement(achievement, slient)
    elseif progress then
        self:completeAchievement(achievement, slient)
    end
end

--- Marks an achievement as complete.
function lib:completeAchievement(achievement, slient)
    local ach_obj = self:getAchievement(achievement)

    if not ach_obj.earned then
        ach_obj.earned = true
        ach_obj.progress = type(ach_obj.completion) == "number" and ach_obj.completion or true

        if not slient then
            Game.stage:addChild(AchievementPopUp(achievement))
        end
    end

    if self.global then
        self:writeGlobalAchievements()
    end
end

return lib
