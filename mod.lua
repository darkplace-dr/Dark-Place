modRequire("scripts/main/debugsystem")
modRequire("scripts/main/utils_general")
modRequire("scripts/main/utils_lore")
modRequire("scripts/main/warp_bin")
modRequire("scripts/main/ow_taunt")
modRequire("scripts/main/live_bulborb_reaction")

function Mod:preInit()
    if Kristal.Version < SemVer(self.info.engineVer) then
        self.legacy_kristal = true
    end
end

function Mod:init()
    MUSIC_PITCHES["deltarune/THE_HOLY"] = 0.9

    MUSIC_VOLUMES["cybercity"] = 0.8
    MUSIC_PITCHES["cybercity"] = 0.97

    MUSIC_VOLUMES["cybercity_alt"] = 0.8
    MUSIC_PITCHES["cybercity_alt"] = 1.2

    MUSIC_PITCHES["ruins_beta"] = 0.8

    MUSIC_VOLUMES["deltarune/queen_car_radio"] = 0.8

    MUSIC_VOLUMES["vs_susie_and_noyno"] = 0.45

    self.voice_timer = 0

    self:registerShaders()

    self:initTaunt()
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

    self:initBulborb()
end

function Mod:initializeImportantFlags(new_file)
    local likely_old_save = false

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

        Game:setFlag("cloudwebStoryFlag", 0)
    end

    if new_file then
        -- FIXME: instead of using these flags in maps we should probably use
        -- the `cond` property instead
        -- ["cond"] = "Game:hasPartyMember(\"susie\")"
        Game:setFlag("YOU_party", true)
        Game:setFlag("susie_party", true)
    end

    if new_file or not Game:getFlag("party") then
        likely_old_save = true

        -- Unlocked party members for the Party Menu
        Game:setFlag("party", { "YOU", "susie" })
    end

    if not new_file and not Game:getFlag("#room1:played_intro", false) then
        likely_old_save = true

        Game:setFlag("#room1:played_intro", true)
    end

    if new_file or Game:getFlag("bulborb_position") == nil then
        likely_old_save = true

        Game:setFlag("bulborb_scale", 0.3)
        Game:setFlag("bulborb_position", 2)
    end

    ----------

    if not new_file and likely_old_save then
        Log:print("Save seems to be from an old version")
    end
end

function Mod:unload()
    if TextInput.active and not Kristal.Console.is_open then
        Log:print("Warp Bin was open, ending text input to be safe", "warn")
        TextInput.endInput()
    end
end

function Mod:save(data)
    if data.room_id == "​" then
        data.room_id = Mod.world_dest_map_bak or Mod.lastMap
    end
end

function Mod:preUpdate()
    self.voice_timer = Utils.approach(self.voice_timer, 0, DTMULT)
end

function Mod:postUpdate()
    self:updateTaunt()
    self:updateBulborb()

    if Game.save_name == "MERG" then
        for _, member in ipairs(Game.party) do
            member:getBaseStats().health = 1
            member:getMaxStats().health = 1
            member:setHealth(math.min(member:getHealth(), 1))
        end

        if Game.battle then
            for _, member in ipairs(Game.battle.party) do
                member:checkHealth()
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