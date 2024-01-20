function Mod:initMinigameHooks()
	Utils.hook(Game, "getActiveMusic",
        ---@overload fun(orig:function, self:Game) : Music
        function(orig, self)
            if self.state == "OVERWORLD" then
                return self.world.music
            elseif self.state == "BATTLE" then
                return self.battle.music
            elseif self.state == "MINIGAME" then
                return self.minigame.music
            elseif self.state == "SHOP" then
                return self.shop.music
            elseif self.state == "GAMEOVER" then
                return self.gameover.music
            else
                return self.music
            end
        end
    )

	Utils.hook(Game, "onKeyPressed", function(orig, self, key, is_repeat)
		if Kristal.callEvent("onKeyPressed", key, is_repeat) then
			-- Mod:onKeyPressed returned true, cancel default behaviour
			return
		end

		if is_repeat and not self.key_repeat then
			-- Ignore key repeat unless enabled by a game state
			return
		end

		if self.state == "BATTLE" then
			if self.battle then
				self.battle:onKeyPressed(key)
			end
		elseif self.state == "MINIGAME" then
			if self.minigame then
				self.minigame:onKeyPressed(key)
			end
		elseif self.state == "OVERWORLD" then
			if self.world then
				self.world:onKeyPressed(key)
			end
		elseif self.state == "SHOP" then
			if self.shop then
				self.shop:onKeyPressed(key, is_repeat)
			end
		elseif self.state == "GAMEOVER" then
			if self.gameover then
				self.gameover:onKeyPressed(key)
			end
		end
	end)

	-- This is so quick reload puts you in the last game
	Utils.hook(Kristal, "quickReload", function(orig, mode)
		-- Temporarily save game variables
		local save, save_id, encounter, shop, minigame
		if mode == "temp" then
			save = Game:save()
			save_id = Game.save_id
			encounter = Game.battle and Game.battle.encounter and Game.battle.encounter.id
			shop = Game.shop and Game.shop.id
			minigame = Game.minigame and Game.minigame.id
		elseif mode == "save" then
			save_id = Game.save_id
		end
	
		-- Temporarily save the current mod id
		local mod_id = Mod.info.id
	
		-- Go to empty state
		Gamestate.switch({})
		-- Clear the mod
		Kristal.clearModState()
		-- Reload mods
		Kristal.loadAssets("", "mods", "", function ()
			love.window.setTitle(Kristal.getDesiredWindowTitle())
			-- Reload the current mod directly
			if mode ~= "save" then
				Kristal.loadMod(mod_id, nil, nil, function ()
					-- Pre-initialize the current mod
					if Kristal.preInitMod(mod_id) then
						-- Switch to Game and load the temp save
						Gamestate.switch(Game)
						if save then
							Game:load(save, save_id)
	
							-- If we had an encounter, restart the encounter
							if encounter then
								Game:encounter(encounter, false)
							elseif shop then -- If we were in a shop, re-enter it
								Game:enterShop(shop)
							elseif minigame then -- If we were in a minigame, restart it
								Mod:startMinigame(minigame)
							end
							
						end
					end
				end)
			else
				Kristal.loadMod(mod_id, save_id)
			end
		end)
	end)
end

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