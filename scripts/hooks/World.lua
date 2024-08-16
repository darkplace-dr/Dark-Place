---@class World
local World, super = Class("World", true)

function World:loadMap(...)
    local args = {...}
    -- x, y, facing, callback
    local map = table.remove(args, 1)
    local marker, x, y, facing, callback
    if type(args[1]) == "string" then
        marker = table.remove(args, 1)
    elseif type(args[1]) == "number" then
        x = table.remove(args, 1)
        y = table.remove(args, 1)
    else
        marker = "spawn"
    end
    if args[1] then
        facing = table.remove(args, 1)
    end
    if args[1] then
        callback = table.remove(args, 1)
    end

    -- Recreation of the famous Punch Card glitch
    if Mod.punch_speedrun then
    	Mod.punch_speedrun = false
    	Game.lock_movement = false
    	if Mod.glitch_timer then
    		self.timer:cancel(Mod.glitch_timer)
    	end
    	self:stopCutscene()
    	marker = "spawn"
    end

    Mod.world_dest_map_bak = nil
    Mod.world_dest_mk_bak = nil
    Mod.world_dest_fc_bak = nil

    local contain_but_weirder = false
    for i,room in ipairs(Mod.MB_room_blacklist) do
        if Utils.startsWith(map, room) then
            contain_but_weirder = true
            break
        end
    end
    if not Game:getFlag("s", false)
        and love.math.random(1, 1000) == 1
        and (not Game.world.cutscene and not Game.battle)
        and not (contain_but_weirder or Utils.containsValue(Mod.MB_room_blacklist, map))
    then
        Mod.world_dest_map_bak = map
        Mod.world_dest_mk_bak = marker or {x, y}
        Mod.world_dest_fc_bak = facing
        map = "​"
        marker = "spawn"
        x, y = nil, nil
        facing = nil
    end

    if self.map then
        self.map:onExit()
    end

    self:setupMap(map, unpack(args))

    if self.map.markers["spawn"] then
        local spawn = self.map.markers["spawn"]
        self.camera:setPosition(spawn.center_x, spawn.center_y)
    end

    if marker then
        self:spawnParty(marker, nil, nil, facing)
    else
        self:spawnParty({x, y}, nil, nil, facing)
    end

    self:setState("GAMEPLAY")

    for _,event in ipairs(self.map.events) do
        if event.postLoad then
            event:postLoad()
        end
    end

    self.map:onEnter()
	
    if callback then
        callback(self.map)
    end
end

--[[
function World:setupMap(...)
    super.setupMap(self, ...)

    Mod:setOmori(self.map.omori)
end
--]]

function World:setupMap(map, ...)
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
        self.map = Registry.createMap(map, self, ...)
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
        Game:setBorder(Kristal.callEvent("onMapBorder", self.map, map_border) or map_border)
    end

    if not self.map.keep_music then
        self:transitionMusic(Kristal.callEvent("onMapMusic", self.map, self.map.music) or self.map.music)
    end

    Mod:setOmori(self.map.omori)
end

function World:spawnPlayer(...)
    super.spawnPlayer(self, ...)
	
	if (BadgesLib:getBadgeEquipped("l_emblem") > 0) then
		if (BadgesLib:getBadgeEquipped("w_emblem") > 0) then
			self.player.emblem = ColorMaskFX({0.5,0,0.5}, 0.5)
			self.player:addFX(self.player.emblem, "emblem")
		else
			self.player.emblem = ColorMaskFX({0,1,0}, 0.5)
			self.player:addFX(self.player.emblem, "emblem")
		end
	elseif (BadgesLib:getBadgeEquipped("w_emblem") > 0) then
		self.player.emblem = ColorMaskFX({1,1,0}, 0.5)
		self.player:addFX(self.player.emblem, "emblem")
	end
end

function World:transitionMusic(next, fade_out)
    -- Compatibility with older versions of transitionMusic which have "next" as the music
    local music = ""
    local volume = 1
    local pitch = 1
    if type(next) == "table" then
        music = next[1]
        volume = next[2]
        pitch = next[3]
    else
        music = next
    end
    --
    if music and music ~= "" then
        if self.music.current ~= music then
            if self.music:isPlaying() and fade_out then
                self.music:fade(0, 10/30, function() self.music:stop() end)
            elseif not fade_out then
                self.music:play(music, volume, pitch)
            end
        else
            if not self.music:isPlaying() then
                if not fade_out then
                    self.music:play(music, volume, pitch)
                end
            else
                self.music:fade(volume)
                self.music:setPitch(pitch)
            end
        end
    else
        if self.music:isPlaying() then
            if fade_out then
                self.music:fade(0, 10/30, function() self.music:stop() end)
            else
                self.music:stop()
            end
        end
    end
end

function World:mapTransition(...)
    local args = {...}
    local map = args[1]
    if type(map) == "string" then
        local map = Registry.createMap(map)
        if not map.keep_music then
            self:transitionMusic(Kristal.callEvent("onMapMusic", self.map, self.map.music) or map.music, true)
        end
        local dark_transition = map.light ~= Game:isLight()
        local map_border = map:getBorder(dark_transition)
        if map_border then
            Game:setBorder(Kristal.callEvent("onMapBorder", self.map, map_border) or map_border, 1)
        end
    end
    self:fadeInto(function()
        self:loadMap(Utils.unpack(args))
    end)
end

function World:onKeyPressed(key)
    if Kristal.Config["debug"] and Input.ctrl() then
        if key == "m" then
            if self.music then
                if self.music:isPlaying() then
                    self.music:pause()
                else
                    self.music:resume()
                end
            end
        end
        if key == "s" then
            local save_pos = nil
            if Input.shift() then
                save_pos = {self.player.x, self.player.y}
            end
            if Game:isLight() or Game:getConfig("smallSaveMenu") then
                self:openMenu(SimpleSaveMenu(Game.save_id, save_pos))
            else
                self:openMenu(SaveMenu(save_pos))
            end
        end
        if key == "n" then
            NOCLIP = not NOCLIP
        end
    end

    if Game.lock_movement then return end

    if self.state == "GAMEPLAY" then
        if Input.isConfirm(key) and self.player and not self:hasCutscene() then
            if self.player:interact() then
                Input.clear("confirm")
            end
        elseif Input.isMenu(key) and not self:hasCutscene() and not self.disable_dark_menu then
            self:openMenu(nil, WORLD_LAYERS["ui"] + 1)
            Input.clear("menu")
        end
    elseif self.state == "MENU" then
        if self.menu and self.menu.onKeyPressed then
            self.menu:onKeyPressed(key)
        end
    end
end

return World