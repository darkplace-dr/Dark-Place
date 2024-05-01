local Machine, super = Class(Event, "darkcade_machine")

function Machine:init(data)
    super.init(self, data.x, data.y, data.w, data.h)
	
	local properties = data.properties or {}
	
	self.machine = properties["sprite"] or "ball_jump"
	self.name = properties["name"] or ""
	self.sflag = properties["sflag"]
	self.levels = {}
	
	local i = 1
	while properties["level_" .. i] do
		table.insert(self.levels, properties["level_" .. i])
		i = i + 1
	end
	
	self.level_names = {}
	for k,v in pairs(self.levels) do
		table.insert(self.level_names, "Level " .. k)
	end
	
	self:setSprite(self.machine)
	self.solid = true
	
	self:setOrigin(0.5,1)
end

function Machine:onInteract(player, dir)
	Game.world:startCutscene(function(cutscene)
		if self.sflag and not Game:getFlag(self.sflag) then
			cutscene:text("* The machine doesn't seem set up yet.")
		else
			cutscene:text("* It's an arcade machine for " .. self.name .. ".")
			cutscene:text("* Play a round of " .. self.name .. "?")
			local play = cutscene:choicer({"Yes", "No"})
			if play == 1 then
				local level = cutscene:choicer(self.level_names)
				Mod:startMinigame(self.levels[level])
			else
				cutscene:text("* You leave the machine alone.")
			end
		end
	end)
	return true
end

return Machine
