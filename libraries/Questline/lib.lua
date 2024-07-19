local Lib = {}

function Lib:init()
    if Kristal.getLibConfig("questline", "print_console_intro") ~= false then
    	print("Loaded the Questline library by AcousticJamm.")
	end
end

function Lib:onKeyPressed(key)
    if Game.world and Game.world.state == "GAMEPLAY" and Input.is("quest", key) and not Game.battle and not Game.shop then
		Game.world:openMenu(QuestMenu())
	end
end

function Lib:postInit(new_file)
	if Game:getFlag("quest_menu_ever_opened") == nil then
		Game:setFlag("quest_menu_ever_opened", false)
	end
	if not Game:getFlag("quest_name") then
		Game:setFlag("quest_name", {Mod.info.name})
		Game:setFlag("quest_id", {"mainline"})
		Game:setFlag("quest_desc", {"This is the Mainline quest. This is hardcoded into the library for the main story of your mod. The ID for this quest is 'mainline', so you can change the description."})
		Game:setFlag("quest_progress", {0})
		Game:setFlag("quest_progress_max", {0})
		Game:setFlag("quest_completed", {false})
	end
end

function Lib:createQuest(name, id, desc, progress_max)
	if not name then
		error("Quest must have name.")
	end
	if type(name) ~= "string" then
		error("Quest name must be a string (expected string, got " .. type(name) .. ")")
	end
	if not id then
		error("Quest must have ID.")
	end
	if type(id) ~= "string" then
		error("Quest ID must be a string (expected string, got " .. type(id) .. ")")
	end
	local hasvalue = function (tab, val)
		for index, value in ipairs(tab) do
			if value == val then
				return true
			end
		end

		return false
	end
	if hasvalue(Game:getFlag("quest_id"), id) then
		error("Quest ID " .. id .. " already exists.")
	end
	if not desc then
		error("Quest must have description. (You can make it blank if you want!)")
	end
	if type(desc) ~= "string" then
		error("Quest description must be a string (expected string, got " .. type(desc) .. ")")
	end

	table.insert(Game:getFlag("quest_name"), name)
	table.insert(Game:getFlag("quest_id"), id)
	table.insert(Game:getFlag("quest_desc"), desc)
	table.insert(Game:getFlag("quest_progress"), 0)
	table.insert(Game:getFlag("quest_completed"), false)

	if progress_max then
		table.insert(Game:getFlag("quest_progress_max"), progress_max)
	else
		table.insert(Game:getFlag("quest_progress_max"), 0)
	end
end

function Lib:printQuest(id)
	local index = self:getQuest(id)

	if index then
		if Game:getFlag("quest_progress_max")[index] > 0 then
			Kristal.Console:log("Quest \"" .. Game:getFlag("quest_name")[index] .. "\". Progress: " .. Game:getFlag("quest_progress")[index] .. "/" .. Game:getFlag("quest_progress_max")[index])
		else
			Kristal.Console:log("Quest \"" .. Game:getFlag("quest_name")[index] .. "\". Completion: " .. tostring(Game:getFlag("quest_completed")[index]))
		end
	else
		Kristal.Console:log("Quest not found!")
	end
end

function Lib:completeQuest(id, complete)
	local index = self:getQuest(id)

	if not index then
		error("Quest " .. id .. " doesn't exist.")
	end

	if complete == false then
		Game:getFlag("quest_completed")[index] = false
	else
		Game:getFlag("quest_completed")[index] = true
	end
end

function Lib:setQuestProgress(id, progress)
	if type(progress) ~= "number" then
		error("Progress must be a number (expected number, got " .. type(progress) .. ")")
	end

	local index = self:getQuest(id)

	if not index then
		error("Quest " .. id .. " doesn't exist.")
	end

	if Game:getFlag("quest_progress_max")[index] <= 0 then
		error("Quest " .. id .. " isn't a progress quest.")
	end

	Game:getFlag("quest_progress")[index] = progress

	if Game:getFlag("quest_progress")[index] >= Game:getFlag("quest_progress_max")[index] then
		self:completeQuest(id)
	end
end

function Lib:addQuestProgress(id, progress)
	if type(progress) ~= "number" then
		error("Progress must be a number (expected number, got " .. type(progress) .. ")")
	end

	local index = self:getQuest(id)

	if not index then
		error("Quest " .. id .. " doesn't exist.")
	end

	if Game:getFlag("quest_progress_max")[index] <= 0 then
		error("Quest " .. id .. " isn't a progress quest.")
	end

	local new_progress = Game:getFlag("quest_progress")[index] + progress

	self:setQuestProgress(id, new_progress)
end

function Lib:setDesc(id, desc)
	if type(desc) ~= "string" then
		error("Quest description must be a string (expected string, got " .. type(desc) .. ")")
	end

	local index = self:getQuest(id)

	if not index then
		error("Quest " .. id .. " doesn't exist.")
	end

	Game:getFlag("quest_desc")[index] = desc
end

function Lib:getQuest(id)
	return Utils.getIndex(Game:getFlag("quest_id"), id)
end

function Lib:setName(id, name)
	if type(name) ~= "string" then
		error("Quest name must be a string (expected string, got " .. type(name) .. ")")
	end

	local index = self:getQuest(id)

	if not index then
		error("Quest " .. id .. " doesn't exist.")
	end

	Game:getFlag("quest_name")[index] = name
end

return Lib
