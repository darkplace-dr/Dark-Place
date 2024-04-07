TweenManager             = libRequire("magical-glass", "scripts/tweenmanager")
LightBattle              = libRequire("magical-glass", "scripts/lightbattle")
LightPartyBattler        = libRequire("magical-glass", "scripts/lightbattle/lightpartybattler")
LightEnemyBattler        = libRequire("magical-glass", "scripts/lightbattle/lightenemybattler")
LightEnemySprite         = libRequire("magical-glass", "scripts/lightbattle/lightenemysprite")
LightArena               = libRequire("magical-glass", "scripts/lightbattle/lightarena")
LightEncounter           = libRequire("magical-glass", "scripts/lightbattle/lightencounter")
LightSoul                = libRequire("magical-glass", "scripts/lightbattle/lightsoul")
LightBattleUI            = libRequire("magical-glass", "scripts/lightbattle/ui/lightbattleui")
HelpWindow               = libRequire("magical-glass", "scripts/lightbattle/ui/helpwindow")
LightDamageNumber        = libRequire("magical-glass", "scripts/lightbattle/ui/lightdamagenumber")
LightGauge               = libRequire("magical-glass", "scripts/lightbattle/ui/lightgauge")
LightTensionBar          = libRequire("magical-glass", "scripts/lightbattle/ui/lighttensionbar")
LightActionButton        = libRequire("magical-glass", "scripts/lightbattle/ui/lightactionbutton")
LightActionBoxSingle     = libRequire("magical-glass", "scripts/lightbattle/ui/lightactionboxsingle")
LightAttackBox           = libRequire("magical-glass", "scripts/lightbattle/ui/lightattackbox")
LightAttackBar           = libRequire("magical-glass", "scripts/lightbattle/ui/lightattackbar")
LightShop                = libRequire("magical-glass", "scripts/lightshop")
RandomEncounter          = libRequire("magical-glass", "scripts/randomencounter")

MagicalGlassLib = {}
local lib = MagicalGlassLib
-- Mod.libs["magical-glass"]

function lib:unload()
    MagicalGlassLib          = nil
    TweenManager             = nil
    LightBattle              = nil
    LightPartyBattler        = nil
    LightEnemyBattler        = nil
    LightEnemySprite         = nil
    LightArena               = nil
    LightEncounter           = nil
    LightSoul                = nil
    LightBattleUI            = nil
    HelpWindow               = nil
    LightDamageNumber        = nil
    LightGauge               = nil
    LightTensionBar          = nil
    LightActionButton        = nil
    LightActionBoxSingle     = nil
    LightAttackBox           = nil
    LightAttackBar           = nil
    RandomEncounter          = nil
    LightShop                = nil
end

function lib:save(data)
    data.magical_glass = {}
    data.magical_glass["kills"] = lib.kills
    data.magical_glass["game_overs"] = lib.game_overs
    data.magical_glass["serious_mode"] = lib.serious_mode
    data.magical_glass["name_color"] = lib.name_color
    data.magical_glass["lw_save_lv"] = Game.party[1]:getLightLV()
    if lib.light_inv and not lib.light_inv_saved then
        data.magical_glass["light_inv"] = lib.light_inv:save()
        data.magical_glass["light_inv_saved"] = true
    end
    if lib.dark_inv and not lib.dark_inv_saved then
        data.magical_glass["dark_inv"] = lib.dark_inv:save()
        data.magical_glass["dark_inv_saved"] = true
    end
    data.magical_glass["light_equip"] = lib.light_equip
    data.magical_glass["dark_equip"] = lib.dark_equip
end

function lib:load(data, new_file)
    if Kristal.getModOption("encounter") then
        Game.save_name = Game.save_name or Kristal.Config["defaultName"] or "PLAYER"
    end
    
    if new_file then
        lib.kills = 0        
        lib.game_overs = lib.game_overs or 0
        lib.serious_mode = false -- makes items use their serious name in battle, if they have one
        lib.name_color = COLORS.yellow -- use MagicalGlassLib:changeSpareColor() to change this
        lib.lw_save_lv = 0
        lib.light_equip = {}
        lib.dark_equip = {}
    else
		data.magical_glass = data.magical_glass or {}
        lib.kills = data.magical_glass["kills"] or 0
        lib.game_overs = lib.game_overs or data.magical_glass["game_overs"] or 0
        lib.serious_mode = data.magical_glass["serious_mode"] or false
        lib.name_color = data.magical_glass["name_color"] or COLORS.yellow
        lib.lw_save_lv = data.magical_glass["lw_save_lv"] or 0
        lib.light_inv = data.magical_glass["light_inv"]
        lib.light_inv_saved = data.magical_glass["light_inv_saved"]
        lib.dark_inv = data.magical_glass["dark_inv"]
        lib.dark_inv_saved = data.magical_glass["dark_inv_saved"]
        lib.light_equip = data.magical_glass["light_equip"] or {}
        lib.dark_equip = data.magical_glass["dark_equip"] or {}
    end
end

function lib:preInit()
    
    self.random_encounters = {}
    self.light_encounters = {}
    self.light_enemies = {}
    self.light_shops = {}

    for _,path,rnd_enc in Registry.iterScripts("battle/randomencounters") do
        assert(rnd_enc ~= nil, '"randomencounters/'..path..'.lua" does not return value')
        rnd_enc.id = rnd_enc.id or path
        self.random_encounters[rnd_enc.id] = rnd_enc
    end

    for _,path,light_enc in Registry.iterScripts("battle/lightencounters") do
        assert(light_enc ~= nil, '"lightencounters/'..path..'.lua" does not return value')
        light_enc.id = light_enc.id or path
        self.light_encounters[light_enc.id] = light_enc
    end

    for _,path,light_enemy in Registry.iterScripts("battle/lightenemies") do
        assert(light_enemy ~= nil, '"lightenemies/'..path..'.lua" does not return value')
        light_enemy.id = light_enemy.id or path
        self.light_enemies[light_enemy.id] = light_enemy
    end

    for _,path,light_shop in Registry.iterScripts("lightshops") do
        assert(light_shop ~= nil, '"lightshops/'..path..'.lua" does not return value')
        light_shop.id = light_shop.id or path
        self.light_shops[light_shop.id] = light_shop
    end
    
end

