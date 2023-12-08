modRequire("scripts/main/debugsystem")
modRequire("scripts/main/utils_general")
modRequire("scripts/main/utils_lore")
modRequire("scripts/main/warp_bin")
modRequire("scripts/main/ow_taunt")
modRequire("scripts/main/battle_taunt")
modRequire("scripts/main/live_bulborb_reaction")
Speen = modRequire("scripts/main/ow_speen")

-- PR 500 stolen by AcousticJamm :troll:

function Mod:preInit()
    if Kristal.Version < SemVer(self.info.engineVer) then
        self.legacy_kristal = true
    end
end

function Mod:init()
    MUSIC_PITCHES["deltarune/THE_HOLY"] = 0.9
    MUSIC_PITCHES["deltarune/cybercity"] = 0.97
    MUSIC_PITCHES["deltarune/cybercity_alt"] = 1.2
    MUSIC_PITCHES["ruins_beta"] = 0.8

    MUSIC_VOLUMES["deltarune/queen_car_radio"] = 0.8
    MUSIC_VOLUMES["marble_ft_ultra"] = 0.8

    self.voice_timer = 0

    self:registerShaders()

    self:initTaunt()
    self:initBattleTaunt()
    Speen:init()

--[[     Utils.hook(World, "setupMap", function(orig, self, map, ...)
        for _,child in ipairs(self.children) do
            if not child.persistent then
                self:removeChild(child)
            end
        end
        for _,child in ipairs(self.controller_parent.children) do
            if not child.persistent then
                self.controller_parent:removeChild(child)
            end
        end
    
        self:updateChildList()
    
        self.healthbar = nil
        self.followers = {}
    
        self.camera:resetModifiers(true)
        self.camera:setAttached(true)
    
        if isClass(map) then
            self.map = map
        elseif type(map) == "string" then
            if not Registry.getMap(map) and not Registry.getMapData(map) then
                error("fuck")
            else
                self.map = Registry.createMap(map, self, ...)
            end
        elseif type(map) == "table" then
            self.map = Map(self, map, ...)
        else
            self.map = Map(self, nil, ...)
        end
    
        self.map:load()
    
        local dark_transitioned = self.map.light ~= Game:isLight()
    
        Game:setLight(self.map.light)
    
        self.width = self.map.width * self.map.tile_width
        self.height = self.map.height * self.map.tile_height
    
        --self.camera:setBounds(0, 0, self.map.width * self.map.tile_width, self.map.height * self.map.tile_height)
    
        self.battle_fader = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.battle_fader:setParallax(0, 0)
        self.battle_fader:setColor(0, 0, 0)
        self.battle_fader.alpha = 0
        self.battle_fader.layer = self.map.battle_fader_layer
        self.battle_fader.debug_select = false
        self:addChild(self.battle_fader)
    
        self.in_battle = false
        self.in_battle_area = false
        self.battle_alpha = 0
    
        local map_border = self.map:getBorder(dark_transitioned)
        if map_border then
            Game:setBorder(map_border)
        end
    
        if not self.map.keep_music then
            self:transitionMusic(Kristal.callEvent("onMapMusic", self.map, self.map.music) or self.map.music)
        end
    end)

    Utils.hook(World, "mapTransition", function(orig, self, ...)
        local args = {...}
        local map = args[1]
        if type(map) == "string" then
            if not Registry.getMap(map) and not Registry.getMapData(map) then
                local xp = XPWindow()
                if Game.world.cutscene then
                    Game.world:stopCutscene()
                end
                Game.lock_movement = false
                Game.world:loadMap("warphub")
                return
            else
                local map = Registry.createMap(map)
                if not map.keep_music then
                    self:transitionMusic(Kristal.callEvent("onMapMusic", self.map, self.map.music) or map.music, true)
                end
                local dark_transition = map.light ~= Game:isLight()
                local map_border = map:getBorder(dark_transition)
                if map_border then
                    Game:setBorder(map_border, 1)
                end
            end
        end
        self:fadeInto(function()
            self:loadMap(Utils.unpack(args))
        end)
    end) ]]
	
	Utils.hook(Game, "getActiveMusic", function(orig, self)
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
	end)
	
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
end

