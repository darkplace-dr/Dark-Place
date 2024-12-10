modRequire("scripts/main/utils_general")
modRequire("scripts/main/debugsystem")
modRequire("scripts/main/utils_lore")
modRequire("scripts/main/utils_files")
modRequire("scripts/main/minigames_glue")
modRequire("scripts/main/warp_bin")
modRequire("scripts/main/ow_taunt")
modRequire("scripts/main/battle_taunt")
modRequire("scripts/main/live_bulborb_reaction")
modRequire("scripts/main/noel_spawn")

function Mod:preInit()
    if Kristal.Version < SemVer(self.info.engineVer) then
        self.legacy_kristal = true
    end

    -- KRISTAL_EVENT is the worst change
    -- remove after v0.9.0
    if not KRISTAL_EVENT or not PartyMember["setDarkTransitionActor"] then
        self.legacy_kristal = true
    end
end

function Mod:init()
    MUSIC_PITCHES["deltarune/THE_HOLY"] = 0.9
    MUSIC_PITCHES["deltarune/cybercity"] = 0.97
    MUSIC_PITCHES["deltarune/cybercity_alt"] = 1.2
    MUSIC_PITCHES["ruins_beta"] = 0.8

    MUSIC_VOLUMES["deltarune/queen_car_radio"] = 0.8
    MUSIC_VOLUMES["deltarune/spamton_neo_mix_ex_wip"] = 0.7
    MUSIC_VOLUMES["marble_ft_ultra"] = 0.8
    MUSIC_VOLUMES["beasts"] = 0.7

    self.voice_timer = 0

    self.dogcheck_banned2_window_hacks = false

    self.MB_room_blacklist = {
        "fwood/",
        "​"
    }

    self.talkiewalkie_blacklist = {
        "​",
    }

    self.rpc_state = nil

    self:initTaunt()
    self:initBattleTaunt()
    Speen:init()
    Gangnam:init()
    self:initMinigameHooks()

    -- v0.8.1 getSoulOffset absence HACK
    if not Actor["getSoulOffset"] then
        Utils.hook(Actor, "getSoulOffset",
        ---@overload fun(orig:function, self:Actor) : x:number, y:number
        ---@diagnostic disable-next-line: redefined-local
        function(_, self)
            if self.soul_offset then return unpack(self.soul_offset) end
            return 0, 0
        end)
    end
    -- v0.8.1 setDarkTransitionActor absence HACK
    if not PartyMember["setDarkTransitionActor"] then
        Utils.hook(PartyMember, "setDarkTransitionActor",
        ---@overload fun(orig:function, self:PartyMember, actor:Actor|string) : nil
        ---@diagnostic disable-next-line: redefined-local
        function(_, self, actor)
            -- NOOP
        end)
    end
    -- v0.9.0 string add tweak HACK (yuck) for MG
    local string_metatable = getmetatable(" ")
    if not string_metatable.__add then
        string_metatable.__add = function (a, b) return a .. tostring(b) end
    end
    
    if Mod.libs["magical-glass"] then
        Utils.hook(LightActionBox, "createButtons", function(orig, self)
            for _,button in ipairs(self.buttons or {}) do
                button:remove()
            end

            self.buttons = {}

            local btn_types = {"fight", "act", "spell", "item", "mercy"}

            if not self.battler.chara:hasAct() then Utils.removeFromTable(btn_types, "act") end
            if not self.battler.chara:hasSpells() then Utils.removeFromTable(btn_types, "spell") end
            
            if self.battler.chara:hasSkills() then
                btn_types = {"fight", "skill", "item", "mercy"}
            end

            for lib_id,_ in Kristal.iterLibraries() do
                btn_types = Kristal.libCall(lib_id, "getLightActionButtons", self.battler, btn_types) or btn_types
            end
            btn_types = Kristal.modCall("getLightActionButtons", self.battler, btn_types) or btn_types

            for i,btn in ipairs(btn_types) do
                if type(btn) == "string" then
                    local x
                    if #btn_types <= 4 then
                        x = math.floor(67 + ((i - 1) * 156))
                        if i == 2 then
                            x = x - 3
                        elseif i == 3 then
                            x = x + 1
                        end
                    else
                        x = math.floor(67 + ((i - 1) * 117))
                    end
                    
                    local button = LightActionButton(btn, self.battler, x, 175)
                    button.actbox = self
                    table.insert(self.buttons, button)
                    self:addChild(button)
                elseif type(btn) == "boolean" then
                    -- nothing, used to create an empty space
                else
                    btn:setPosition(math.floor(66 + ((i - 1) * 156)) + 0.5, 183)
                    btn.battler = self.battler
                    btn.actbox = self
                    table.insert(self.buttons, btn)
                    self:addChild(btn)
                end
            end

            self.selected_button = Utils.clamp(self.selected_button, 1, #self.buttons)

        end)
        
        Utils.hook(LightActionButton, "select", function(orig, self)
            orig(self)
            -- Custom buttons start here.

            if self.type == "send" then
                Game.battle.current_menu_columns = 1
                Game.battle.current_menu_rows = 3
                Game.battle:clearMenuItems()
                Game.battle:addMenuItem({
                    ["name"] = "Send",
                    ["special"] = "spare",
                    ["callback"] = function(menu_item)
                        if Kristal.getLibConfig("magical-glass", "multi_deltarune_spare") and Game.battle.multi_mode then
                            Game.battle:setState("ENEMYSELECT", "SPARE")
                        else
                            Game.battle:pushAction("SPARE", Game.battle:getActiveEnemies())
                        end
                    end
                })
                local battler_can_defend = Kristal.getLibConfig("magical-glass", "light_battle_defend_btn") or not Game:isLight()
                if self.battler.chara.light_can_defend ~= nil then
                    battler_can_defend = self.battler.chara.light_can_defend
                end
                if battler_can_defend then
                    Game.battle:addMenuItem({
                        ["name"] = "Defend",
                        ["special"] = "defend",
                        ["callback"] = function(menu_item)
                            Game.battle:toggleSoul(false)
                            Game.battle:pushAction("DEFEND", nil, {tp = Game.battle.tension_bar.visible and -16 or 0})
                        end
                    })
                end
                if Game.battle.encounter.can_flee then
                    local battle_leader
                    for i,battler in ipairs(Game.battle.party) do
                        if not battler.is_down then
                            battle_leader = battler.chara.id
                            break
                        end
                    end
                    Game.battle:addMenuItem({
                        ["name"] = "Fly",
                        ["special"] = "flee",
                        ["unusable"] = Game.battle:getPartyIndex(battle_leader) ~= Game.battle.current_selecting,
                        ["callback"] = function(menu, item)
                            local chance = Game.battle.encounter.flee_chance

                            for _,party in ipairs(Game.battle.party) do
                                for _,equip in ipairs(party.chara:getEquipment()) do
                                    chance = chance + (equip.getFleeBonus and equip:getFleeBonus() / #Game.battle.party or 0)
                                end
                            end

                            if chance > 50 then
                                Game.battle:setState("FLEEING")
                            else
                                Game.battle:playSelectSound()
                                Game.battle:setState("FLEEFAIL")
                            end
                        end
                    })
                end
                Game.battle:setState("MENUSELECT", "SEND")
            elseif self.type == "scott" then
                Assets.playSound("scott_here")
            elseif self.type == "croak" then
                Assets.stopAndPlaySound("croak", nil, 0.8 + Utils.random(0.4))

                local bubble = Sprite("croak", nil, nil, nil, nil, "party/you")
                bubble:setOriginExact(60, 23) -- center??
                bubble:setPosition(Game.battle.soul.width/2 + 8.5, -20.5)
                bubble.physics.speed_y = -0.8
                bubble:fadeOutSpeedAndRemove(0.065)
                bubble.layer = 9999
                self:addChild(bubble)
            elseif self.type == "skill" then
                Game.battle.current_menu_columns = 2
                Game.battle.current_menu_rows = 3
                Game.battle:clearMenuItems()

                for id, action in ipairs(self.battler.chara:getLightSkills()) do
                    Game.battle:addMenuItem({
                        ["name"] = action[1],
                        ["description"] = action[2],
                        ["color"] = action[3],
                        ["callback"] = action[4]
                    })
                end

                Game.battle:setState("MENUSELECT", "SKILL")
            end
        end)

        Utils.hook(ChaserEnemy, "onCollide", function(orig, self, player)

            if self:isActive() and player:includes(Player) then
				if player.invincible_colors then
					self:explode()
				else
					self.encountered = true
					local encounter
					local enemy
				
					if self.encounter and self.light_encounter then
						if Game:isLight() then
							encounter = self.light_encounter
							enemy = self.light_enemy
						else
							encounter = self.encounter
							enemy = self.enemy
						end
					elseif self.encounter then
						encounter = self.encounter
						enemy = self.enemy
					elseif self.light_encounter then
						encounter = self.light_encounter
						enemy = self.light_enemy
					end
					
					Mod.back_attack = false
					local angle = Utils.angle(Game.world.player.x, Game.world.player.y, self.x, self.y)
					local facing = Utils.facingFromAngle(angle)
					if facing == self:getBackFace() and Kristal.getLibConfig("better_battles", "back_attack") then
						print("Back attack!")
						Mod.back_attack = true
					end

					if not encounter then
						if Game:isLight() and MagicalGlassLib:getLightEnemy(self.enemy or self.actor.id) then
							encounter = LightEncounter()
							encounter:addEnemy(self.actor.id)
						elseif not Game:isLight() and Registry.getEnemy(self.light_enemy or self.actor.id) then
							encounter = Encounter()
							encounter:addEnemy(self.actor.id)
						end
					end

					if encounter then
						self.world.encountering_enemy = true
						if not Mod.back_attack then
							self.sprite:setAnimation("hurt")
						end
						self.sprite.aura = false
						Game.lock_movement = true
						self.world.timer:script(function(wait)
							if Mod.back_attack then
								Assets.playSound("back_attack")
								wait(15/30)
							else
								Assets.playSound("tensionhorn")
								wait(8/30)
								local src = Assets.playSound("tensionhorn")
								src:setPitch(1.1)
								wait(12/30)
							end
							self.world.encountering_enemy = false
							Game.lock_movement = false
							local enemy_target = self
							if enemy then
								enemy_target = {{enemy, self}}
							end
							Game:encounter(encounter, true, enemy_target, self)
						end)
					end
				end

            end
        end)
    end
    
    --- The chance for this party member to dodge incoming damage. \
    --- Ranges from `0` (No chance) to `1` (100% chance), defaulting to `0`.
    ---@field dodge_chance                 number
    ---@field dodge_defend_bonus           number      When defending, this is added to `dodge_chance` to get the final dodge chance. Defaults to `0`.
    --- The sound file to play when this item's dodge effect is triggered. \
    --- Defaults to `nil`, which will play the sword pullback sound from Asriel in UNDERTALE. \
    --- When set to `"none"`, no sound will be played.
    ---@field dodge_sound                  string|nil
    ---@field dodge_text_color             table       An `{r, g, b}` table of the color to use for the MISS text when dodging. Defaults to white.
    ---
    --- The chance for this party member to strike a random enemy when taking damage. \
    --- Ranges from `0` (No chance) to `1` (100% chance), defaulting to `0`.
    ---@field thorns_chance                number
    ---@field thorns_defend_bonus          number      When defending, this is added to `thorns_chance` to get the final chance for thorns to activate. Defaults to `0`.
    --- The amount of damage dealt to an enemy, as a proportion of damage taken. \
    --- Ranges from `0` (0% of damage) to `1` (100% of damage).
    ---@field thorns_damage_proportion     number
    --- The sound file to play when this item's thorns effect is triggered. \
    --- Defaults to `nil`, which will play the `"screenshake"` sound. \
    --- When set to `"none"`, no sound will be played.
    ---@field thorns_sound                 string|nil  
    
    Utils.hook(PartyBattler, "hurt", function(orig, self, amount, exact, color, options)

        local function noel_damage(amount) -- DO NOT QUESTION MY CHOICES
            local meth = love.math.random(1, 3)
            if meth == 1 then
                Assets.playSound("awkward")
                Assets.playSound("voice/noel-#")
                self:removeHealth(0)
                self:statusMessage("msg", "null", {0.9,0.9,0.9}, true)
            else
                Assets.playSound("voice/noel-#")
                self:removeHealth(amount*10)
                self:statusMessage("damage", amount*10, color, true)
            end
            if self.noel_hit_counter and self.noel_hit_counter > 5 then
                self:setAnimation("stop")
                Assets.playSound("voice/stop_getting_hit")
                Assets.playSound("grab")
                Assets.playSound("alert")
                Assets.playSound("impact")
                Assets.playSound("jump")
                Assets.playSound("locker")
                Assets.playSound("petrify")
                Assets.playSound("ominous")
                Assets.playSound("rudebuster_hit")
                Assets.playSound("rudebuster_swing")
                love.window.setTitle("STOP GETTING HIT")
                self.noel_hit_counter = -1
            elseif self.noel_hit_counter then
                self.noel_hit_counter = self.noel_hit_counter + 1
            else 
                self.noel_hit_counter = 1
            end
        end


        local dodge_item
        local dodge_chance = 0
        local thorns_item
        local thorns_chance = 0
        for _,equip in ipairs(self.chara:getEquipment()) do
            if equip.dodge_chance then
                if not dodge_item then
                    dodge_item = equip
                end
                dodge_chance = dodge_chance + equip.dodge_chance
                if equip.dodge_defend_bonus and self.defending then
                    dodge_chance = dodge_chance + equip.dodge_defend_bonus
                end
            end
            if equip.thorns_chance then
                if not thorns_item then
                    thorns_item = equip
                end
                thorns_chance = thorns_chance + equip.thorns_chance
                if equip.thorns_defend_bonus and self.defending then
                    thorns_chance = thorns_chance + equip.thorns_defend_bonus
                end
            end
        end
        
        if love.math.random(1,100) <= dodge_chance * 100 then
            -- Retrieve sound and color
            local snd = dodge_item.dodge_sound or "mus_sfx_a_pullback"  -- This sound is asriel's sword pullback from UNDERTALE.
            local color = dodge_item.dodge_text_color or {1,1,1}

            -- Make a "miss" status message and play sound cue.
            self:statusMessage("msg", "miss", color)
            -- If the sound is none then don't play anything.
            if snd ~= "none" then
                Assets.playSound(snd)
            end
        else
            ----- orig(self, amount, exact, color, options)
            options = options or {}

            if not options["all"] then
                Assets.playSound("hurt")
                if not exact then
                    amount = self:calculateDamage(amount)
                    if self.defending then
                        amount = math.ceil((2 * amount) / 3)
                    end
                    -- we don't have elements right now
                    local element = 0
                    amount = math.ceil((amount * self:getElementReduction(element)))
                end
                if self.chara.id == "noel" then
                    noel_damage(amount)
                else
                    self:removeHealth(amount)
                end
            else
                -- We're targeting everyone.
                if not exact then
                    amount = self:calculateDamage(amount)
                    -- we don't have elements right now
                    local element = 0
                    amount = math.ceil((amount * self:getElementReduction(element)))

                    if self.defending then
                        amount = math.ceil((3 * amount) / 4) -- Slightly different than the above
                    end
                    if self.chara.id == "noel" then
                        noel_damage(amount)
                    else
                        self:removeHealthBroken(amount) -- Use a separate function for cleanliness
                    end
                end
            end

            if (self.chara:getHealth() <= 0) then
                self:statusMessage("msg", "down", color, true)
            else
                if self.chara.id == "noel" then
                    
                else
                    self:statusMessage("damage", amount, color, true)
                end
            end

            self.hurt_timer = 0
            Game.battle:shakeCamera(4)

            if (not self.defending) and (not self.is_down) then
                self.sleeping = false
                self.hurting = true
                self:toggleOverlay(true)
                self.overlay_sprite:setAnimation("battle/hurt", function()
                    if self.hurting then
                        self.hurting = false
                        self:toggleOverlay(false)
                    end
                end)
                if not self.overlay_sprite.anim_frames then -- backup if the ID doesn't animate, so it doesn't get stuck with the hurt animation
                    Game.battle.timer:after(0.5, function()
                        if self.hurting then
                            self.hurting = false
                            self:toggleOverlay(false)
                        end
                    end)
                end
            end
            -----
            
            if love.math.random(1,100) <= thorns_chance * 100 then
                local snd = thorns_item.thorns_sound or "screenshake"
                local enemies = {}

                for _,enemy in pairs(Game.battle.enemies) do
                    if enemy.health > 1 then
                        table.insert(enemies, enemy)
                    end
                end
                
                local enemy = Utils.pick(enemies)
                if enemy then
                    enemy:hurt(math.min(Utils.round(amount * thorns_item.thorns_damage_proportion), enemy.health - 1))
                    -- If the sound is none then don't play anything.
                    if snd ~= "none" then
                        Assets.playSound(snd)
                    end
                end
            end
        end
    end)

    Utils.hook(Textbox, "init", function(orig, self, x, y, width, height, default_font, default_font_size, battle_box)
        default_font = default_font
            or Kristal.callEvent("getDefaultDialogTextFont")
        orig(self, x, y, width, height, default_font, default_font_size, battle_box)
    end)
end

function Mod:getLightBattleMenuOffsets()
    return { -- {soul, text}
        ["ACT"] = {12, 16},
        ["ITEM"] = {0, 0},
        ["SPELL"] = {12, 16},
        ["MERCY"] = {0, 0}, --doesn't matter lmao
        ["SEND"] = {0, 0},
        ["SKILL"] = {12, 16},
    }
end

function Mod:afmPostInit(new_file)
    if self.legacy_kristal then
        Game.world:startCutscene("flowey_check")
        return
    end

    local items_list = {
        {
            result = "soulmantle",
            item1 = "flarewings",
            item2 = "discarded_robe"
        },
    }
    Kristal.callEvent("setItemsList", items_list)

    self:funnytitle()

    self:initializeImportantFlags(new_file)

    if new_file then
        if Game.save_name == "SUPER" then
            Game.inventory:addItem("chaos_emeralds")
        end

        if Game.save_name == "WOODS" then
            Game:setPartyMembers("kris")
            Game.world:loadMap("woods/spawn")
        else
            local noel = Mod:loadGameN()
            if noel and noel.Map == "room1" then
                Game:addPartyMember("noel")
                Game:setFlag("noel_party", true)
                local num = noel.SaveID
                Game:setFlag("noel_SaveID", num)
            end

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
    self:registerCards()
    self:registerCombos()
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
    for _,char in ipairs({"YOU", "susie", "kris", "brenda"}) do
        local cos_flag = char.."_costume"
        if Game:getFlag(cos_flag) == nil then
            Game:setFlag(cos_flag, 0)
        end
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

    if Game:getFlag("jekukilled") == nil and love.filesystem.read("saves/"..Mod.info.id.."/ikilledyouoncedidn'ti_"..Game.save_id) then
        Game:setFlag("jekukilled", true)
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
    local whale = Game:getPartyMember("whale")
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

        Game:getPartyMember("YOU").opinions = { kris = 50, susie = 50, noelle = 50, dess = 40, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("kris").opinions = { YOU = 50, susie = 120, noelle = 70, dess = 20, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 70, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("susie").opinions = { YOU = 50, kris = 120, noelle = 120, dess = 20, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 60, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("noelle").opinions = { YOU = 50, kris = 70, susie = 400, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 100, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("dess").opinions = { YOU = 50, kris = 70, susie = 50, noelle = 100, brenda = 60, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 60, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 60, mario = 35, pauling = 50 }
        Game:getPartyMember("brenda").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 30, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 80, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 70, mario = 50, pauling = 50 }
        Game:getPartyMember("dumbie").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 10, brenda = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("ostarwalker").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brenda = 50, dumbie = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("berdly").opinions = { YOU = 50, kris = 80, susie = 150, noelle = 120, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("bor").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 10, brenda = 80, dumbie = 50, ostarwalker = 50, berdly = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("robo_susie").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 100, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, noyno = 120, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("noyno").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 0, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 120, iphone = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("iphone").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, frisk2 = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("frisk2").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, alseri = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("alseri").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, jamm = 50, mario = 50, pauling = 50 }
        Game:getPartyMember("jamm").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 15, brenda = 80, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, mario = 65, pauling = 50 }
        Game:getPartyMember("mario").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 65, pauling = 50 }
        Game:getPartyMember("pauling").opinions = { kris = 40, YOU = 40, susie = 40, noelle = 40, dess = 40, brenda = 40, dumbie = 40, ostarwalker = 40, berdly = 40, bor = 40, robo_susie = 40, noyno = 40, iphone = 40, frisk2 = 40, alseri = 40, jamm = 40, mario = 40 }
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
        addOpinionsToParty("brenda", { mario = 50 })
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
        Game:getPartyMember("mario").opinions = { YOU = 50, kris = 50, susie = 50, noelle = 50, dess = 50, brenda = 50, dumbie = 50, ostarwalker = 50, berdly = 50, bor = 50, robo_susie = 50, noyno = 50, iphone = 50, frisk2 = 50, alseri = 50, jamm = 65 }
    end

    if new_file or pauling.opinions == nil then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before Ms. Pauling was added.")

        local party_members = {
            "YOU", "kris", "susie", "noelle", "dess", "brenda",
            "dumbie", "ostarwalker", "berdly", "bor", "robo_susie",
            "noyno", "iphone", "frisk2", "alseri", "jamm", "mario"
        }

        local default_opinion = {
            pauling = 50
        }

        for _, member in ipairs(party_members) do
            addOpinionsToParty(member, default_opinion)
        end

        -- Adjusting specific members example

        --addOpinionsToParty("frisk2", { pauling = 4 })
        --addOpinionsToParty("jamm", { pauling = 77 })

        Game:getPartyMember("pauling").opinions = {
            YOU = 40, kris = 40, susie = 40, noelle = 40, dess = 40,
            brenda = 40, dumbie = 40, ostarwalker = 40, berdly = 40,
            bor = 40, robo_susie = 40, noyno = 40, iphone = 40,
            frisk2 = 40, alseri = 40, jamm = 40, mario = 40
        }
    end

    if new_file or whale.opinions == nil or table.getn(whale.opinions) == 0 then
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before the fucking whale was added.")

        addOpinionsToParty("YOU", { whale = 50 })
        addOpinionsToParty("kris", { whale = 50 })
        addOpinionsToParty("susie", { whale = 50 })
        addOpinionsToParty("noelle", { whale = 50 })
        addOpinionsToParty("dess", { whale = 50 })
        addOpinionsToParty("brenda", { whale = 50 })
        addOpinionsToParty("dumbie", { whale = 50 })
        addOpinionsToParty("ostarwalker", { whale = 50 })
        addOpinionsToParty("berdly", { whale = 50 })
        addOpinionsToParty("bor", { whale = 50 })
        addOpinionsToParty("robo_susie", { whale = 50 })
        addOpinionsToParty("noyno", { whale = 50 })
        addOpinionsToParty("iphone", { whale = 50 })
        addOpinionsToParty("frisk2", { whale = 50 })
        addOpinionsToParty("alseri", { whale = 50 })
        addOpinionsToParty("jamm", { whale = 50 })
        addOpinionsToParty("mario", { whale = 50 })
        addOpinionsToParty("pauling", { whale = 50 })
        Game:getPartyMember("whale").opinions = { YOU = 40, kris = 40, susie = 40, noelle = 40, dess = 40, brenda = 40, dumbie = 40, ostarwalker = 40, berdly = 40, bor = 40, robo_susie = 40, noyno = 40, iphone = 40, frisk2 = 40, alseri = 40, jamm = 40, mario = 40, pauling = 40 }
    end

    local function generateStatusTable(data)
        local status = {}
        for game, info in pairs(data) do
            status[game] = info.received or false
        end
        return status
    end
    if Game:getFlag("pc_gifts_data") then
        assert(not new_file)
        likely_old_save = true
        table.insert(old_save_issues, "Save is probably from before the PC gift data saving behavior was reworked.")
        Game:setFlag("pc_gifts_status", generateStatusTable(Game:getFlag("pc_gifts_data")))
        Game:setFlag("pc_gifts_data", nil)
    end
    if not Game:getFlag("pc_gifts_status") then
        if not new_file then
            likely_old_save = true
            table.insert(old_save_issues, "Save is probably from before the PC was added.")
        end
        Game:setFlag("pc_gifts_status", generateStatusTable(self.pc_gifts_data))
    else
        Game:setFlag("pc_gifts_status", Utils.merge(generateStatusTable(self.pc_gifts_data), Game:getFlag("pc_gifts_status")))
    end

    ----------

    if not new_file and likely_old_save then
        Log:print("Save seems to be from an old version")
        if #old_save_issues == 0 then
            Log:print("No possible reasons found. That is weird.")
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

    if self.dogcheck_banned2_window_hacks then
        self.dogcheck_banned2_window_hacks = false
        Kristal.Config["borders"] = self.dogcheck_banned2_orig_banner
        Kristal.resetWindow()
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
    local party = Game:getPartyMember(battler.chara.id)
    if party.ribbit then
        if party.has_act
           and party.has_spells then
            buttons = {"fight", "skill", "item", "send", "defend"}
        elseif party.has_act then
            buttons = {"fight", "act", "item", "send", "defend"}
        else
            buttons = {"fight", "magic", "item", "send", "defend"}
        end
    end

    if battler.chara.id == "mario" and Game:getFlag("acj_mario_fightless") then
        Utils.removeFromTable(buttons, "fight")
    end

    if battler.chara.id == "noel" then
        buttons = {"magic", "item", "spare", "tension"}
    end

    if Game.battle.encounter.id == "brenda" then
        if battler.chara.id == "susie" then
            Utils.removeFromTable(buttons, "fight")
        end
        if battler.chara.id == "dess" then
            if Game:getFlag("dungeonkiller") and not Game:getFlag("b_fight_dess") then
                -- do nothing
            else
                Utils.removeFromTable(buttons, "fight")
            end
        end
        if battler.chara.id == "jamm" and not Game:getFlag("dungeonkiller") then
            Utils.removeFromTable(buttons, "fight")
        end
    end

    return buttons
end

function Mod:onActionSelect(battler, button)
    if button.type == "tension" then
        Game.battle:pushAction("TENSION", nil, {tp = -32})
    end
end

function Mod:preUpdate()
    if self.legacy_kristal then
        return
    end

    self.voice_timer = Utils.approach(self.voice_timer, 0, DTMULT)
end

function Mod:postUpdate()
    if self.legacy_kristal then
        return
    end

    self:updateTaunt()
    self:updateBattleTaunt()
    self:updateBulborb()
    Speen:update()
    Gangnam:update()

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
    if sound == "noel" then
        Assets.playSound("voice/noel/"..string.lower(node.character), 1, 1)
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
    if self.legacy_kristal then
        return
    end

    if Game.state == "OVERWORLD" and Game.world and Game.world.state == "GAMEPLAY" and Input.is("relationships", key) then
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
    elseif map.name == "CONNECTION" and (music == "greenroom" or music == "waterfall") then
        return {music, 1, 0.8}
    elseif map.name == "CONNECTION" and (music == "deltarune/cyber") then
        if Game:getFlag("CONNECTION.beatcyber", false) == true then
            return {"core", 1, 0.7}
        end
        return {music, 1, 0.8}
    end
end

function Mod:onMapBorder(map, border)
    if map.name == "CONNECTION" and (border == "cyber") then
        if Game:getFlag("CONNECTION.beatcyber", false) == true then
            return "undertale/fire"
        end
        return border
    end
end

function Mod:loadObject(world, name, properties)
    if self.legacy_kristal then
        return
    end

    if name:lower() == "vapor_bg" then
        return VaporBG(properties["mountains"])
    end
end

-- this is so that "playing ..." is the first line and "in a minigame: ..." is the second

function Mod:getPresenceDetails()
    return "Playing "..Kristal.getModOption("name")
end
function Mod:getPresenceState()
    return self.rpc_state
end

function Mod:createQuest(name, id, desc, progress_max, silent)
    if not silent and Game.stage then
        Game.stage:addChild(QuestCreatedPopup(id))
    end
end

function Mod:registerCombos()
    self.combos = {}

    for _,path,combo in Registry.iterScripts("battle/combos") do
        assert(combo ~= nil, '"battle/combos/' .. path .. '.lua" does not return value')
        combo.id = combo.id or path
        self.combos[combo.id] = combo
    end
end

function Mod:createCombo(id, ...)
    if self.combos[id] then
        return self.combos[id](...)
    else
        error("Attempt to create nonexistent combo \"" .. tostring(id) .. "\"")
    end
end

function Mod:getActionOrder()
	return {"ACT", {"SPELL", "ITEM", "SPARE", "COMBO"}}
end