function lib:init()

    print("Loaded Magical Glass " .. self.info.version .. "!")

    self.encounters_enabled = false
    self.steps_until_encounter = nil

    Utils.hook(Game, "enterShop", function(orig, self, shop, options)
        if lib.in_light_shop then
            MagicalGlassLib:enterLightShop(shop, options)
        else
            orig(self, shop, options)
        end
    end)

    Utils.hook(World, "lightShopTransition", function(orig, self, shop, options)
        self:fadeInto(function()
            MagicalGlassLib:enterLightShop(shop, options)
        end)
    end)
    
    Utils.hook(Battle, "init", function(orig, self)
        orig(self)
        self.light = false
    end)

    Utils.hook(Game, "setLight", function(orig, self, light)
        light = light or false

        if not self.started then
            self.light = light
            return
        end

        if self.light == light then return end

        self.light = light
        
        if self.light then
            for _,party in pairs(self.party_data) do
                if not lib.dark_equip[party.id] then
                    lib.dark_equip[party.id] = {}
                    lib.dark_equip[party.id].armor = {}
                end
                lib.dark_equip[party.id].weapon = party:getWeapon() and party:getWeapon().id or false
                for i = 1, 2 do
                    lib.dark_equip[party.id].armor[i] = party:getArmor(i) and party:getArmor(i).id or false
                end
            end
            
            lib.dark_inv = self.inventory
            lib.dark_inv_saved = false
            
            local has_shadowcrystal = self.inventory:getItemByID("shadowcrystal") and true or false
            local has_egg = self.inventory:getItemByID("egg") and true or false
            if Kristal.getLibConfig("magical-glass", "key_items_conversion") then
                Game:setFlag("has_cell_phone", Game.inventory:getItemByID("cell_phone") and true or false)
            end
            
            self.inventory = LightInventory()
            if lib.light_inv_saved then
                self.inventory:load(lib.light_inv)
            elseif lib.light_inv then
                self.inventory = lib.light_inv
            end
            
            if Kristal.getLibConfig("magical-glass", "key_items_conversion") then
                if not self.inventory:getItemByID("light/ball_of_junk") then
                    self.inventory:addItem(Registry.createItem("light/ball_of_junk"))
                end
                
                if has_shadowcrystal then
                    if not self.inventory:getItemByID("light/glass") then
                        self.inventory:addItem(Registry.createItem("light/glass"))
                    end
                else
                    while self.inventory:getItemByID("light/glass") do
                        self.inventory:removeItem(self.inventory:getItemByID("light/glass"))
                    end
                end
                if has_egg then
                    if not self.inventory:getItemByID("light/egg") then
                        self.inventory:addItem(Registry.createItem("light/egg"))
                    end
                else
                    while self.inventory:getItemByID("light/egg") do
                        self.inventory:removeItem(self.inventory:getItemByID("light/egg"))
                    end
                end
            end
            
            for _,party in pairs(self.party_data) do
                if lib.light_equip[party.id] then
                    if lib.light_equip[party.id].weapon then
                        party:setWeapon(lib.light_equip[party.id].weapon)
                    else
                        party:setWeapon(nil)
                    end
                else
                    party:setWeapon(party.lw_weapon_default)
                end
                if lib.light_equip[party.id] then
                    if lib.light_equip[party.id].armor[1] then
                        party:setArmor(1, lib.light_equip[party.id].armor[1])
                    else
                        party:setArmor(1, nil)
                    end
                else
                    party:setArmor(1, party.lw_armor_default)
                end
                party:setArmor(2, nil)
            end
        else
            for _,party in pairs(self.party_data) do
                if not lib.light_equip[party.id] then
                    lib.light_equip[party.id] = {}
                    lib.light_equip[party.id].armor = {}
                end
                lib.light_equip[party.id].weapon = party:getWeapon() and party:getWeapon().id or false
                lib.light_equip[party.id].armor[1] = party:getArmor(1) and party:getArmor(1).id or false
            end
            
            lib.light_inv = self.inventory
            lib.light_inv_saved = false
            
            self.inventory = DarkInventory()
            if lib.dark_inv_saved then
                self.inventory:load(lib.dark_inv)
            elseif lib.dark_inv then
                self.inventory = lib.dark_inv
            end
            
            if Kristal.getLibConfig("magical-glass", "key_items_conversion") then
                if Game:getFlag("tossed_ball_of_junk") then
                    for i = 1, self.inventory.storages.items.max do
                        self.inventory.storages.items[i] = nil
                    end
                    for i = 1, self.inventory.storages.weapons.max do
                        self.inventory.storages.weapons[i] = nil
                    end
                    for i = 1, self.inventory.storages.armors.max do
                        self.inventory.storages.armors[i] = nil
                    end
                end
                if Game:getFlag("has_cell_phone", Kristal.getModOption("cell") ~= false) then
                    if not Game.inventory:getItemByID("cell_phone") then
                        Game.inventory:addItemTo("key_items", 1, Registry.createItem("cell_phone"))
                    end
                else
                    while Game.inventory:getItemByID("cell_phone") do
                        Game.inventory:removeItem(Game.inventory:getItemByID("cell_phone"))
                    end
                end
            end
            
            Game:setFlag("tossed_ball_of_junk", nil)

            for _,party in pairs(self.party_data) do
                if lib.dark_equip[party.id] then
                    if lib.dark_equip[party.id].weapon then
                        party:setWeapon(lib.dark_equip[party.id].weapon)
                    else
                        party:setWeapon(nil)
                    end
                else
                    if party:getFlag("weapon_default") then
                        party:setWeapon(party:getFlag("weapon_default"))
                    else
                        party:setWeapon(nil)
                    end
                end
                for i = 1, 2 do
                    if lib.dark_equip[party.id] then
                        if lib.dark_equip[party.id].armor[i] then
                            party:setArmor(i, lib.dark_equip[party.id].armor[i])
                        else
                            party:setArmor(i, nil)
                        end
                    else
                        if party:getFlag("armor_default")[i] then
                            party:setArmor(i, party:getFlag("armor_default")[i])
                        else
                            party:setArmor(i, nil)
                        end
                    end
                end
            end
        end
    end)

    Utils.hook(Actor, "init", function(orig, self)
        orig(self)
        self.undertale_movement = false
        self.use_light_battler_sprite = false
        self.light_battler_parts = {}
    end)

    Utils.hook(Actor, "getWidth", function(orig, self)
        if Game.battle and Game.battle.light and self.use_light_battler_sprite then
            return self.light_battle_width or self.width
        else
            return self.width
        end
    end)

    Utils.hook(Actor, "getHeight", function(orig, self)
        if Game.battle and Game.battle.light and self.use_light_battler_sprite then
            return self.light_battle_height or self.height
        else
            return self.height
        end
    end)

    Utils.hook(Actor, "addLightBattlerPart", function(orig, self, id, data)
        self.light_battler_parts[id] = data
    end)

    Utils.hook(Actor, "getLightBattlerPart", function(orig, self, part)
        return self.light_battler_parts[part]
    end)

    Utils.hook(Actor, "createLightBattleSprite", function(orig, self)
        return LightEnemySprite(self)
    end)

    Utils.hook(ActorSprite, "init", function(orig, self, actor)
        orig(self, actor)
        
        self.run_away_light = false
    end)

    Utils.hook(ActorSprite, "update", function(orig, self)
        orig(self)
    
        if self.run_away_light then
            self.run_away_timer = self.run_away_timer + DTMULT
        end
    end)
    
    Utils.hook(ActorSprite, "draw", function(orig, self)
        if self.actor:preSpriteDraw(self) then
            return
        end
        
        if self.texture and self.run_away_light then
            local r,g,b,a = self:getDrawColor()
            for i = 0, 120 do
                local alph = a * 0.4
                Draw.setColor(r,g,b, ((alph - (self.run_away_timer / 8)) + (i / 200)))
                Draw.draw(self.texture, i * 2, 0)
            end
            return
        end
        
        orig(self)
    end)

    Utils.hook(DebugSystem, "registerDefaults", function(orig, self)
        -- wish i didn't have to do this but
    
        local in_game = function() return Kristal.getState() == Game end
        local in_battle = function() return in_game() and Game.state == "BATTLE" end
        local in_dark_battle = function() return in_game() and Game.state == "BATTLE" and not Game.battle.light end
        local in_light_battle = function() return in_game() and Game.state == "BATTLE" and Game.battle.light end
        local in_overworld = function() return in_game() and Game.state == "OVERWORLD" end 

        self:registerConfigOption("main", "Object Selection Pausing", "Pauses the game when the object selection menu is opened.", "objectSelectionSlowdown")

        self:registerOption("main", "Engine Options", "Configure various noningame options.", function()
            self:enterMenu("engine_options", 1)
        end)

        self:registerOption("main", "Fast Forward", function() return self:appendBool("Speed up the engine.", FAST_FORWARD) end, function() FAST_FORWARD = not FAST_FORWARD end)
        self:registerOption("main", "Debug Rendering", function() return self:appendBool("Draw debug information.", DEBUG_RENDER) end, function() DEBUG_RENDER = not DEBUG_RENDER end)
        self:registerOption("main", "Hotswap", "Swap out code from the files. Might be unstable.", function() Hotswapper.scan(); self:refresh() end)
        self:registerOption("main", "Reload", "Reload the mod. Hold shift to\nnot temporarily save.", function()
            if Kristal.getModOption("hardReset") then
                love.event.quit("restart")
            else
                if Mod then
                    Kristal.quickReload(Input.shift() and "save" or "temp")
                else
                    Kristal.returnToMenu()
                end
            end
        end)

        self:registerOption("main", "Noclip",
            function() return self:appendBool("Toggle interaction with solids.", NOCLIP) end,
            function() NOCLIP = not NOCLIP end,
            in_game
        )

        self:registerOption("main", "Give Item", "Give an item.", function()
            self:enterMenu("give_item", 0)
        end, in_game)

        self:registerOption("main", "Portrait Viewer", "Enter the portrait viewer menu.", function()
            self:setState("FACES")
        end, in_game)

        self:registerOption("main", "Flag Editor", "Enter the flag editor menu.", function()
            self:setState("FLAGS")
        end, in_game)

        self:registerOption("main", "Sound Test", "Enter the sound test menu.", function()
            self:fadeMusicOut()
            self:enterMenu("sound_test", 0)
        end, in_game)


        -- World specific
        self:registerOption("main", "Select Map", "Switch to a new map.", function()
            self:enterMenu("select_map", 0)
        end, in_overworld)

        self:registerOption("main", "Start Encounter", "Start an encounter.", function()
            self:enterMenu("encounter_select", 0)
        end, in_overworld)

        self:registerOption("main", "Enter Shop", "Enter a shop.", function()
            self:enterMenu("select_shop", 0)
        end, in_overworld)

        self:registerOption("main", "Play Cutscene", "Play a cutscene.", function()
            self:enterMenu("cutscene_select", 0)
        end, in_overworld)

        -- Battle specific
        self:registerOption("main", "Start Wave", "Start a wave.", function()
            self:enterMenu("wave_select", 0)
        end, in_dark_battle)

        self:registerOption("main", "Start Wave", "Start a wave.", function()
            self:enterMenu("wave_select_light", 0)
        end, in_light_battle)

        self:registerOption("main", "End Battle", "Instantly complete a battle.", function()
            Game.battle:setState("VICTORY")
        end, in_dark_battle)
        
        self:registerOption("main", "End Battle", "Instantly complete a battle.", function()
            Game.battle.forced_victory = true
            if Game.battle.state == "DEFENDING" then
                Game.battle.encounter:onWavesDone()
            end
            Game.battle:setState("VICTORY")
        end, in_light_battle)

    end)

    Utils.hook(Game, "load", function(orig, self, data, index, fade)
        orig(self, data, index, fade)
        self.is_new_file = data == nil

        data = data or {}
  
        if Game:getFlag("temporary_world_value#") then
            if Game:getFlag("temporary_world_value#") == "light" then
                self.inventory = DarkInventory()
            elseif Game:getFlag("temporary_world_value#") == "dark" then
                self.inventory = LightInventory()
            end
    
            if data.inventory then
                self.inventory:load(data.inventory)
            else
                local default_inv = Kristal.getModOption("inventory") or {}
                if not self.light and not default_inv["key_items"] then
                    default_inv["key_items"] = {"cell_phone"}
                end
                for storage,items in pairs(default_inv) do
                    for i,item in ipairs(items) do
                        self.inventory:setItem(storage, i, item)
                    end
                end
            end
        
            local loaded_light = data.light or false
        
            -- Party members have to be converted to light initially, due to dark world defaults
            if loaded_light ~= self.light then
                if self.light then
                    for _,chara in pairs(self.party_data) do
                        chara:convertToLight()
                    end
                else
                    for _,chara in pairs(self.party_data) do
                        chara:convertToDark()
                    end
                end
            end
        
            if self.is_new_file then
                Game:setFlag("has_cell_phone", Kristal.getModOption("cell") ~= false)
        
                for id,equipped in pairs(Kristal.getModOption("equipment") or {}) do
                    if equipped["weapon"] then
                        self.party_data[id]:setWeapon(equipped["weapon"] ~= "" and equipped["weapon"] or nil)
                    end
                    local armors = equipped["armor"] or {}
                    for i = 1, 2 do
                        if armors[i] then
                            if self.light and i == 2 then
                                local main_armor = self.party_data[id]:getArmor(1)
                                if not main_armor:includes(LightEquipItem) then
                                    error("Cannot set 2nd armor, 1st armor must be a LightEquipItem")
                                end
                                main_armor:setArmor(2, armors[i])
                            else
                                self.party_data[id]:setArmor(i, armors[i] ~= "" and armors[i] or nil)
                            end
                        end
                    end
                end
            end
        end
    end)

    Utils.hook(Game, "encounter", function(orig, self, encounter, transition, enemy, context)
        -- the worst thing ever

        if Game:getFlag("temporary_world_value#") then
            if Game:getFlag("temporary_world_value#") == "dark" then
                if Game:isLight() then
                    Game:setLight(true)
                else
                    Game.light = true
                end
            elseif Game:getFlag("temporary_world_value#") == "light" then
                if not Game:isLight() then
                    Game:setLight(false)
                else
                    Game.light = false
                end
            end
        end

        if Game:getFlag("current_battle_system#") then
            if Game:getFlag("current_battle_system#") == "undertale" then
                Game:encounterLight(encounter, transition, enemy, context)
            elseif Game:getFlag("current_battle_system#") == "deltarune" then
                orig(self, encounter, transition, enemy, context)
            end
        elseif context then
            if isClass(context) and context:includes(ChaserEnemy) then
                if context.light_encounter then
                    Game:setFlag("current_battle_system#", "undertale")
                    Game:encounterLight(encounter, transition, enemy, context)
                elseif context.encounter then
                    Game:setFlag("current_battle_system#", "deltarune")
                    orig(self, encounter, transition, enemy, context)
                end
            end
        else
            if Kristal.getLibConfig("magical-glass", "default_battle_system") == "undertale" then
                Game:setFlag("current_battle_system#", "undertale")
                Game:encounterLight(encounter, transition, enemy, context)
            elseif Kristal.getLibConfig("magical-glass", "default_battle_system") == "deltarune" then
                Game:setFlag("current_battle_system#", "deltarune")
                orig(self, encounter, transition, enemy, context)
            end
        end

    end)

    Utils.hook(Game, "encounterLight", function(orig, self, encounter, transition, enemy, context)
        if transition == nil then transition = true end

        if self.battle then
            error("Attempt to enter light battle while already in battle")
        end
        
        if enemy and not isClass(enemy) then
            self.encounter_enemies = enemy
        else
            self.encounter_enemies = {enemy}
        end

        self.state = "BATTLE"

        self.battle = LightBattle()

        if context then
            self.battle.encounter_context = context
        end

        if type(transition) == "string" then
            self.battle:postInit(transition, encounter)
        else
            self.battle:postInit(transition and "TRANSITION" or "INTRO", encounter)
        end

        self.stage:addChild(self.battle)
    end)

    Utils.hook(ChaserEnemy, "init", function(orig, self, actor, x, y, properties)
    
        ChaserEnemy.__super.init(self, actor, x, y)

        properties = properties or {}
    
        if properties["sprite"] then
            self.sprite:setSprite(properties["sprite"])
        elseif properties["animation"] then
            self.sprite:setAnimation(properties["animation"])
        end
    
        if properties["facing"] then
            self:setFacing(properties["facing"])
        end
    
        self.encounter = properties["encounter"]
        self.light_encounter = properties["lightencounter"]

        self.enemy = properties["enemy"]
        self.light_enemy = properties["lightenemy"]

        self.group = properties["group"]
    
        self.path = properties["path"]
        self.speed = properties["speed"] or 6
    
        self.progress = (properties["progress"] or 0) % 1
        self.reverse_progress = false
    
        self.can_chase = properties["chase"]
        self.chase_speed = properties["chasespeed"] or 9
        self.chase_dist = properties["chasedist"] or 200
        self.chasing = properties["chasing"] or false
    
        self.alert_timer = 0
        self.alert_icon = nil
    
        self.noclip = true
        self.enemy_collision = true
    
        self.remove_on_encounter = true
        self.encountered = false
        self.once = properties["once"] or false
    
        if properties["aura"] == nil then
            self.sprite.aura = Game:getConfig("enemyAuras")
        else
            self.sprite.aura = properties["aura"]
        end

    end)

    Utils.hook(ChaserEnemy, "onCollide", function(orig, self, player)

        if self:isActive() and player:includes(Player) then
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
                if Kristal.getLibConfig("magical-glass", "force_light_mode_in_light_battles") then
                    Game:setFlag("temporary_world_value#", "dark")
                    Game:setLight(true)
                end

                encounter = self.light_encounter
                enemy = self.light_enemy
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
                self.sprite:setAnimation("hurt")
                self.sprite.aura = false
                Game.lock_movement = true
                self.world.timer:script(function(wait)
                    Assets.playSound("tensionhorn")
                    wait(8/30)
                    local src = Assets.playSound("tensionhorn")
                    src:setPitch(1.1)
                    wait(12/30)
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
    end)

    if not Mod.libs["widescreen"] then
        Utils.hook(Battle, "postInit", function(orig, self, state, encounter)
            self.state = state
        
            if type(encounter) == "string" then
                self.encounter = Registry.createEncounter(encounter)
            else
                self.encounter = encounter
            end

            if self.encounter:includes(LightEncounter) then
                error("Attempted to create a LightEncounter in a Dark battle")
            end

            if Game.world.music:isPlaying() and self.encounter.music then
                self.resume_world_music = true
                Game.world.music:pause()
            end
        
            if self.encounter.queued_enemy_spawns then
                for _,enemy in ipairs(self.encounter.queued_enemy_spawns) do
                    if state == "TRANSITION" then
                        enemy.target_x = enemy.x
                        enemy.target_y = enemy.y
                        enemy.x = SCREEN_WIDTH + 200
                    end
                    table.insert(self.enemies, enemy)
                    self:addChild(enemy)
                end
            end
        
            self.battle_ui = BattleUI()
            self:addChild(self.battle_ui)
        
            self.tension_bar = TensionBar(-25, 40, true)
            self:addChild(self.tension_bar)
        
            self.battler_targets = {}
            for index, battler in ipairs(self.party) do
                local target_x, target_y = self.encounter:getPartyPosition(index)
                table.insert(self.battler_targets, {target_x, target_y})
        
                if state ~= "TRANSITION" then
                    battler:setPosition(target_x, target_y)
                end
            end
        
            for _,enemy in ipairs(self.enemies) do
                self.enemy_beginning_positions[enemy] = {enemy.x, enemy.y}
            end
            if Game.encounter_enemies then
                for _,from in ipairs(Game.encounter_enemies) do
                    if not isClass(from) then
                        local enemy = self:parseEnemyIdentifier(from[1])
                        from[2].visible = false
                        from[2].battler = enemy
                        self.enemy_beginning_positions[enemy] = {from[2]:getScreenPos()}
                        self.enemy_world_characters[enemy] = from[2]
                        if state == "TRANSITION" then
                            enemy:setPosition(from[2]:getScreenPos())
                        end
                    else
                        for _,enemy in ipairs(self.enemies) do
                            if enemy.actor and from.actor and enemy.actor.id == from.actor.id then
                                from.visible = false
                                from.battler = enemy
                                self.enemy_beginning_positions[enemy] = {from:getScreenPos()}
                                self.enemy_world_characters[enemy] = from
                                if state == "TRANSITION" then
                                    enemy:setPosition(from:getScreenPos())
                                end
                                break
                            end
                        end
                    end
                end
            end
        
            if self.encounter_context and self.encounter_context:includes(ChaserEnemy) then
                for _,enemy in ipairs(self.encounter_context:getGroupedEnemies(true)) do
                    enemy:onEncounterStart(enemy == self.encounter_context, self.encounter)
                end
            end
        
            if state == "TRANSITION" then
                self.transitioned = true
                self.transition_timer = 0
                self.afterimage_count = 0
            else
                self.transition_timer = 10
        
                if state ~= "INTRO" then
                    self:nextTurn()
                end
            end
        
            if not self.encounter:onBattleInit() then
                self:setState(state)
            end

        end)
    end

    Utils.hook(Battle, "returnToWorld", function(orig, self)
        orig(self)
        Game:setFlag("current_battle_system#", nil)
        if Game:getFlag("temporary_world_value#") == "light" then
            Game:setLight(true)
            MagicalGlassLib:loadStorageAndEquips()
            Game:setFlag("temporary_world_value#", nil)
        end
    end)

    Utils.hook(Wave, "init", function(orig, self)
        orig(self)
        self.has_soul = true
        self.darken = false
        self.auto_clear = true
    end)
    
    Utils.hook(Wave, "setArenaSize", function(orig, self, width, height)
        if Game.battle.light then
            self.arena_width = width
            self.arena_height = height or width
        else
            orig(self, width, height)
        end
    end)

    Utils.hook(Wave, "setArenaPosition", function(orig, self, x, y)
        if Game.battle.light then
            self.arena_x = x
            self.arena_y = y
        else
            orig(self, x, y)
        end
    end)

    Utils.hook(Wave, "getMenuAttackers", function(orig, self)
        local result = {}
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            local wave = enemy.selected_menu_wave
            if type(wave) == "table" and wave.id == self.id or wave == self.id then
                table.insert(result, enemy)
            end
        end
        return result
    end)

    Utils.hook(Wave, "spawnBulletTo", function(orig, self, parent, bullet, ...)
        local new_bullet
        if isClass(bullet) and bullet:includes(Bullet) then
            new_bullet = bullet
        elseif Registry.getBullet(bullet) then
            new_bullet = Registry.createBullet(bullet, ...)
        else
            local x, y = ...
            table.remove(arg, 1)
            table.remove(arg, 1)
            new_bullet = Bullet(x, y, bullet, unpack(arg))
        end
        new_bullet.wave = self
        local attackers
        if Game.battle.light and #Game.battle.menu_waves > 0 then
            attackers = self:getMenuAttackers()
        end
        if #Game.battle.waves > 0 then
            attackers = self:getAttackers()
        end
        if #attackers > 0 then
            new_bullet.attacker = Utils.pick(attackers)
        end
        table.insert(self.bullets, new_bullet)
        table.insert(self.objects, new_bullet)
        if parent then
            new_bullet:setParent(parent)
        elseif not new_bullet.parent then
            Game.battle:addChild(new_bullet)
        end
        new_bullet:onWaveSpawn(self)
        return new_bullet
    end)

    Utils.hook(Item, "init", function(orig, self)
    
        orig(self)
        -- Short name for the light battle item menu
        self.short_name = nil
        -- Serious name for the light battle item menu
        self.serious_name = nil

        self.tags = {}

        -- How this item is used on you (ate, drank, eat, etc.)
        self.use_method = "ate"
        -- How this item is used on other party members (eats, etc.)
        self.use_method_other = nil
    
    end)

    Utils.hook(Item, "getLightShopDescription", function(orig, self)
        return self:getLightTypeName() .. "\n" .. self.shop
    end)

    Utils.hook(Item, "getLightTypeName", function(orig, self)
        if self.type == "weapon" then
            return "Weapon: " .. self:getStatBonus("attack") .. "AT"
        elseif self.type == "armor" then
            return "Armor: " .. self:getStatBonus("defense") .. "DF"
        end
        return ""
    end)

    Utils.hook(Item, "getShortName", function(orig, self) return self.short_name or self.serious_name or self.name end)
    Utils.hook(Item, "getSeriousName", function(orig, self) return self.serious_name or self.short_name or self.name end)

    Utils.hook(Item, "getUseName", function(orig, self)
        if (Game.state == "OVERWORLD" and Game:isLight()) or (Game.state == "BATTLE" and Game.battle.light)  then
            return self.use_name or self:getName()
        else
            return self.use_name or self:getName():upper()
        end
    end)

    Utils.hook(Item, "getUseMethod", function(orig, self, target)
        if type(target) == "string" then
            if target == "other" and self.use_method_other then
                return self.use_method_other
            elseif target == "self" and self.use_method_self then
                return self.use_method
            else
                return self.use_method
            end
        elseif isClass(target) then
            if (target.id ~= Game.party[1].id and self.use_method_other and self.target ~= "party") or force_other then
                return self.use_method_other
            else
                return self.use_method
            end
        end
    end)
    
    Utils.hook(Item, "battleUseSound", function(orig, self, user, target) end)

    Utils.hook(Item, "onLightBattleUse", function(orig, self, user, target)
        self:battleUseSound(user, target)
        if self.getLightBattleText then
            Game.battle:battleText(self:getLightBattleText(user, target))
        else
            Game.battle:battleText("* "..user.chara:getName().." used the "..self:getName().."!")
        end
    end)
    
    Utils.hook(Item, "onLightAttack", function(orig, self, battler, enemy, damage, stretch)
        local src = Assets.stopAndPlaySound(self.getLightAttackSound and self:getLightAttackSound() or "laz_c") 
        src:setPitch(self.getLightAttackPitch and self:getLightAttackPitch() or 1)

        local sprite = Sprite(self.getLightAttackSprite and self:getLightAttackSprite() or "effects/attack/strike")
        local scale = (stretch * 2) - 0.5
        sprite:setScale(scale, scale)
        sprite:setOrigin(0.5, 0.5)
        sprite:setPosition(enemy:getRelativePos((enemy.width / 2) - 5, (enemy.height / 2) - 5))
        sprite.layer = BATTLE_LAYERS["above_ui"] + 5
        sprite.color = battler.chara:getLightAttackColor()
        enemy.parent:addChild(sprite)
        sprite:play((stretch / 4) / 1.5, false, function(this) -- timing may still be incorrect
            local sound = enemy:getDamageSound() or "damage"
            if sound and type(sound) == "string" and (damage > 0 or enemy.always_play_damage_sound) then
                Assets.stopAndPlaySound(sound)
            end
            enemy:hurt(damage, battler)

            battler.chara:onLightAttackHit(enemy, damage)
            this:remove()

            Game.battle:endAttack()
        end)
    end)

    Utils.hook(Item, "onLightMiss", function(orig, self, battler, enemy, finish, anim)
        enemy:hurt(0, battler, on_defeat, {battler.chara:getLightMissColor()}, anim)
        if finish then
            Game.battle:endAttack()
        end
    end)

    Utils.hook(Item, "onCheck", function(orig, self)
        if type(self.check) == "string" then
            Game.world:showText("* \""..self:getName().."\" - "..self:getCheck())
        elseif type(self.check) == "table" then
            local text = {}
            for i, check in ipairs(self:getCheck()) do
                if i > 1 then
                    table.insert(text, check)
                end
            end
            Game.world:showText({{"* \""..self:getName().."\" - "..self:getCheck()[1]}, text})
        end
    end)
        
    Utils.hook(Item, "onToss", function(orig, self)
        if Game:isLight() then
            local choice = love.math.random(30)
            if choice == 1 then
                Game.world:showText("* You bid a quiet farewell\n to the " .. self:getName() .. ".")
            elseif choice == 2 then
                Game.world:showText("* You put the " .. self:getName() .. "\non the ground and gave it a\nlittle pat.")
            elseif choice == 3 then
                Game.world:showText("* You threw the " .. self:getName() .. "\non the ground like the piece\nof trash it is.")
            elseif choice == 4 then
                Game.world:showText("* You abandoned the\n" .. self:getName() .. ".")
            else
                Game.world:showText("* The " .. self:getName() .. " was\nthrown away.")
            end
        end
        return true
    end)

    Utils.hook(Item, "onActionSelect", function(orig, self, battler) end)

    Utils.hook(Item, "save", function(orig, self)
        local saved_dark_item = self.dark_item
        local saved_light_item = self.light_item
        if isClass(self.dark_item) then saved_dark_item = self.dark_item:save() end
        if isClass(self.light_item) then saved_light_item = self.light_item:save() end

        local data = {
            id = self.id,
            flags = self.flags,

            dark_item = saved_dark_item,
            dark_location = self.dark_location,

            light_item = saved_light_item,
            light_location = self.light_location,
        }
        self:onSave(data)
        return data
    end)

    Utils.hook(Battler, "lightStatusMessage", function(orig, self, x, y, type, arg, color, kill)
        x, y = self:getRelativePos(x, y)

        local offset = 0
        if not kill then
            offset = (self.hit_count * 20)
        end
        
        local offset_x, offset_y = Utils.unpack(self:getDamageOffset())
        
        local percent = LightDamageNumber(type, arg, x + offset_x, y + (offset_y - 2) - offset, color)
        if (type == "mercy" and self:getMercyVisibility()) or type == "damage" or type == "msg" then
            if kill then
                percent.kill_others = true
            end
            self.parent:addChild(percent)
        
            if not kill then
                self.hit_count = self.hit_count + 1
            end
        end

        if type ~= "msg" then
            if (type == "damage" and self:getHPVisibility()) or (type == "mercy" and self:getMercyVisibility()) then
                local gauge = LightGauge(type, arg, x + offset_x, y + offset_y + 8, self)
                self.parent:addChild(gauge)
            end
        end
    
        return percent
    end)

    Utils.hook(Textbox, "init", function(orig, self, x, y, width, height, default_font, default_font_size, battle_box)
        Textbox.__super.init(self, x, y, width, height)

        self.box = UIBox(0, 0, width, height)
        self.box.layer = -1
        self.box.debug_select = false
        self:addChild(self.box)
    
        self.battle_box = battle_box
        if battle_box then
            self.box.visible = false
        end

        if battle_box then
            if Game.battle.light then
                self.face_x = 6
                self.face_y = -2
        
                self.text_x = 0
                self.text_y = -2 
            else
                self.face_x = -4
                self.face_y = 2
        
                self.text_x = 0
                self.text_y = -2 -- TODO: This was changed 2px lower with the new font, but it was 4px offset. Why? (Used to be 0)
            end
        elseif Game:isLight() then
            self.face_x = 13
            self.face_y = 6
    
            self.text_x = 2
            self.text_y = -4
        else
            self.face_x = 18
            self.face_y = 6
    
            self.text_x = 2
            self.text_y = -4  -- TODO: This was changed with the new font but it's accurate anyways
        end
    
        self.actor = nil
    
        default_font = default_font
            or Kristal.callEvent("getDefaultDialogTextFont")

        self.default_font = default_font or "main_mono"
        self.default_font_size = default_font_size
    
        self.font = self.default_font
        self.font_size = self.default_font_size
    
        self.face = Sprite(nil, self.face_x, self.face_y, nil, nil, "face")
        self.face:setScale(2, 2)
        self.face.getDebugOptions = function(self2, context)
            context = super.getDebugOptions(self2, context)
            if Kristal.DebugSystem then
                context:addMenuItem("Change", "Change this portrait to a different one", function()
                    Kristal.DebugSystem:setState("FACES", self)
                end)
            end
            return context
        end
        self:addChild(self.face)
    
        -- Added text width for autowrapping
        self.wrap_add_w = battle_box and 0 or 14
    
        self.text = DialogueText("", self.text_x, self.text_y, width + self.wrap_add_w, SCREEN_HEIGHT)
        self:addChild(self.text)
    
        self.reactions = {}
        self.reaction_instances = {}
    
        self.text:registerCommand("face", function(text, node, dry)
            if self.actor and self.actor:getPortraitPath() then
                self.face.path = self.actor:getPortraitPath()
            end
            self:setFace(node.arguments[1], tonumber(node.arguments[2]), tonumber(node.arguments[3]))
        end)
        self.text:registerCommand("facec", function(text, node, dry)
            self.face.path = "face"
            local ox, oy = tonumber(node.arguments[2]), tonumber(node.arguments[3])
            if self.actor then
                local actor_ox, actor_oy = self.actor:getPortraitOffset()
                ox = (ox or 0) - actor_ox
                oy = (oy or 0) - actor_oy
            end
            self:setFace(node.arguments[1], ox, oy)
        end)
    
        self.text:registerCommand("react", function(text, node, dry)
            local react_data
            if #node.arguments > 1 then
                react_data = {
                    text = node.arguments[1],
                    x = tonumber(node.arguments[2]) or (self.battle_box and self.REACTION_X_BATTLE[node.arguments[2]] or self.REACTION_X[node.arguments[2]]),
                    y = tonumber(node.arguments[3]) or (self.battle_box and self.REACTION_Y_BATTLE[node.arguments[3]] or self.REACTION_Y[node.arguments[3]]),
                    face = node.arguments[4],
                    actor = node.arguments[5] and Registry.createActor(node.arguments[5]),
                }
            else
                react_data = tonumber(node.arguments[1]) and self.reactions[tonumber(node.arguments[1])] or self.reactions[node.arguments[1]]
            end
            local reaction = SmallFaceText(react_data.text, react_data.x, react_data.y, react_data.face, react_data.actor)
            reaction.layer = 0.1 + (#self.reaction_instances) * 0.01
            self:addChild(reaction)
            table.insert(self.reaction_instances, reaction)
        end, {instant = false})
    
        self.advance_callback = nil
    end)

    Utils.hook(Textbox, "advance", function(orig, self)
        self.timer:after(self.wait, function()
            self.text:advance()
        end)
    end)

   Utils.hook(DialogueText, "init", function(orig, self, text, x, y, w, h, options)
        orig(self, text, x, y, w, h, options)
        options = options or {}
        self.default_sound = options["default_sound"] or "default"
        self.no_sound_overlap = options["no_sound_overlap"] or false
    end)

    Utils.hook(DialogueText, "resetState", function(orig, self)
        DialogueText.__super.resetState(self)
        self.state["typing_sound"] = self.default_sound
    end)

    Utils.hook(DialogueText, "playTextSound", function(orig, self, current_node)
        if self.state.skipping and (Input.down("cancel") or self.played_first_sound) then
            return
        end
    
        if current_node.type ~= "character" then
            return
        end
    
        local no_sound = {"\n", " ", "^", "!", ".", "?", ",", ":", "/", "\\", "|", "*"}
    
        if (Utils.containsValue(no_sound, current_node.character)) then
            return
        end
    
        if (self.state.typing_sound ~= nil) and (self.state.typing_sound ~= "") then
            self.played_first_sound = true
            if Kristal.callEvent("onTextSound", self.state.typing_sound, current_node) then
                return
            end
            if self.no_sound_overlap then
                Assets.stopAndPlaySound("voice/"..self.state.typing_sound)
            else
                Assets.playSound("voice/"..self.state.typing_sound)
            end
        end
    end)

    --[[Utils.hook(DialogueText, "update", function(orig, self)
        local speed = self.state.speed

        if not OVERLAY_OPEN then

            if Kristal.getLibConfig("magical-glass", "undertale_text_skipping") then

                local input = self.can_advance and (Input.pressed("confirm") or (Input.down("menu") and self.fast_skipping_timer >= 1))

                if input or self.auto_advance or self.should_advance then
                    self.should_advance = false
                    if not self.state.typing then
                        self:advance()
                    end
                end
        
                if self.skippable and (Input.pressed("cancel") and not self.state.noskip) then
                    if not self.skip_speed then
                        self.state.skipping = true
                    else
                        speed = speed * 2
                    end
                end

            else
                if Input.pressed("menu") then
                    self.fast_skipping_timer = 1
                end
        
                local input = self.can_advance and (Input.pressed("confirm") or (Input.down("menu") and self.fast_skipping_timer >= 1))
        
                if input or self.auto_advance or self.should_advance then
                    self.should_advance = false
                    if not self.state.typing then
                        self:advance()
                    end
                end
        
                if Input.down("menu") then
                    if self.fast_skipping_timer < 1 then
                        self.fast_skipping_timer = self.fast_skipping_timer + DTMULT
                    end
                else
                    self.fast_skipping_timer = 0
                end
                
                if self.skippable and ((Input.down("cancel") and not self.state.noskip) or (Input.down("menu") and not self.state.noskip)) then
                    if not self.skip_speed then
                        self.state.skipping = true
                    else
                        speed = speed * 2
                    end
                end
            end
    
        end
    
        if self.state.waiting == 0 then
            self.state.progress = self.state.progress + (DT * 1 * speed)
        else
            self.state.waiting = math.max(0, self.state.waiting - DT)
        end
    
        if self.state.typing then
            self:drawToCanvas(function()
                while (math.floor(self.state.progress) > self.state.typed_characters) or self.state.skipping do
                    local current_node = self.nodes[self.state.current_node]
    
                    if current_node == nil then
                        self.state.typing = false
                        break
                    end
    
                    self:playTextSound(current_node)
                    self:processNode(current_node, false)
    
                    if self.state.skipping then
                        self.state.progress = self.state.typed_characters
                    end
    
                    self.state.current_node = self.state.current_node + 1
                end
            end)
        end
    
        self:updateTalkSprite(self.state.talk_anim and self.state.typing)
    
        DialogueText.__super.update(self)
    
        self.last_talking = self.state.talk_anim and self.state.typing
    end)]]

    Utils.hook(Bullet, "init", function(orig, self, x, y, texture)
    
        orig(self, x, y, texture)
        if Game:isLight() then
            self.inv_timer = 1
        end

    end)

    Utils.hook(LightItemMenu, "init", function(orig, self)
    
        orig(self)

        -- States: ITEMSELECT, ITEMOPTION, PARTYSELECT

        self.party_select_bg = UIBox(-36, 242, 372, 52)
        self.party_select_bg.visible = false
        self.party_select_bg.layer = -1
        self.party_selecting = 1
        self:addChild(self.party_select_bg)

    end)

    Utils.hook(LightItemMenu, "update", function(orig, self)
    
        if self.state == "ITEMOPTION" then
            if Input.pressed("cancel") then
                self.state = "ITEMSELECT"
                return
            end
    
            local old_selecting = self.option_selecting
    
            if Input.pressed("left") then
                self.option_selecting = self.option_selecting - 1
            end
            if Input.pressed("right") then
                self.option_selecting = self.option_selecting + 1
            end
    
            -- this wraps in deltatraveler lmao
            self.option_selecting = Utils.clamp(self.option_selecting, 1, 3)
    
            if self.option_selecting ~= old_selecting then
                self.ui_move:stop()
                self.ui_move:play()
            end
    
            if Input.pressed("confirm") then
                local item = Game.inventory:getItem(self.storage, self.item_selecting)
                if self.option_selecting == 1 then
                    if #Game.party > 1 and item.target == "ally" then
                        self.ui_select:stop()
                        self.ui_select:play()
                        self.party_select_bg.visible = true
                        self.party_selecting = 1
                        self.state = "PARTYSELECT"
                    elseif #Game.party > 1 and item.target == "party" then
                        self.ui_select:stop()
                        self.ui_select:play()
                        self.party_select_bg.visible = true
                        self.party_selecting = "all"
                        self.state = "PARTYSELECT"
                    else
                        self:useItem(item)
                    end
                elseif self.option_selecting == 2 then
                    item:onCheck()
                else
                    self:dropItem(item)
                end
            end
        elseif self.state == "PARTYSELECT" then
            if Input.pressed("cancel") then
                self.party_select_bg.visible = false
                self.state = "ITEMOPTION"
                return
            end
    
            if self.party_selecting ~= "all" then
                local old_selecting = self.party_selecting

                if Input.pressed("right") then
                    self.party_selecting = self.party_selecting + 1
                end
        
                if Input.pressed("left") then
                    self.party_selecting = self.party_selecting - 1
                end

                self.party_selecting = Utils.clamp(self.party_selecting, 1, #Game.party)

                if self.party_selecting ~= old_selecting then
                    self.ui_move:stop()
                    self.ui_move:play()
                end

                if Input.pressed("confirm") then
                    local item = Game.inventory:getItem(self.storage, self.item_selecting)
                    self:useItem(item, self.party_selecting)
                end
            else
                if Input.pressed("confirm") then
                    local item = Game.inventory:getItem(self.storage, self.item_selecting)
                    self:useItem(item, Game.party)
                end
            end

        else
            orig(self)
        end

    end)

    Utils.hook(LightItemMenu, "draw", function(orig, self)
        love.graphics.setFont(self.font)

        local inventory = Game.inventory:getStorage(self.storage)
    
        for index, item in ipairs(inventory) do
            if item.usable_in == "world" or item.usable_in == "all" then
                Draw.setColor(PALETTE["world_text"])
            else
                Draw.setColor(PALETTE["world_text_unusable"])
            end
            if self.state == "PARTYSELECT" then
                love.graphics.setScissor(self.x, self.y, 300, 220)
            end
            love.graphics.print(item:getName(), 20, -28 + (index * 32))
            love.graphics.setScissor()
        end

        if self.state ~= "PARTYSELECT" then
            Draw.setColor(PALETTE["world_text"])
            love.graphics.print("USE" , 20 , 284)
            love.graphics.print("INFO", 116, 284)
            love.graphics.print("DROP", 230, 284)
        end
    
        Draw.setColor(Game:getSoulColor())
        if self.state == "ITEMSELECT" then
            Draw.draw(self.heart_sprite, -4, -20 + (32 * self.item_selecting), 0, 2, 2)
        elseif self.state == "ITEMOPTION" then
            if self.option_selecting == 1 then
                Draw.draw(self.heart_sprite, -4, 292, 0, 2, 2)
            elseif self.option_selecting == 2 then
                Draw.draw(self.heart_sprite, 92, 292, 0, 2, 2)
            elseif self.option_selecting == 3 then
                Draw.draw(self.heart_sprite, 206, 292, 0, 2, 2)
            end
        elseif self.state == "PARTYSELECT" then
            local item = Game.inventory:getItem(self.storage, self.item_selecting)
            Draw.setColor(PALETTE["world_text"])

            love.graphics.printf("Use " .. item:getName() .. " on", -45, 233, 400, "center")

            if #Game.party == 2 then
                local offset = 0
                for _,party in ipairs(Game.party) do
                    love.graphics.print(party.name, 68 + offset, 269)
                    offset = offset + 122
                end

                Draw.setColor(Game:getSoulColor())
                if self.party_selecting == 1 then
                    Draw.draw(self.heart_sprite, 35, 277, 0, 2, 2)
                elseif self.party_selecting == 2 then
                    Draw.draw(self.heart_sprite, 157, 277, 0, 2, 2)
                else
                    Draw.draw(self.heart_sprite, 35, 277, 0, 2, 2)
                    Draw.draw(self.heart_sprite, 157, 277, 0, 2, 2)
                end

            elseif #Game.party == 3 then
                local offset = 0
                for _,party in ipairs(Game.party) do
                    love.graphics.print(party.name, -2 + offset, 269)
                    offset = offset + 122
                end

                Draw.setColor(Game:getSoulColor())
                if self.party_selecting == 1 then
                    Draw.draw(self.heart_sprite, -35, 277, 0, 2, 2)
                elseif self.party_selecting == 2 then
                    Draw.draw(self.heart_sprite, 87, 277, 0, 2, 2)
                elseif self.party_selecting == 3 then
                    Draw.draw(self.heart_sprite, 209, 277, 0, 2, 2)
                else
                    Draw.draw(self.heart_sprite, -35, 277, 0, 2, 2)
                    Draw.draw(self.heart_sprite, 87, 277, 0, 2, 2)
                    Draw.draw(self.heart_sprite, 209, 277, 0, 2, 2)
                end
            end

        end

        LightItemMenu.__super.draw(self)

    end)

    Utils.hook(LightItemMenu, "useItem", function(orig, self, item)
        local result
        if item.target == "ally" then
            result = item:onWorldUse(Game.party[self.party_selecting])
        elseif item.target == "party" or item.target == "none" then
            result = item:onWorldUse(Game.party)
        end
        
        if (item.type == "item" and (result == nil or result)) or (item.type ~= "item" and result) then
            if item:hasResultItem() then
                Game.inventory:replaceItem(item, item:createResultItem())
            else
                Game.inventory:removeItem(item)
            end
        end

    end)

    Utils.hook(World, "heal", function(orig, self, target, amount, text, item)
        if type(target) == "string" then
            target = Game:getPartyMember(target)
        end
        
        local play_sound = true
        if Game:isLight() then
            play_sound = false
        end

        local maxed = target:heal(amount, play_sound)

        if Game:isLight() then
            local message
            if item and item.getLightWorldHealingText then
                message = item:getLightWorldHealingText(target, amount, maxed)
            else
                if maxed then
                    message = "* Your HP was maxed out."
                else
                    message = "* You recovered " .. amount .. " HP!"
                end
            end

            if text then
                message = text .. " \n" .. message
            end
            
            if not Game.cutscene_active then
                Game.world:showText(message)
            end
        elseif self.healthbar then
            for _, actionbox in ipairs(self.healthbar.action_boxes) do
                if actionbox.chara.id == target.id then
                    local text = HPText("+" .. amount, self.healthbar.x + actionbox.x + 69, self.healthbar.y + actionbox.y + 15)
                    text.layer = WORLD_LAYERS["ui"] + 1
                    Game.world:addChild(text)
                    return
                end
            end
        end
    end)

    if not Mod.libs["widescreen"] then
        Utils.hook(WorldCutscene, "text", function(orig, self, text, portrait, actor, options)
            local function waitForTextbox(self) return not self.textbox or self.textbox:isDone() end
            if type(actor) == "table" and not isClass(actor) then
                options = actor
                actor = nil
            end
            if type(portrait) == "table" then
                options = portrait
                portrait = nil
            end
        
            options = options or {}
        
            self:closeText()
        
            local width, height = 529, 103
            if Game:isLight() then
                width, height = 530, 104
            end
        
            self.textbox = Textbox(56, 344, width, height)
            self.textbox.text.hold_skip = false
            self.textbox.layer = WORLD_LAYERS["textbox"]
            Game.world:addChild(self.textbox)
            self.textbox:setParallax(0, 0)
        
            local speaker = self.textbox_speaker
            if not speaker and isClass(actor) and actor:includes(Character) then
                speaker = actor.sprite
            end
        
            if options["talk"] ~= false then
                self.textbox.text.talk_sprite = speaker
            end
        
            actor = actor or self.textbox_actor
            if isClass(actor) and actor:includes(Character) then
                actor = actor.actor
            end
            if actor then
                self.textbox:setActor(actor)
            end
        
            if options["top"] == nil and self.textbox_top == nil then
                local _, player_y = Game.world.player:localToScreenPos()
                options["top"] = player_y > 260
            end
            if options["top"] or (options["top"] == nil and self.textbox_top) then
            local bx, by = self.textbox:getBorder()
            self.textbox.y = by + 2
            end
        
            self.textbox.active = true
            self.textbox.visible = true
            self.textbox:setFace(portrait, options["x"], options["y"])
        
            if options["reactions"] then
                for id,react in pairs(options["reactions"]) do
                    self.textbox:addReaction(id, react[1], react[2], react[3], react[4], react[5])
                end
            end
        
            if options["functions"] then
                for id,func in pairs(options["functions"]) do
                    self.textbox:addFunction(id, func)
                end
            end
        
            if options["font"] then
                if type(options["font"]) == "table" then
                    -- {font, size}
                    self.textbox:setFont(options["font"][1], options["font"][2])
                else
                    self.textbox:setFont(options["font"])
                end
            end
        
            if options["align"] then
                self.textbox:setAlign(options["align"])
            end
        
            self.textbox:setSkippable(options["skip"] or options["skip"] == nil)
            self.textbox:setAdvance(options["advance"] or options["advance"] == nil)
            self.textbox:setAuto(options["auto"])
        
            if false then -- future feature
                self.textbox:setText("[wait:2]"..text, function()
                    self.textbox:remove()
                    self:tryResume()
                end)
            else
                self.textbox:setText(text, function()
                    self.textbox:remove()
                    self:tryResume()
                end)
            end
        
            local wait = options["wait"] or options["wait"] == nil
            if not self.textbox.text.can_advance then
                wait = options["wait"] -- By default, don't wait if the textbox can't advance
            end
        
            if wait then
                return self:wait(waitForTextbox)
            else
                return waitForTextbox, self.textbox
            end
        end)
    end

    Utils.hook(PartyMember, "init", function(orig, self)
        orig(self)

        self.use_player_name = false

        self.lw_portrait = nil

        self.light_color = {1, 1, 1}
        self.light_dmg_color = {1, 0, 0}
        self.light_miss_color = {192/255, 192/255, 192/255}
        self.light_attack_color = {1, 105/255, 105/255}
        self.light_multibolt_attack_color = {1, 1, 1}
        self.light_attack_bar_color = {1, 1, 1}
        self.light_xact_color = {1, 1, 1}

        self.lw_stats["magic"] = 0
        
        local equipment = self.equipped
        Game.stage.timer:after(1/30, function()
            if self:getFlag("weapon_default") == nil then
                self:setFlag("weapon_default", equipment.weapon and equipment.weapon.id or false)
            end
            if self:getFlag("armor_default") == nil then
                self:setFlag("armor_default", {equipment.armor[1] and equipment.armor[1].id or false, equipment.armor[2] and equipment.armor[2].id or false})
            end
        end)

    end)

    Utils.hook(PartyMember, "heal", function(orig, self, amount, playsound)
        if Game:isLight() then
            if playsound == nil or playsound then
                Assets.stopAndPlaySound("power")
            end
            if self:getHealth() < self:getStat("health") then
                self:setHealth(math.min(self:getStat("health"), self:getHealth() + amount))
            end
        else
            self:setHealth(math.min(self:getStat("health"), self:getHealth() + amount))
        end
        return self:getStat("health") == self:getHealth()
    end)

    Utils.hook(PartyMember, "getName", function(orig, self)
        if Game.save_name and self:shouldUsePlayerName() then
            return Game.save_name
        else
            return self.name
        end
    end)

    Utils.hook(PartyMember, "getLightEXP", function(orig, self)
        return self.lw_exp
    end)

    Utils.hook(PartyMember, "onActionSelect", function(orig, self, battler, undo)
        if Game.battle.turn_count == 1 and not undo then
            if self:getWeapon() and self:getWeapon().onActionSelect then
                self:getWeapon():onActionSelect(self)
            end
            if self:getArmor(1) and self:getArmor(1).onActionSelect then
                self:getArmor(1):onActionSelect(self)
            end
        end
    end)
    
    Utils.hook(PartyMember, "onTurnEnd", function(orig, self, battler)
        for _,equip in ipairs(self:getEquipment()) do
            if equip.onTurnEnd then
                equip:onTurnEnd(self)
            end
        end
    end)

    Utils.hook(PartyMember, "getNameOrYou", function(orig, self)
        if self.id == Game.party[1].id then
            return "You"
        else
            return self:getName()
        end
    end)

    Utils.hook(PartyMember, "shouldUsePlayerName", function(orig, self)
        return self.use_player_name
    end)

    Utils.hook(PartyMember, "onLightLevelUp", function(orig, self)
        if self:getLightLV() < #self.lw_exp_needed then
            local old_lv = self:getLightLV()

            local new_lv
            for lv, exp in pairs(self.lw_exp_needed) do
                if self.lw_exp >= exp then
                    new_lv = lv
                end
            end

            if old_lv ~= new_lv and new_lv <= #self.lw_exp_needed then
                Assets.stopAndPlaySound("levelup")
                self:setLightLV(new_lv)
                self:lightLVStats()
            end
        end
    end)

    Utils.hook(PartyMember, "setLightEXP", function(orig, self, exp, level_up)
        self.lw_exp = Utils.clamp(exp, self.lw_exp_needed[1], self.lw_exp_needed[#self.lw_exp_needed])

        if level_up then
            self:onLightLevelUp()
        end
    end)

    Utils.hook(PartyMember, "gainLightEXP", function(orig, self, exp, level_up)
        self.lw_exp = Utils.clamp(self.lw_exp + exp, self.lw_exp_needed[1], self.lw_exp_needed[#self.lw_exp_needed])

        if level_up then
            self:onLightLevelUp()
        end
    end)

    Utils.hook(PartyMember, "setLightLV", function(orig, self, level)
        self.lw_lv = level
        self:onLightLevelUp(level)
    end)

    Utils.hook(PartyMember, "forceLightLV", function(orig, self, level)
        self.lw_lv = level

        if self.lw_lv >= #self.lw_exp_needed then
            self.lw_exp = self.lw_exp_needed[#self.lw_exp_needed]
        else
            self.lw_exp = self:getLightEXPNeeded(level)
        end
        self:lightLVStats()
    end)
    
    Utils.hook(PartyMember, "lightLVStats", function(orig, self)
        self.lw_stats = {
            health = self:getLightLV() == 20 and 99 or 16 + self:getLightLV() * 4,
            attack = 8 + self:getLightLV() * 2,
            defense = 9 + math.ceil(self:getLightLV() / 4),
            magic = 0
        }
    end)

    Utils.hook(PartyMember, "getLightPortrait", function(orig, self) return self.lw_portrait end)

    Utils.hook(PartyMember, "getLightColor", function(orig, self)
        if self.light_color and type(self.light_color) == "table" then
            return self.light_color
        end
    end)

    Utils.hook(PartyMember, "getLightDamageColor", function(orig, self)
        if self.light_dmg_color and type(self.light_dmg_color) == "table" then
            return self.light_dmg_color
        end
    end)

    Utils.hook(PartyMember, "getLightMissColor", function(orig, self)
        if self.light_miss_color and type(self.light_miss_color) == "table" then
            return self.light_miss_color
        end
    end)

    Utils.hook(PartyMember, "getLightAttackColor", function(orig, self)
        if self.light_attack_color and type(self.light_attack_color) == "table" then
            return self.light_attack_color
        end
    end)

    Utils.hook(PartyMember, "getLightMultiboltAttackColor", function(orig, self)
        if self.light_multibolt_attack_color and type(self.light_multibolt_attack_color) == "table" then
            return self.light_multibolt_attack_color
        end
    end)

    Utils.hook(PartyMember, "getLightAttackBarColor", function(orig, self)
        if self.light_attack_bar_color and type(self.light_attack_bar_color) == "table" then
            return self.light_attack_bar_color
        end
    end)

    Utils.hook(PartyMember, "getLightXActColor", function(orig, self)
        if self.light_xact_color and type(self.light_xact_color) == "table" then
            return self.light_xact_color
        end
    end)
    
    Utils.hook(PartyMember, "onLightAttackHit", function(orig, self, enemy, damage) end)

    Utils.hook(LightMenu, "draw", function(orig, self)
        Object.draw(self)

        local offset = 0
        if self.top then
            offset = 270
        end
    
        local chara = Game.party[1]
    
        love.graphics.setFont(self.font)
        Draw.setColor(PALETTE["world_text"])
        love.graphics.print(chara:getName(), 46, 60 + offset)
        love.graphics.setFont(self.font_small)
        love.graphics.print("LV  "..chara:getLightLV(), 46, 100 + offset)
        love.graphics.print("HP  "..chara:getHealth().."/"..chara:getStat("health"), 46, 118 + offset)
        -- pastency when -sam, to sam
        love.graphics.print(Game:getConfig("lightCurrencyShort"), 46, 136 + offset)
        love.graphics.print(Game.lw_money, 82, 136 + offset)
        
        love.graphics.setFont(self.font)
        if Game.inventory:getItemCount(self.storage, false) <= 0 then
            Draw.setColor(PALETTE["world_gray"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("ITEM", 84, 188 + (36 * 0))
        Draw.setColor(PALETTE["world_text"])
        love.graphics.print("STAT", 84, 188 + (36 * 1))
    
        if not Kristal.getLibConfig("magical-glass", "hide_cell") then
            if Game:getFlag("has_cell_phone") and #Game.world.calls > 0 then
                Draw.setColor(PALETTE["world_text"])
            else
                Draw.setColor(PALETTE["world_gray"])
            end
            love.graphics.print("CELL", 84, 188 + (36 * 2))
        else
            if Game:getFlag("has_cell_phone") then
                if #Game.world.calls > 0 then
                    Draw.setColor(PALETTE["world_text"])
                else
                    Draw.setColor(PALETTE["world_gray"])
                end
                love.graphics.print("CELL", 84, 188 + (36 * 2))
            end
        end
    
        if self.state == "MAIN" then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 56, 160 + (36 * self.current_selecting), 0, 2, 2)
        end
    end)

    Utils.hook(LightStatMenu, "init", function(orig, self)
        orig(self)
        self.party_selecting = 1

        self.style = Kristal.getLibConfig("magical-glass", "light_stat_menu_style")
        self.undertale_stat_display = Kristal.getLibConfig("magical-glass", "undertale_stat_display")
        self.always_show_magic = Kristal.getLibConfig("magical-glass", "always_show_magic")

        self.rightpressed = false
        self.leftpressed = false
    end)

    Utils.hook(LightStatMenu, "update", function(orig, self)
        local chara = Game.party[self.party_selecting]

        local old_selecting = self.party_selecting
    
        if not OVERLAY_OPEN or TextInput.active then
            if Input.pressed("right") then
                self.party_selecting = self.party_selecting + 1
                if self.rightpressed ~= true then
                    self.rightpressed = true
                    Game.stage.timer:after(0.1, function()
                        self.rightpressed = false
                    end)
                end
            end

            if Input.pressed("left") then
                self.party_selecting = self.party_selecting - 1
                if self.leftpressed ~= true then
                    self.leftpressed = true
                    Game.stage.timer:after(0.1, function()
                        self.leftpressed = false
                    end)
                end
            end
        end

        if self.party_selecting > #Game.party then
            self.party_selecting = 1
        end

        if self.party_selecting < 1 then
            self.party_selecting = #Game.party
        end

        if self.party_selecting ~= old_selecting then
            self.ui_move:stop()
            self.ui_move:play()
        end

        if Input.pressed("cancel") and (not OVERLAY_OPEN or TextInput.active) then
            self.ui_move:stop()
            self.ui_move:play()
            Game.world.menu:closeBox()
            return
        end

        LightStatMenu.__super.update(self)

    end)

    Utils.hook(LightStatMenu, "draw", function(orig, self)
        love.graphics.setFont(self.font)
        Draw.setColor(PALETTE["world_text"])
        if self.style == "magical_glass" and #Game.party > 1 then
            local name_offset = 0
            for _,chara in ipairs(Game.party) do
                love.graphics.printf(chara:getName(), (name_offset - 18) + (#chara:getName() - 4) * 7, 8, 100, "center")
                name_offset = name_offset + 110
            end
        else
            love.graphics.print("\"" .. Game.party[self.party_selecting]:getName() .. "\"", 4, 8)
        end

        local chara = Game.party[self.party_selecting]

        if self.style == "deltatraveler" then
            local ox, oy = chara.actor:getPortraitOffset()
            if chara:getLightPortrait() then
                Draw.draw(Assets.getTexture(chara:getLightPortrait()), 180 + ox, 7 + oy, 0, 2, 2)
            end

            if #Game.party > 1 then
                Draw.setColor(Game:getSoulColor())
                Draw.draw(self.heart_sprite, 212, 124, 0, 2, 2)

                Draw.setColor(PALETTE["world_text"])
                love.graphics.print("<                >", 162, 116)
            end
        elseif self.style == "magical_glass" then
            local ox, oy = chara.actor:getPortraitOffset()
            if chara:getLightPortrait() then
                Draw.draw(Assets.getTexture(chara:getLightPortrait()), 180 + ox, 50 + oy, 0, 2, 2)
            end

            if #Game.party > 1 then
                Draw.setColor(Game:getSoulColor())
                Draw.draw(self.heart_sprite, (110 * (self.party_selecting - 1)) + (#chara:getName() * 6) - (self.party_selecting - 1), -8, 0, 2, 2)
            end
        elseif self.style == "undertale" then
            local ox, oy = chara.actor:getPortraitOffset()
            if chara:getLightPortrait() then
                Draw.draw(Assets.getTexture(chara:getLightPortrait()), 180 + ox, 50 + oy, 0, 2, 2)
            end

            if #Game.party > 1 then
                Draw.setColor(Game:getSoulColor())
                Draw.draw(self.heart_sprite, 212, 8 + 4, 0, 2, 2)
                
                --if love.keyboard.isDown("right") then
                if self.rightpressed == true then
                    Draw.setColor({1,1,0})
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_right"), 266 + 4, 8, 0, 2, 2)
                else
                    Draw.setColor(PALETTE["world_text"])
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_right"), 266, 8, 0, 2, 2)
                end

                --if love.keyboard.isDown("left") then
                if self.leftpressed == true then
                    Draw.setColor({1,1,0})
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_left"), 160 - 4, 8, 0, 2, 2)
                else
                    Draw.setColor(PALETTE["world_text"])
                    Draw.draw(Assets.getTexture("kristal/menu_arrow_left"), 160, 8, 0, 2, 2)
                end
                
                --Draw.draw(Assets.getTexture("kristal/menu_arrow_left"), 160, 120, 0, 2, 2)
                --Draw.draw(Assets.getTexture("kristal/menu_arrow_right"), 266, 120, 0, 2, 2)
            end
        end

        Draw.setColor(PALETTE["world_text"])


        local exp_needed = math.max(0, chara:getLightEXPNeeded(chara:getLightLV() + 1) - chara:getLightEXP())
    
        local at = chara:getBaseStats()["attack"]
        local df = chara:getBaseStats()["defense"]
        
        if self.undertale_stat_display then
            at = at - 10
            df = df - 10
        end

        local offset = 0
        local show_magic = false
        for _,party in pairs(Game.party) do
            if party.lw_stats.magic > 0 then
                show_magic = true
            end
        end
        if self.always_show_magic or show_magic then
            offset = 18
            love.graphics.print("MG  ", 4, 228 - offset)
            love.graphics.print(chara:getBaseStats()["magic"]   .. " ("..chara:getEquipmentBonus("magic")   .. ")", 44, 228 - offset)
        end
        love.graphics.print("LV  "..chara:getLightLV(), 4, 68 - offset)
        love.graphics.print("HP  "..chara:getHealth().." / "..chara:getStat("health"), 4, 100 - offset)
        love.graphics.print("AT  "  .. at  .. " ("..chara:getEquipmentBonus("attack")  .. ")", 4, 164 - offset)
        love.graphics.print("DF  "  .. df  .. " ("..chara:getEquipmentBonus("defense") .. ")", 4, 196 - offset)
        love.graphics.print("EXP: " .. chara:getLightEXP(), 172, 164)
        love.graphics.print("NEXT: ".. exp_needed, 172, 196)
    
        local weapon_name = ""
        local armor_name = ""

        if chara:getWeapon() then
            weapon_name = chara:getWeapon():getEquipDisplayName() or chara:getWeapon():getName()
        end

        if chara:getArmor(1) then
            armor_name = chara:getArmor(1):getEquipDisplayName() or chara:getArmor(1):getName()
        end
        
        love.graphics.print("WEAPON: "..weapon_name, 4, 256)
        love.graphics.print("ARMOR: "..armor_name, 4, 288)
    
        love.graphics.print(Game:getConfig("lightCurrency"):upper()..": "..Game.lw_money, 4, 328)
        if MagicalGlassLib.kills > 20 then
            love.graphics.print("KILLS: "..MagicalGlassLib.kills, 172, 328)
        end
    end)

    Utils.hook(World, "registerCall", function(orig, self, name, scene, sound)
        table.insert(self.calls, {name, scene, sound})
    end)

    Utils.hook(World, "spawnPlayer", function(orig, self, ...)
        local args = {...}

        local x, y = 0, 0
        local chara = self.player and self.player.actor
        if #args > 0 then
            if type(args[1]) == "number" then
                x, y = args[1], args[2]
                chara = args[3] or chara
            elseif type(args[1]) == "string" then
                x, y = self.map:getMarker(args[1])
                chara = args[2] or chara
            end
        end

        if type(chara) == "string" then
            chara = Registry.createActor(chara)
        end

        local facing = "down"

        if self.player then
            facing = self.player.facing
            self:removeChild(self.player)
        end
        if self.soul then
            self:removeChild(self.soul)
        end

        if chara.undertale_movement == true then
            self.player = UnderPlayer(chara, x, y)
        else
            self.player = Player(chara, x, y)
        end
        self.player.layer = self.map.object_layer
        self.player:setFacing(facing)
        self:addChild(self.player)

        self.soul = OverworldSoul(self.player:getRelativePos(self.player.actor:getSoulOffset()))
        self.soul:setColor(Game:getSoulColor())
        self.soul.layer = WORLD_LAYERS["soul"]
        self:addChild(self.soul)

        if self.camera.attached_x then
            self.camera:setPosition(self.player.x, self.camera.y)
        end
        if self.camera.attached_y then
            self.camera:setPosition(self.camera.x, self.player.y - (self.player.height * 2)/2)
        end
    end)

    Utils.hook(LightCellMenu, "runCall", function(orig, self, call)
        if call[3] == nil or call[3] then
            Assets.playSound("phone", 0.7)
        end

        Game.world.menu:closeBox()
        Game.world.menu.state = "TEXT"
        Game.world:setCellFlag(call[2], Game.world:getCellFlag(call[2], -1) + 1)
        Game.world:startCutscene(call[2])
    end)

    Utils.hook(Savepoint, "init", function(orig, self, x, y, properties)
        orig(self, x, y, properties)
        self.undertale = properties["ut"] or false
        if self.undertale then
            self:setSprite("world/events/savepointut", 1/6)
        end
    end)

    Utils.hook(Savepoint, "onTextEnd", function(orig, self)
        if not self.world then return end

        if self.heals then
            for _,party in ipairs(Game.party) do
                party:heal(math.huge, false)
            end
        end
        
        if Game:isLight() then
            self.world:openMenu(LightSaveMenu(Game.save_id, self.marker, self.undertale))
        elseif self.simple_menu or (self.simple_menu == nil and Game:getConfig("smallSaveMenu")) then
            self.world:openMenu(SimpleSaveMenu(Game.save_id, self.marker))
        else
            self.world:openMenu(SaveMenu(self.marker))
        end
    end)

    Utils.hook(SaveMenu, "init", function(orig, self, marker)
        orig(self, marker)
        if Game:isLight() then
            self.divider_sprite = Assets.getTexture("ui/box/light/top")
        else
            self.divider_sprite = Assets.getTexture("ui/box/dark/top")
        end
    end)

    Utils.hook(LightSaveMenu, "init", function(orig, self, save_id, marker, undertale)
        orig(self, save_id, marker, undertale)
        self.undertale = undertale
    end)

    Utils.hook(LightSaveMenu, "update", function(orig, self)
        if self.state == "MAIN" and ((Input.pressed("confirm") and self.selected_x == 1) or (Input.pressed("left") or Input.pressed("right"))) then
            Assets.playSound("ui_move")
        end
        orig(self)
    end)

    Utils.hook(LightSaveMenu, "draw", function(orig, self)
        if self.undertale then
            love.graphics.setFont(self.font)

            if self.state == "SAVED" then
                Draw.setColor(PALETTE["world_text_selected"])
            else
                Draw.setColor(PALETTE["world_text"])
            end
        
            local data      = self.saved_file        or {}
            local mg        = data.magical_glass     or {}

            local name      = data.name              or "EMPTY"
            local level     = mg.lw_save_lv          or 0
            local playtime  = data.playtime          or 0
            local room_name = data.room_name         or "--"
        
            love.graphics.print(name,         self.box.x + 8,        self.box.y - 10 + 8)
            love.graphics.print("LV "..level, self.box.x + 210 - 42, self.box.y - 10 + 8)
        
            local minutes = math.floor(playtime / 60)
            local seconds = math.floor(playtime % 60)
            local time_text = string.format("%d:%02d", minutes, seconds)
            love.graphics.printf(time_text, self.box.x - 280 + 148, self.box.y - 10 + 8, 500, "right")
        
            love.graphics.print(room_name, self.box.x + 8, self.box.y + 38)
        
            if self.state == "MAIN" then
                love.graphics.print("Save",   self.box.x + 30  + 8, self.box.y + 98)
                love.graphics.print("Return", self.box.x + 210 + 8, self.box.y + 98)
        
                Draw.setColor(Game:getSoulColor())
                Draw.draw(self.heart_sprite, self.box.x + 10 + (self.selected_x - 1) * 180, self.box.y + 96 + 8, 0, 2, 2)
            elseif self.state == "SAVED" then
                love.graphics.print("File saved.", self.box.x + 30 + 8, self.box.y + 98)
            end
        
            Draw.setColor(1, 1, 1)
        
            LightSaveMenu.__super.draw(self)
        else
            orig(self)
        end
    end)

    Utils.hook(Spell, "onLightStart", function(orig, self, user, target)
        local result = self:onLightCast(user, target)
        Game.battle:battleText(self:getLightCastMessage(user, target))
        if result or result == nil then
            Game.battle:finishActionBy(user)
        end
    end)

    Utils.hook(Spell, "onLightCast", function(orig, self, user, target) end)

    Utils.hook(Spell, "getLightCastMessage", function(orig, self, user, target)
        return "* "..user.chara:getNameOrYou().." cast "..self:getName().."."
    end)
    
    Utils.hook(Spell, "getHealMessage", function(orig, self, user, target, amount) 
        local char_maxed
        local enemy_maxed
        if self.target == "ally" then
            char_maxed = target.chara:getHealth() >= target.chara:getStat("health")
        elseif self.target == "enemy" then
            enemy_maxed = target.health >= target.max_health
        end
        local message = ""
        if self.target == "ally" then
            if target.chara.id == Game.battle.party[1].chara.id and char_maxed then
                message = "* Your HP was maxed out."
            elseif char_maxed then
                message = "* " .. target.chara:getNameOrYou() .. "'s HP was maxed out."
            else
                message = "* " .. target.chara:getNameOrYou() .. " recovered " .. amount .. " HP."
            end
        elseif self.target == "party" then
            if #Game.party > 1 then
                message = "* Everyone recovered " .. amount .. " HP."
            else
                message = "* You recovered " .. amount .. " HP."
            end
        elseif self.target == "enemy" then
            if enemy_maxed then
                message = "* " .. target.name .. "'s HP was maxed out."
            else
                message = "* " .. target.name .. " recovered " .. amount .. " HP."
            end
        elseif self.target == "enemies" then
            message = "* The enemies all recovered " .. amount .. " HP."
        end
        return message
    end)

    Utils.hook(SpeechBubble, "init", function(orig, self, text, x, y, options, speaker)
        orig(self, text, x, y, options, speaker)
        self.text.no_sound_overlap = options["no_sound_overlap"] or true
    end)

    Utils.hook(SpeechBubble, "draw", function(orig, self)
        if not self.auto then
            if self.right and Game.battle.light then
                local width = self:getSpriteSize()
                Draw.draw(self:getSprite(), width - 12, 0, 0, -1, 1)
            else
                Draw.draw(self:getSprite(), 0, 0)
            end
        else
            orig(self)
        end

        SpeechBubble.__super.draw(self)
    end)

    Utils.hook(Game, "gameOver", function(orig, self, x, y)
        orig(self, x, y)
        lib.game_overs = lib.game_overs + 1
    end)
    
    Utils.hook(SnowGraveSpell, "update", function(orig, self)
        if Game.battle.light then
            Object.update(self)
            self.timer = self.timer + DTMULT
            self.since_last_snowflake = self.since_last_snowflake + DTMULT

            if self.hurt_enemies then
                self.hurt_enemies = false
                for i, enemy in ipairs(Game.battle.enemies) do
                    if enemy then
                        enemy.hit_count = 0
                        enemy:hurt(self.damage + Utils.round(math.random(100)), self.caster)
                        if enemy.health <= 0 then
                            enemy.can_die = true
                        end
                    end
                end
            end
        else
            orig(self)
        end
    end)

    PALETTE["pink_spare"] = {1, 167/255, 212/255, 1}

    PALETTE["energy_back"] = {53/255, 181/255, 89/255, 1}
    PALETTE["energy_fill"] = {186/255, 213/255, 60/255, 1}
end

function lib:registerRandomEncounter(id, class)
    self.random_encounters[id] = class
end

function lib:getRandomEncounter(id)
    return self.random_encounters[id]
end

function lib:createRandomEncounter(id, ...)
    if self.random_encounters[id] then
        return self.random_encounters[id](...)
    else
        error("Attempt to create non existent random encounter \"" .. tostring(id) .. "\"")
    end
end

function lib:registerLightEncounter(id, class)
    self.light_encounters[id] = class
end

function lib:getLightEncounter(id)
    return self.light_encounters[id]
end

function lib:createLightEncounter(id, ...)
    if self.light_encounters[id] then
        return self.light_encounters[id](...)
    else
        error("Attempt to create non existent light encounter \"" .. tostring(id) .. "\"")
    end
end

function lib:registerLightEnemy(id, class)
    self.light_enemies[id] = class
end

function lib:getLightEnemy(id)
    return self.light_enemies[id]
end

function lib:createLightEnemy(id, ...)
    if self.light_enemies[id] then
        return self.light_enemies[id](...)
    else
        error("Attempt to create non existent light enemy \"" .. tostring(id) .. "\"")
    end
end

function lib:registerLightShop(id, class)
    self.light_shops[id] = class
end

function lib:getLightShop(id)
    return self.light_shops[id]
end

function lib:createLightShop(id, ...)
    if self.light_shops[id] then
        return self.light_shops[id](...)
    else
        error("Attempt to create non existent light shop \"" .. tostring(id) .. "\"")
    end
end

function lib:registerDebugOptions(debug)

    debug:registerMenu("encounter_select", "Encounter Select")

    debug:registerOption("encounter_select", "Start Dark Encounter", "Start a dark encounter.", function()
        debug:enterMenu("dark_encounter_select", 0)
    end)
    debug:registerOption("encounter_select", "Start Light Encounter", "Start a light encounter.", function()
        debug:enterMenu("light_encounter_select", 0)
    end)

    debug:registerOption("encounter_select", "Start Dark Encounter in Light World", "Start a dark encounter in the light world.", function()
        debug:enterMenu("dark_encounter_select_lw", 0)
    end)
    debug:registerOption("encounter_select", "Start Light Encounter in Dark World", "Start a light encounter in the dark world.", function()
        debug:enterMenu("light_encounter_select_dw", 0)
    end)

    debug:registerMenu("dark_encounter_select", "Select Dark Encounter", "search")
    for id,_ in pairs(Registry.encounters) do
        debug:registerOption("dark_encounter_select", id, "Start this encounter.", function()
            Game:setFlag("current_battle_system#", "deltarune")
            Game:encounter(id)
            debug:closeMenu()
        end)
    end

    debug:registerMenu("dark_encounter_select_lw", "Select Dark Encounter", "search")
    for id,_ in pairs(Registry.encounters) do
        debug:registerOption("dark_encounter_select_lw", id, "Start this encounter.", function()
            Game:setFlag("current_battle_system#", "deltarune")
            if Game:isLight() then
                Game:setFlag("temporary_world_value#", "light")
                MagicalGlassLib:saveStorageAndEquips()
            end
            Game:setLight(true)
            Game:encounter(id)
            debug:closeMenu()
        end)
    end

    debug:registerMenu("light_encounter_select", "Select Light Encounter", "search")
    for id,_ in pairs(self.light_encounters) do
        if id ~= "_nobody" then
            debug:registerOption("light_encounter_select", id, "Start this encounter.", function()
                Game:setFlag("current_battle_system#", "undertale")
                if Kristal.getLibConfig("magical-glass", "force_light_mode_in_light_battles") and not Game:isLight() then
                    Game:setFlag("temporary_world_value#", "dark")
                    MagicalGlassLib:saveStorageAndEquips()
                end
                Game:encounter(id)
                debug:closeMenu()
            end)
        end
    end

    debug:registerMenu("light_encounter_select_dw", "Select Light Encounter", "search")
    for id,_ in pairs(self.light_encounters) do
        if id ~= "_nobody" then
            debug:registerOption("light_encounter_select_dw", id, "Start this encounter.", function()
                Game:setFlag("current_battle_system#", "undertale")
                if not Game:isLight() then
                    Game:setFlag("temporary_world_value#", "dark")
                    MagicalGlassLib:saveStorageAndEquips()
                end
                Game:setLight(false)
                Game:encounter(id)
                debug:closeMenu()
            end)
        end
    end

    debug:registerMenu("wave_select_light", "Wave Select", "search")

    local waves_list = {}
    for id,_ in pairs(Registry.waves) do
        table.insert(waves_list, id)
    end

    table.sort(waves_list, function(a, b)
        return a < b
    end)

    for _,id in ipairs(waves_list) do
        debug:registerOption("wave_select_light", id, "Start this wave.", function()
            Game.battle:setState("ENEMYDIALOGUE", {id})
            debug:closeMenu()
        end)
    end

    debug:registerMenu("select_shop", "Enter Shop")
    
    debug:registerOption("select_shop", "Enter Dark Shop", "Enter a dark shop.", function()
        debug:enterMenu("dark_select_shop", 0)
    end)

    debug:registerOption("select_shop", "Enter Light Shop", "Enter a light shop.", function()
        debug:enterMenu("light_select_shop", 0)
    end)

    debug:registerMenu("light_select_shop", "Enter Light Shop", "search")
    for id,_ in pairs(self.light_shops) do
        debug:registerOption("light_select_shop", id, "Enter this light shop.", function()
            self:enterLightShop(id)
            debug:closeMenu()
        end)
    end

    debug:registerMenu("dark_select_shop", "Enter Shop", "search")
    for id,_ in pairs(Registry.shops) do
        debug:registerOption("dark_select_shop", id, "Enter this shop.", function()
            Game:enterShop(id)
            debug:closeMenu()
        end)
    end

end

function lib:setupLightShop(shop)
    if Game.shop then
        error("Attempt to enter shop while already in shop")
    end

    if type(shop) == "string" then
        shop = MagicalGlassLib:createLightShop(shop)
    end

    if shop == nil then
        error("Attempt to enter shop with nil shop")
    end

    Game.shop = shop
    Game.shop:postInit()
end

function lib:enterLightShop(shop, options)
    -- Add the shop to the stage and enter it.
    if Game.shop then
        Game.shop:leaveImmediate()
    end

    lib:setupLightShop(shop)

    if options then
        Game.shop.leave_options = options
    end

    if Game.world and Game.shop.shop_music then
        Game.world.music:stop()
    end

    Game.state = "SHOP"

    Game.stage:addChild(Game.shop)
    Game.shop:onEnter()
end

function lib:changeSpareColor(color)
    if color == "yellow" then
        lib.name_color = COLORS.yellow
    elseif color == "pink" then
        lib.name_color = PALETTE["pink_spare"]
    elseif color == "white" then
        lib.name_color = COLORS.white
    elseif type(color) == "table" then
        lib.name_color = color
    end
end

function lib:saveStorageAndEquips()
    Game:setFlag("temp_inventory#", Game.inventory:save())
    for _,party in ipairs(Game.party) do
        Game:setFlag("temp_equips_.."..party.id.."#", party:saveEquipment())
    end
end

function lib:loadStorageAndEquips()
    if Game:getFlag("temp_inventory#") then
        Game.inventory:load(Game:getFlag("temp_inventory#"))
        for _,party in ipairs(Game.party) do
            party:loadEquipment(Game:getFlag("temp_equips_.."..party.id.."#"))
            Game:setFlag("temp_equips_.."..party.id.."#", nil)
        end
        Game:setFlag("temp_inventory#", nil)
    end
end

function lib:onFootstep()
    if Game.world and self.encounters_enabled then
        self.steps_until_encounter = self.steps_until_encounter - 1
    end
end

function lib:preUpdate()
    Game.lw_xp = nil
    for _,party in pairs(Game.party_data) do -- Gets the party with the most Light EXP (might be used for shared exp at some point)
        if not Game.lw_xp or party:getLightEXP() > Game.lw_xp then  
            Game.lw_xp = party:getLightEXP()
        end
    end
end

return lib