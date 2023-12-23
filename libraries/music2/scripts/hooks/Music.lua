---@class Music
---@overload fun(...) : Music
-- Some stuff that can play uhh music, I guess \
-- Now with horrifying hacks to allow intro and loop segments
---@field source_intro love.Source
local Music = Class()

---@type Music[]
local _instances = {}

-- Initalizes a Music2 instance.
---@param music? string plays with the specified volume and pitch if specified
---@param volume? number defaults to 1
---@param pitch? number defaults to 1
---@param loop? boolean controls if the music that will be played loops
function Music:init(music, volume, pitch, loop)
    self.removed = false

    self.current = nil
    self.source = nil
    self.source_intro = nil

    self.volume = 1
    self.pitch = 1
    -- please don't use false unless you absolutely need to (tip: music is streamed)
    self.loop = true

    self.intro_played = false
    self.temporary_halt = false

    self.target_volume = 0
    self.fade_speed = 0
    self.fade_callback = nil

    if music then
        self.volume = volume or 1
        self.pitch = pitch or 1
        self:play(music, volume, pitch, loop)
    end

    self.intro_last_pos = -1
    self.intro_dt = 0
end

-- Fades the music's volume to `to` at `speed`, calling `callback` when it finishes.
function Music:fade(to, speed, callback)
    self.target_volume = to or 0
    self.fade_speed = speed or (10/30)
    self.fade_callback = callback
end

function Music:getVolume()
    return self.volume * MUSIC_VOLUME * (self.current and MUSIC_VOLUMES[self.current] or 1)
end

function Music:getPitch()
    return self.pitch * (self.current and MUSIC_PITCHES[self.current] or 1)
end

function Music:getActiveSource()
    return (not self.intro_played and self.source_intro) or self.source
end

---@return string[]|nil
local function getMusicPaths(name)
    local result = {Assets.getMusicPath(name)}
    if not result[1] then return nil end

    -- thcrap notation
    result[2] = Assets.getMusicPath(name..".loop")

    return result
end

function Music:play(music, volume, pitch, loop)
    if not music then
        self:playFile(nil, volume, pitch, true)
        return
    end

    local path = getMusicPaths(music)
    if not path then
        return
    end
    self:playFile(path, volume, pitch, loop, music)
end

---@param paths? table|string
---@param volume? number
---@param pitch? number
---@param loop? boolean
---@param name? string
function Music:playFile(paths, volume, pitch, loop, name)
    loop = loop == nil and true or loop

    if self.removed then
        return
    end

    self:stop(false, true)

    if paths then
        local first_seg, loop_seg
        if type(paths) == "table" then
            first_seg, loop_seg = unpack(paths)
        else
            first_seg = paths
        end
        name = name or first_seg

        if self.current ~= name or not self:isPlaying() then
            self:stop(true)

            self.current = name

            local source_1st = love.audio.newSource(first_seg, "stream")
            if loop_seg then
                source_1st:setLooping(false)
                self.source_intro = source_1st

                local source = love.audio.newSource(loop_seg, "stream")
                source:setLooping(loop)
                self.source = source
            else
                source_1st:setLooping(loop)
                self.source = source_1st
            end

            if volume then
                self:setVolume(volume)
            end
            self:setPitch(pitch or 1)
            self:getActiveSource():play()
        end
    else
        if volume then
            self:setVolume(volume)
        end
        if pitch then
            self:setPitch(pitch)
        end

        local pb_source = self.source_intro or self.source
        if pb_source then
            pb_source:play()
        end
    end
end

function Music:setVolume(volume)
    self.volume = volume

    if self.source_intro then
        self.source_intro:setVolume(self:getVolume())
    end
    if self.source then
        self.source:setVolume(self:getVolume())
    end
end

function Music:setPitch(pitch)
    self.pitch = pitch

    if self.source_intro then
        self.source_intro:setPitch(self:getPitch())
    end
    if self.source then
        self.source:setPitch(self:getPitch())
    end
end

function Music:seek(time)
    local source = self:getActiveSource()
    if source then
        if self.source_intro and source == self.source then
            time = -self.source_intro:getDuration() + time
        end
        source:seek(time)
    end
end

function Music:tell()
    local source = self:getActiveSource()
    if source then
        local ret = source:tell()
        if self.source_intro and source == self.source then
            ret = self.source_intro:getDuration() + ret
        end
        return ret
    end
end

function Music:statusReset()
    self.fade_speed = 0
    self.intro_played = false
    self.temporary_halt = false
    self.intro_last_pos = 0
end

function Music:stop(full, starting_another)
    self:statusReset()
    self.temporary_halt = not (full or starting_another)

    if self.source_intro then
        self.source_intro:stop()
    end
    if self.source then
        self.source:stop()
    end
    if full then
        self.source_intro = nil
        self.source = nil
    end
end

function Music:pause()
    self.temporary_halt = true

    local source = self:getActiveSource()
    if source then
        source:pause()
    end
end

function Music:resume()
    self.temporary_halt = false

    local source = self:getActiveSource()
    if source then
        source:play()
    end
end

function Music:isPlaying()
    return (
        (self.source_intro and self.source_intro:isPlaying())
        or (self.source and self.source:isPlaying())
    ) or false
end

function Music:canResume()
    return not self:isPlaying() and (self.source_intro ~= nil or self.source ~= nil)
end

function Music:remove()
    self:stop(true)

    Utils.removeFromTable(_instances, self)
    self.removed = true
end

function Music:_update()
    if self.fade_speed ~= 0 and self.volume ~= self.target_volume then
        self.volume = Utils.approach(self.volume, self.target_volume, DT / self.fade_speed)

        if self.volume == self.target_volume then
            self.fade_speed = 0

            if self.fade_callback then
                self:fade_callback()
            end
        end
    end

    if self.source_intro
        and (not self.intro_played) then
        if self.source_intro:isPlaying() then
            self.intro_dt = self.source_intro:tell() - self.intro_last_pos
            self.intro_last_pos = self.source_intro:tell()
        end
        local function introIsPlaying()
            local dur = self.source_intro:getDuration()
            if dur > 0 then
                return self.source_intro:isPlaying()
                    and self.source_intro:tell() <= (dur - self.intro_dt)
            end
            return self.source_intro:isPlaying()
        end
        if (not introIsPlaying() and not self.temporary_halt) then
            self.intro_played = true
            self.source:play()
        end
    end

    local source = self:getActiveSource()
    if source then
        local volume = self:getVolume()
        if source:getVolume() ~= volume then
            source:setVolume(volume)
        end
        local pitch = self:getPitch()
        if source:getPitch() ~= pitch then
            source:setPitch(pitch)
        end
    end
end

-- Static Functions

local function getAll()
    return _instances
end

local function getPlaying()
    return Utils.filter(_instances, function(x)
        return x:isPlaying()
    end)
end

local function stop()
    for _,inst in ipairs(_instances) do
        inst:stop()
    end
end

local function clear()
    for _,inst in ipairs(_instances) do
        inst:remove()
    end
    _instances = {}
end

local function update()
    for _,inst in ipairs(_instances) do
        inst:_update()
    end
end

local function new(...)
    local inst = Music(...)
    table.insert(_instances, inst)

    return inst
end

local module = {
    new = new,
    update = update,
    clear = clear,
    stop = stop,
    getAll = getAll,
    getPlaying = getPlaying,
    lib = Music,
}

return setmetatable(module, {__call = function(t, ...) return new(...) end})