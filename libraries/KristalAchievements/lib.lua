local Lib = {}

function Lib:init()
  print("Achievement library loaded -Courtesy of SciSpace, BrandonK7200, and AcousticJamm")
end

function Lib:onRegistered()
    self.achievements = { }
    
    for _,path,achievement in Registry.iterScripts("ach") do
        assert(achievement ~= nil, '"ach/' .. path .. '.lua" does not return value')
        achievement.id = achievement.id or path
        self.achievements[achievement.id] = achievement
    end
end

function Lib:createAchievement(id, ...)
    if self.achievements[id] then
        return self.achievements[id](...)
    else
        error("Attempt to create nonexistent achievement \"" .. tostring(id) .. "\"")
    end
end

function Lib:postInit(new_file)
    if new_file then
        local data = {}
        
        data.achievements = {}
        for k,v in pairs(self.achievements) do -- k is the ID, v is the info
            local ach = self:createAchievement(k)
			
            data.achievements[k] = ach:save()
        end
	
	if not love.filesystem.getInfo("saves/"..Mod.info.id.."/achievements.json") then
	    love.filesystem.createDirectory("saves/"..Mod.info.id)
	    love.filesystem.write("saves/"..Mod.info.id.."/achievements.json", JSON.encode(data))
        end
    end
end

function Lib:getAchievements()
    local data = JSON.decode(love.filesystem.read("saves/"..Mod.info.id.."/achievements.json"))
    return data
end

function Lib:getAchievement(achievement)
    local data = self:getAchievements()
	
    for k,v in pairs(data.achievements) do -- k is the ID, v is the info
        if k == achievement then
            return v
        end
    end
end

function Lib:getAchProgress(achievement)
    local data = self:getAchievements()
	
    for k,v in pairs(data.achievements) do -- k is the ID, v is the info
        if k == achievement then
            return data.achievements[k].progress
        end
    end
end

function Lib:addAchProgress(achievement, number)
    local data = self:getAchievements()
	
    for k,v in pairs(data.achievements) do -- k is the ID, v is the info
        if k == achievement then
            local completion = data.achievements[k].completion
			
            data.achievements[k].progress = data.achievements[k].progress + number
			
            if type(completion) == "number" then
                if data.achievements[k].progress >= completion then
					self:completeAchievement(achievement)
                end
            elseif completion == true then
                if data.achievements[k].progress >= 1 then
					self:completeAchievement(achievement)
                end
            end
        end
    end
	
    self:writeAchievements(data)
end

function Lib:completeAchievement(achievement)
    local data = self:getAchievements()
	
    for k,v in pairs(data.achievements) do -- k is the ID, v is the info
        if k == achievement then
            if not data.achievements[k].earned then
                data.achievements[k].earned = true
			
                apu = AchievementPopUp(achievement)
                Game.stage:addChild(apu)
            end
        end
    end
	
    self:writeAchievements(data)
end

function Lib:writeAchievements(data)
    love.filesystem.write("saves/"..Mod.info.id.."/achievements.json", JSON.encode(data))
end

return Lib
