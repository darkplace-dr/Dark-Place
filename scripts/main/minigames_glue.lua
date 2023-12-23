function Mod:registerMinigames()
    self.minigames = {}

	for _,path,game in Registry.iterScripts("minigames") do
		assert(game ~= nil, '"minigames/' .. path .. '.lua" does not return value')
		game.id = game.id or path
		self.minigames[game.id] = game
	end
end

function Mod:createMinigame(id, ...)
	if self.minigames[id] then
		return self.minigames[id](...)
	else
		error("Attempt to create nonexistent minigame \"" .. tostring(id) .. "\"")
	end
end

function Mod:startMinigame(game)
    if Game.minigame then
        error("Attempt to enter minigame while already being in one")
    end

    Game.state = "MINIGAME"

    Game.minigame = self:createMinigame(game)

    Game.minigame:postInit()
	
    Game.stage:addChild(Game.minigame)
end