local WorldCutscene, super = Class("WorldCutscene", true)

function WorldCutscene:startMinigame(game)
	Mod:startMinigame(game)
	
	local function waitForGame(self) return (Game.minigame == nil) end
	
	return self:wait(waitForGame)
end

return WorldCutscene