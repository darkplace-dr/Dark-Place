---@class World
local World, super = Class("World", true)

function World:loadMap(...)
    local args = {...}
    -- x, y, facing
    local map = table.remove(args, 1)
    local marker, x, y, facing
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
    if not Game:getFlag("s", false)
        and love.math.random(1, 1000) == 1
        and (not Game.world.cutscene and not Game.battle)
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
end

function World:setupMap(...)
    super.setupMap(self, ...)

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

return World