function Mod:postInit(new_file)
    if self.legacy_kristal then
        Game.world.music:stop()
        Game.world:startCutscene("flowey_check")
        return
    end

    self:initializeImportantFlags(new_file)

    if new_file then
		if Game.save_name == "SUPER" then
			Game.inventory:addItem("chaos_emeralds")
		end

        Game.world:startCutscene("_main.introcutscene")
    end
	
	if not Game:getFlag("booty_time") then
		Game:addFlag("booty_cd", 1)
		if Game:getFlag("booty_cd") >= 5 then
			if love.math.random(1,5) > 4 then
				Game:setFlag("booty_time", true)
			end
		end
	elseif not Game:getFlag("booty_finished") then
		Game.world:startCutscene("booty.bootleg")
	end

    self:initBulborb()
	
	self:initializeEvents()
end

function Mod:initializeImportantFlags(new_file)
    local likely_old_save = false
    local old_save_issues = {}
	
	if Game:getFlag("quest_desc")[1] == "This is the Mainline quest. This is hardcoded into the library for the main story of your mod. The ID for this quest is 'mainline', so you can change the description." then
		likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Questline was added.")
	end

    if new_file or likely_old_save then
        Kristal.callEvent("setDesc", "mainline",
            "Well as it turns out Ralsei was wrong when he said that making Dark Fountains causes The Roaring, \z
            they just get weirder the more you make. Susie has been making them left right and center, \z
            and she is now on her 1000th fountain. Go and explore the world, there's lots to discover!"
        )
    end

    if new_file then
        self:rollFun()
    end

    if new_file then
        Game:setFlag("vesselChosen", 0)

        Game:setFlag("weird", false)
        Game:setFlag("weirdEnemiesKilled", 0)

        Game:setFlag("timesUsedWrongBorDoorCode", 0)
        Game:setFlag("BorDoorCodeUnlocked", false)
        Game:setFlag("AddiSwitchOn", false)

        Game:setFlag("hasObtainedLancer", false)
        Game:setFlag("hasObtainedRouxls", false)

        Game:setFlag("cloudwebStoryFlag", 0)
        Game:setFlag("vaporland_sidestory", 0)

        Game:setFlag("spookymonth", false)
    end

    -- Create save flags for costumes if they don't already exist
    if new_file or Game:getFlag("YOU_costume") == nil then
        Game:setFlag("YOU_costume", 0)
    end
    if Game:getFlag("susie_costume") == nil then
        Game:setFlag("susie_costume", 0)
    end
    if Game:getFlag("kris_costume") == nil then
        Game:setFlag("kris_costume", 0)
    end
    if Game:getFlag("brandon_costume") == nil then
        Game:setFlag("brandon_costume", 0)
    end


    if new_file then
        -- FIXME: instead of using these flags in maps we should probably use
        -- the `cond` property instead
        -- ["cond"] = "Game:hasPartyMember(\"susie\")"
        Game:setFlag("YOU_party", true)
        Game:setFlag("susie_party", true)
    end
    
    if new_file or Game:getFlag("party_max") == nil then
        Game:setFlag("party_max", 4)
    end

    if new_file or not Game:getFlag("party") then
        likely_old_save = true
        table.insert(old_save_issues, "The party flag was not initialized")

        -- Unlocked party members for the Party Menu
        Game:setFlag("party", { "YOU", "susie" })
    end

    if not new_file and not Game:getFlag("#room1:played_intro", false) then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before the intro was added.")

        Game:setFlag("#room1:played_intro", true)
    end

    if new_file or Game:getFlag("bulborb_position") == nil then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Bulborb Live Reaction was implemented")

        Game:setFlag("bulborb_scale", 0.3)
        Game:setFlag("bulborb_position", 2)
    end

    local berdly = Game:getPartyMember("berdly")
    if berdly:getBaseStats("health") == 300 then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Berdly was added.")

        berdly.health = 200
        berdly.stats = {
            health = 200,
            attack = 8,
            defense = 4,
            magic = 2
        }
    end

    if new_file or berdly.opinions == nil then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before the relationship system was added.")

        local party_members = {"YOU", "kris", "susie", "noelle", "dess", "brandon", "dumbie", "ostarwalker", "berdly", "bor", "robo_susie", "noyno", "iphone", "frisk2", "alseri", "jamm"}
        for i, v in ipairs(party_members) do
            local party = Game:getPartyMember(v)
            if v == "YOU" then
                party.opinions = {
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "kris" then
                party.opinions = {
                    YOU = 50,
                    susie = 120,
                    noelle = 70,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 70,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "susie" then
                party.opinions = {
                    YOU = 50,
                    kris = 120,
                    noelle = 120,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 60,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "noelle" then
                party.opinions = {
                    YOU = 50,
                    kris = 70,
                    susie = 400,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 100,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "dess" then
                party.opinions = {
                    YOU = 50,
                    kris = 70,
                    susie = 50,
                    noelle = 100,
                    brandon = 60,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 60,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 60
                }
            end
            if v == "brandon" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 30,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 80,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 70
                }
            end
            if v == "dumbie" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "ostarwalker" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "berdly" then
                party.opinions = {
                    YOU = 50,
                    kris = 80,
                    susie = 150,
                    noelle = 120,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "bor" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 80,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "robo_susie" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    nonyo = 120,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "nonyo" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 120,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "iphone" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    frisk2 = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "frisk2" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    alseri = 50,
                    jamm = 50
                }
            end
            if v == "alseri" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 50,
                    brandon = 50,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    jamm = 50
                }
            end
            if v == "jamm" then
                party.opinions = {
                    YOU = 50,
                    kris = 50,
                    susie = 50,
                    noelle = 50,
                    dess = 15,
                    brandon = 80,
                    dumbie = 50,
                    ostarwalker = 50,
                    berdly = 50,
                    bor = 50,
                    robo_susie = 50,
                    nonyo = 50,
                    iphone = 50,
                    frisk2 = 50,
                    alseri = 50
                }
            end
        end
    end
	
	if new_file or not Game:getFlag("darkess_beans") then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before the bean spots were added.")
		Game:setFlag("darkess_beans", 0)
		Game:setFlag("fountain_beans", 0)
		Game:setFlag("spam_beans", 0)
		Game:setFlag("binaribeans", 0)
	end

    ----------

    if not new_file and likely_old_save then
        Log:print("Save seems to be from an old version")
        if #old_save_issues == 0 then
            Lod:print("No possible reasons found. That is weird.")
        else
            Log:print("Possible reasons:")
            for i,v in ipairs(old_save_issues) do
                Log:print("- "..v)
            end
        end
    end
end

function Mod:initializeEvents()
	local date = os.date("*t")
end

function Mod:onRegistered()
	self.minigames = { }

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
        error("Attempt to enter a minigame while already in one")
    end

    Game.state = "MINIGAME"

    Game.minigame = self:createMinigame(game)

    Game.minigame:postInit()

    Game.stage:addChild(Game.minigame)
end

function Mod:unload()
    if TextInput.active and not Kristal.Console.is_open then
        Log:print("Warp Bin was open, ending text input to be safe", "warn")
        TextInput.endInput()
    end
end

function Mod:save(data)
    if data.room_id == "​" then
        Log:print("Attempting to get this save out of the mb map", "warn")

        data.room_id = Mod.world_dest_map_bak or Mod.lastMap or data.room_id
        local the_map = Registry.createMap(data.room_id)
        data.room_name = (the_map and the_map.name) or "???"

        if Mod.world_dest_mk_bak then
            if type(Mod.world_dest_mk_bak) == "string" then
                data.spawn_marker = Mod.world_dest_mk_bak
            else
                data.spawn_position = Mod.world_dest_mk_bak
            end
        end
        --data.spawn_facing = Mod.world_dest_fc_bak

        if Game.world.map.id == "​" then
            data.party = Game.world.map.old_party or data.party
            data.flags["mb_partySet"] = nil
        end
    end
end

-- will not Work
--[[function Mod:load(data, new_file)
    local likely_old_save

    if data.room_id == "devstart" or data.room_id == "devroom" or data.room_id == "partyroom" then
        likely_old_save = true
        data.room_id = "devhotel/devdiner/" .. data.room_id
    end

    if not new_file and likely_old_save then
        Log:print("Save seems to be from an old version")
    end
end]]

function Mod:getActionButtons(battler, buttons)
    if Game:getPartyMember(battler.chara.id).ribbit then
        if Game:getPartyMember(battler.chara.id).has_act == true
           and Game:getPartyMember(battler.chara.id).has_spells == true then
            return {"fight", "skill", "item", "send", "defend"}
        elseif Game:getPartyMember(battler.chara.id).has_act == true then
            return {"fight", "act", "item", "send", "defend"}
        else
            return {"fight", "magic", "item", "send", "defend"}
        end
    end
    return buttons
end

function Mod:preUpdate()
    self.voice_timer = Utils.approach(self.voice_timer, 0, DTMULT)
end

function Mod:postUpdate()
    self:updateTaunt()
    self:updateBattleTaunt()
    self:updateBulborb()
    Speen:update()

    if Game.save_name == "MERG" then
        for _, party in ipairs(Game.party) do
            if party.health > 1 then
                party.health = 1
            end
            if party.stats.health ~= 1 then
                party.stats.health = 1
            end
        end
        if Game.battle then
            Game.battle:targetAll()
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                enemy.current_target = "ALL"
            end
        end
    end
end

function Mod:onTextSound(sound, node)
    if sound == "default" and self:isOmori() then
        -- commit a crime
        sound = "omori"
    end

    if sound == "omori" then
        if self.voice_timer == 0 then
            Assets.playSound("voice/omori", nil, 0.9 + Utils.random(0.18))
            self.voice_timer = 1.1
        end
        return true
    end
    if sound == "frisk2" then
        if self.voice_timer == 0 then
            Assets.playSound("voice/frisk2", nil, 0.9 + Utils.random(0.18))
            self.voice_timer = 1.1
        end
        return true
    end
    if sound == "mago1" then
        if self.voice_timer == 0 then
            local snd = Assets.playSound(Utils.pick{"voice/mago1", "voice/mago2", "voice/mago3", "voice/mago4", "voice/mago5", "voice/mago6", "voice/mago7"})
            self.voice_timer = 2
		end
		return true
    end
    if sound == "rx1" then
        if self.voice_timer == 0 then
            local snd = Assets.playSound(Utils.pick{"voice/rx1", "voice/rx2", "voice/rx3"})
            self.voice_timer = 2
		end
		return true
    end
    if sound == "hat_badge" then
        -- Sounds are taken from the badge seller in A Hat in Time.
        if self.voice_timer == 0 then
            local snd = Assets.playSound(Utils.pick{
            "voice/hat_badge1",
            "voice/hat_badge2",
            "voice/hat_badge3",
            "voice/hat_badge4",
            "voice/hat_badge5",
            "voice/hat_badge6",
            "voice/hat_badge7",
            "voice/hat_badge8"})
            self.voice_timer = 5
		end
		return true
    end
end

function Mod:onFootstep(char, num)
    if Game.world.map.use_footstep_sounds and char == Game.world.player then
        if num == 1 then
            Assets.playSound("step1")
        elseif num == 2 then
            Assets.playSound("step2")
        end
    end
end

function Mod:onKeyPressed(key)
    if Game.world and Game.world.state == "GAMEPLAY" and key == "r" then
        Assets.stopAndPlaySound("ui_select")
        Game.world:openMenu(DarkRelationshipsMenu())
    end
end

function Mod:getUISkin()
    if self:isOmori() then
        return "omori"
    end
end

function Mod:getDefaultDialogTextStyle()
    if self:isOmori() then
        return "none"
    end
end

function Mod:getDefaultDialogTextFont()
    if self:isOmori() then
        return "OMORI"
    end
end

function Mod:onMapMusic(map, music)
    if Game:getFlag("cloudwebStoryFlag") == 1 and music == "cloudwebs" and map.id == "cloudwebs/cloudwebs_entrance" then
        return ""
    elseif Game:getFlag("weird") and music == "deltarune/cybercity" then
        return "deltarune/cybercity_alt"
    end
end

function Mod:loadObject(world, name, properties)
    if name:lower() == "vapor_bg" then
        return VaporBG(properties["mountains"])
    end
end

Mod.wave_shader = love.graphics.newShader([[
    extern number wave_sine;
    extern number wave_mag;
    extern number wave_height;
    extern vec2 texsize;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
    {
        number i = texture_coords.y * texsize.y;
        vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
        return Texel(texture, coords) * color;
    }
]])
