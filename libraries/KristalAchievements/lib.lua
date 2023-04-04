local Lib = {}

--- Called during initalization. Prints an intro message to the console.
function Lib:init()
    print("Achievement library loaded - courtesy of SciSpace, BrandonK7200, and AcousticJamm")
end

--- Called once loaded. Loads achievement objects from scripts/ach.
function Lib:onRegistered()
    self.achievements = {}
    for _, path, achievement_scr in Registry.iterScripts("ach") do
        assert(achievement_scr, '"ach/' .. path .. '.lua" does not return value')
        local achievement = achievement_scr()
        achievement.id = achievement.id or path
        self.achievements[achievement.id] = achievement
    end
end

--- Gets the achievement table from memory.
---@return table achievements
function Lib:getAchievements()
    return self.achievements
end

local function getSavefileDirectory()
    return "saves/" .. Mod.info.id
end
--- Gets the path of the achievement savefile in the filesystem.
---@return string path
function Lib:getAchFile()
    return getSavefileDirectory() .. "/achievements.json"
end

--- Loads data from the achievement savefile in the filesystem.
function Lib:loadAchievements()
    local data = JSON.decode(love.filesystem.read(self:getAchFile()))
    for name, info in pairs(data) do
        local ach = self.achievements[name]
        if ach then
            ach:load(info)
        end
    end
end

--- Writes data to the achievement savefile in the filesystem.
function Lib:writeAchievements()
    local data = { achievements = {} }
    for k, ach in pairs(self.achievements) do -- k is the ID, v is the info
        data.achievements[k] = ach:save()
    end

    love.filesystem.write(self:getAchFile(), JSON.encode(data))
end

--- Called after the mod's initalization. Creates or loads the achievements savefile.
function Lib:postInit(_)
    if not love.filesystem.getInfo(self:getAchFile()) then
        love.filesystem.createDirectory(getSavefileDirectory())
        self:writeAchievements()
    else
        self:loadAchievements()
    end
end

--- Gets a specific achievement from memory.
function Lib:getAchievement(achievement)
    for name, ach in pairs(self.achievements) do
        if name == achievement then
            return ach
        end
    end

    error("Achievement "..achievement.." does not exist")
end

--- Gets the progression of a specific achievement.
function Lib:getAchProgress(achievement)
    return self:getAchievement(achievement).progress
end

--- Adds progression to a specific achievement.
function Lib:addAchProgress(achievement, number, slient)
    local ach_obj = self:getAchievement(achievement)

    ach_obj.progress = ach_obj.progress + number
    self:checkAchProgression(achievement, slient)

    self:writeAchievements()
end

--- Decides if a specific achievement is complete or not.
function Lib:checkAchProgression(achievement, slient)
    local ach_obj = self:getAchievement(achievement)

    local completion = ach_obj.completion
    if completion and ach_obj.progress >= (type(completion) == "number" and completion or 1) then
        self:completeAchievement(achievement, slient)
    end
end

--- Marks an achievement as complete.
function Lib:completeAchievement(achievement, slient)
    local ach_obj = self:getAchievement(achievement)

    if not ach_obj.earned then
        ach_obj.earned = true

        if not slient then
            Game.stage:addChild(AchievementPopUp(achievement))
        end
    end

    self:writeAchievements()
end

return Lib
