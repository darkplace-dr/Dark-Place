function Mod:initMinigameHooks()
	Registry.registerGlobal("CARD_LAYERS", {
		["bottom"] = -1000,
		["below_ui"] = 0,
		["ui"] = 100,
		["above_ui"] = 150,
		["below_cards"] = 150,
		["enemy_cards"] = 200,
		["between_cards"] = 250,
		["cards"] = 300,
		["above_cards"] = 350,
		["below_select"] = 350,
		["select"] = 400,
		["above_select"] = 450,
		["below_soul"] = 450,
		["soul"] = 500,
		["above_soul"] = 550,
		["below_coin"] = 550,
		["coin"] = 600,
		["above_coin"] = 650,
		["below_textbox"] = 700,
		["textbox"] = 800,
		["above_textbox"] = 900,
		["top"] = 1000
	})

    Utils.hook(Game, "getActiveMusic",
        ---@overload fun(orig:function, self:Game) : Music
        function(orig, self)
            if self.state == "MINIGAME" then
                return self.minigame.music
			elseif self.state == "CARD" then
				return self.card_game.music
            else
                return orig(self)
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

        if self.state == "MINIGAME" then
            if self.minigame then
                self.minigame:onKeyPressed(key)
            end
		elseif self.state == "CARD" then
			if self.card_game then
				self.card_game:onKeyPressed(key)
			end
        else
            orig(self, key, is_repeat)
        end
    end)

    -- There's no way to detect unfixed versions afaik, so...
    if not self.legacy_kristal then
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
                if Kristal.setDesiredWindowTitleAndIcon then
                    Kristal.setDesiredWindowTitleAndIcon()
                else
                    love.window.setTitle(Kristal.getDesiredWindowTitle())
                end
                -- Reload the current mod directly
                if mode ~= "save" then
                    Kristal.loadMod(mod_id, nil, nil, function ()
                        -- Pre-initialize the current mod
                        if Kristal.preInitMod(mod_id) then
                            if save then
                                -- Switch to Game and load the temp save
                                Gamestate.switch(Game, save, save_id, false)
                                -- If we had an encounter, restart the encounter
                                if encounter then
                                    Game:encounter(encounter, false)
                                elseif shop then -- If we were in a shop, re-enter it
                                    Game:enterShop(shop)
                                elseif minigame then -- If we were in a minigame, restart it
                                    Mod:startMinigame(minigame)
                                end
                            else
                                -- Switch to Game
                                Gamestate.switch(Game)
                            end
                        end
                    end)
                else
                    Kristal.loadMod(mod_id, save_id)
                end
            end)
        end)
    end
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

function Mod:registerCards()
	self.cards = { }
	
	for _,path,card in Registry.iterScripts("cards/cards") do
		assert(card ~= nil, '"cards/' .. path .. '.lua" does not return value')
		card.id = card.id or path
		self.cards[card.id] = card
	end
	
	self.cardgames = { }
	
	for _,path,cardgame in Registry.iterScripts("cards/games") do
		assert(cardgame ~= nil, '"games/' .. path .. '.lua" does not return value')
		cardgame.id = cardgame.id or path
		self.cardgames[cardgame.id] = cardgame
	end
	
	Mod.cardcut = { }
	
	for _,path,cardcuts in Registry.iterScripts("cards/cutscenes") do
		assert(cardcuts ~= nil, '"cutscenes/' .. path .. '.lua" does not return value')
		cardcuts.id = cardcuts.id or path
		Mod.cardcut[cardcuts.id] = cardcuts
	end
end

function Mod:createCard(id, ...)
	if self.cards[id] then
		return self.cards[id](...)
	else
		error("Attempt to create nonexistent card \"" .. tostring(id) .. "\"")
	end
end

function Mod:addCard(id)
	local found_card = false
	for k,v in ipairs(Game:getFlag("collected_cards")) do
		if v[1] == id then
			found_card = k
			break
		end
	end
	if found_card then
		Game:getFlag("collected_cards")[found_card][2] = Game:getFlag("collected_cards")[found_card][2] + 1
	else
		table.insert(Game:getFlag("collected_cards"), {id, 1})
		table.insert(Game:getFlag("equipped_cards"), {id, 0})
	end
end

function Mod:createCardGame(id, ...)
	if self.cardgames[id] then
		return self.cardgames[id](...)
	else
		error("Attempt to create nonexistent card game \"" .. tostring(id) .. "\"")
	end
end

function Mod.getCardCutscene(group, id)
    local cutscene = Mod.cardcut[group]
    if type(cutscene) == "table" then
        return cutscene[id], true
    elseif type(cutscene) == "function" then
        return cutscene, false
    end
end

function Mod:startCardGame(game)

    if Game.card_game then
        error("Attempt to enter card game while already in card game")
    end

    Game.state = "CARD"

    Game.card_game = self:createCardGame(game)

    Game.card_game:postInit()
	
    Game.stage:addChild(Game.card_game)
end