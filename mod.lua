modRequire("scripts/main/utils_general")
modRequire("scripts/main/debugsystem")
modRequire("scripts/main/utils_lore")
modRequire("scripts/main/minigames_glue")
modRequire("scripts/main/warp_bin")
Speen = modRequire("scripts/main/ow_speen")
modRequire("scripts/main/ow_taunt")
modRequire("scripts/main/battle_taunt")
modRequire("scripts/main/live_bulborb_reaction")

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

    self:initTaunt()
    self:initBattleTaunt()
    Speen:init()

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

    Utils.hook(Actor, "init", function(orig, self)
        orig(self)
        self.taunt_sprites = {}
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

        if Game.save_name == "WOODS" then
			Game:setPartyMembers("kris")
            Game.world:loadMap("woods/spawn")
        else
            Game.world:startCutscene("_main.introcutscene")
		end
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

function Mod:onRegistered()
    self:registerShaders()
	self:registerMinigames()
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
    
    for _,party in pairs(Game.party_data) do
        if not party.lw_stats.magic then
            likely_old_save = true
            table.insert(old_save_issues, "Save is missing light world magic stats. Probably pre-Magical Glass.")
            for _,party in pairs(Game.party_data) do
                party:lightLVStats()
            end
            break
        end
    end

    if new_file then
        Game:setFlag("vesselChosen", 0)

        Game:setFlag("weird", false)
        Game:setFlag("weirdEnemiesKilled", 0)

        Game:setFlag("timesUsedWrongBorDoorCode", 0)
        Game:setFlag("BorDoorCodeUnlocked", false)

        Game:setFlag("hasObtainedLancer", false)
        Game:setFlag("hasObtainedRouxls", false)

        Game:setFlag("cloudwebStoryFlag", 0)
        Game:setFlag("vaporland_sidestory", 0)
    end

    -- Create save flags for costumes if they don't already exist
    if Game:getFlag("YOU_costume") == nil then
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
        table.insert(old_save_issues, "Save is probably from before the intro was added")

        Game:setFlag("#room1:played_intro", true)
    end

    if new_file or Game:getFlag("bulborb_position") == nil then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Bulborb Live Reaction was implemented")

        Game:setFlag("bulborb_scale", 0.3)
        Game:setFlag("bulborb_position", 2)
    end

    local berdly = Game:getPartyMember("berdly")
    local mario = Game:getPartyMember("mario")
    local pauling = Game:getPartyMember("pauling")
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

        Game:getPartyMember("YOU").opinions = { kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("kris").opinions = { YOU = 50, susie = 120, noelle = 70, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 70, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("susie").opinions = { YOU = 50, kris = 120, noelle = 120, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 60, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("noelle").opinions = { YOU = 50, kris = 70, susie = 400, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 100, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("dess").opinions = { YOU = 50, kris = 70, susie = 50, noelle = 100, brandon = 60, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 60, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 60, mario = 35, pauling = 50 }
        Game:getPartyMember("brandon").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 30, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 80, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 70, mario = 50, pauling = 50 }
        Game:getPartyMember("dumbie").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("ostarwalker").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("berdly").opinions = { YOU = 50, kris = 80, susie = 150, noelle = 120, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("bor").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 80, dumbie = 50, ostarwalker = 50, berdly = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("robo_susie").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, noyno = 120, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("noyno").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 120, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("iphone").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("frisk2").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("alseri").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("jamm").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 15, brandon = 80, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, mario = 65, pauling = 50 }
        Game:getPartyMember("mario").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 65, pauling = 50 }
        Game:getPartyMember("pauling").opinions = { kris = 40, YOU = 40, susie = 40, noelle = 40, dess = 40, brandon = 40, dumbie = 40, ostarwalker = 40, berdly = 40, bor = 40, robo_susie = 40, noyno = 40, iphone = 40, frisk2 = 40, alseri = 40, jamm = 40, mario = 40 }
    end

	if new_file or not Game:getFlag("darkess_beans") then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before the bean spots were added.")
		Game:setFlag("darkess_beans", 0)
		Game:setFlag("fountain_beans", 0)
		Game:setFlag("spam_beans", 0)
		Game:setFlag("binaribeans", 0)
	end

    local function addOpinionsToParty(party, new_opinions)
        local party_obj = Game:getPartyMember(party)
        assert(party_obj, "unknown party member ID " .. party)
        assert(party_obj.opinions)
        party_obj.opinions = Utils.merge(party_obj.opinions, new_opinions)
    end

	if new_file or mario.opinions == nil then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Mario was added.")

        addOpinionsToParty("YOU", { mario = 50 })
        addOpinionsToParty("kris", { mario = 50 })
        addOpinionsToParty("susie", { mario = 50 })
        addOpinionsToParty("noelle", { mario = 50 })
        addOpinionsToParty("dess", { mario = 35 })
        addOpinionsToParty("brandon", { mario = 50 })
        addOpinionsToParty("dumbie", { mario = 50 })
        addOpinionsToParty("ostarwalker", { mario = 50 })
        addOpinionsToParty("berdly", { mario = 50 })
        addOpinionsToParty("bor", { mario = 50 })
        addOpinionsToParty("robo_susie", { mario = 50 })
        addOpinionsToParty("noyno", { mario = 50 })
        addOpinionsToParty("iphone", { mario = 50 })
        addOpinionsToParty("frisk2", { mario = 50 })
        addOpinionsToParty("alseri", { mario = 50 })
        addOpinionsToParty("jamm", { mario = 65 })
        Game:getPartyMember("mario").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brandon = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 65 }
    end
	
	if new_file or pauling.opinions == nil then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Ms. Pauling was added.")

        addOpinionsToParty("YOU", { pauling = 50 })
        addOpinionsToParty("kris", { pauling = 50 })
        addOpinionsToParty("susie", { pauling = 50 })
        addOpinionsToParty("noelle", { pauling = 50 })
        addOpinionsToParty("dess", { pauling = 50 })
        addOpinionsToParty("brandon", { pauling = 50 })
        addOpinionsToParty("dumbie", { pauling = 50 })
        addOpinionsToParty("ostarwalker", { pauling = 50 })
        addOpinionsToParty("berdly", { pauling = 50 })
        addOpinionsToParty("bor", { pauling = 50 })
        addOpinionsToParty("robo_susie", { pauling = 50 })
        addOpinionsToParty("noyno", { pauling = 50 })
        addOpinionsToParty("iphone", { pauling = 50 })
        addOpinionsToParty("frisk2", { pauling = 50 })
        addOpinionsToParty("alseri", { pauling = 50 })
        addOpinionsToParty("jamm", { pauling = 50 })
        addOpinionsToParty("mario", { pauling = 50 })
        Game:getPartyMember("pauling").opinions = { YOU = 40, kris = 40, susie = 40, noelle = 40, dess = 40, brandon = 40, dumbie = 40, ostarwalker = 40, berdly = 40, bor = 40, robo_susie = 40, noyno = 40, iphone = 40, frisk2 = 40, alseri = 40, jamm = 40, mario = 40 }
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
        local the_map = Registry.createMap(data.room_id, Game.world)
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
	
	if battler.chara.id == "mario" and Game:getFlag("acj_mario_fightless") then
		table.remove(buttons,1)
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
    if Game.world and Game.world.cutscene
        and Game.world.cutscene.id == "cell_phone" and Game.world.cutscene.use_light_textbox
    then
        return "light"
    end
    if self:isOmori() then
        return "omori"
    end
end

function Mod:getDefaultDialogTextStyle()
    if Game.world and Game.world.cutscene
        and Game.world.cutscene.id == "cell_phone" and Game.world.cutscene.use_light_textbox
    then
        return "none"
    end
    if self:isOmori() then
        return "none"
    end
end

function Mod:getDefaultDialogTextFont()
    if self:isOmori() then
        return "omori"
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