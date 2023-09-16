local DogCheck, super = Class(Rectangle) -- lmao

function DogCheck:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.color = {0, 0, 0}
    self.parallax_x = 0
    self.parallax_y = 0
	self.layer = WORLD_LAYERS["top"]

    self.started = false
    self.dog = nil
    self.song = nil
    self.song_pitch = 1

    self.timer = Timer()
    self:addChild(self.timer)
    -- Undertale does this
    self.start_wait_handle = self.timer:after(5/30, function() self:start() end)

	self.month = tonumber(os.date("%m"))
    self.day = tonumber(os.date("%d"))
end

function DogCheck:start()
    if self.started then return end
    self.started = true

    local function createDog(sprite, anim_speed, x_off, y_off)
        x_off = x_off or 0
        y_off = y_off or 0

        self.dog = Sprite(sprite, self.width / 2 + x_off, self.height / 2 + y_off)
        self.dog:setOrigin(0.5, 0.5)
        self.dog:setScale(4)
        self.dog:play(anim_speed, true)
        self:addChild(self.dog)
    end

    local function playSong(path, pitch_rand_min, pitch_rand_max)
        pitch_rand_min = pitch_rand_min or 1
        pitch_rand_max = pitch_rand_max or 1

        self.song = path
        self.song_pitch = Utils.random(pitch_rand_min, pitch_rand_max)
        Game.world.music:play(path, 0.8, self.song_pitch)
    end

    local variant_choices = {"dance", "sleep", "maracas"}
    if self.month >= 3 and self.month <= 5 then
        table.insert(variant_choices, "spring")
    elseif self.month >= 6 and self.month <= 8 then
        table.insert(variant_choices, "summer")
    elseif self.month >= 9 and self.month <= 11 then
        table.insert(variant_choices, "autumn")
    elseif self.month >= 12 and self.month < 3 then
        table.insert(variant_choices, "winter")
    end
    self.variant = Utils.pick(variant_choices)

    local cust_sprites_base = "world/cutscenes/dogcheck"

    if self.variant == "dance" then
        createDog(cust_sprites_base.."/dog_dance", 0.2)
        playSong("dance_of_dog", 0.95, 1.05)
    elseif self.variant == "sleep" then
        createDog("misc/dog_sleep", 0.8)
        local song_here = Utils.pick({"deltarune/dogcheck", "results", "sigh_of_dog", "dogcheck_anniversary"})
        local song_is_sog = song_here == "sigh_of_dog"
        playSong(song_here, song_is_sog and 0.8 or 1, 1)
    elseif self.variant == "maracas" then
        createDog(cust_sprites_base.."/dog_maracas", 0.1, 20, -20)
        playSong("baci_perugina2")
    elseif self.variant == "spring" then
        createDog(cust_sprites_base.."/dog_spring", 0.2, -2, -13)
        playSong("options_fall")
    elseif self.variant == "summer" then
        createDog(cust_sprites_base.."/dog_summer", 0.8)
        playSong("options_summer")
    elseif self.variant == "autumn" then
        createDog(cust_sprites_base.."/dog_autumn", 0.8, -2, -10)
        playSong("options_fall")
    elseif self.variant == "winter" then
        createDog(cust_sprites_base.."/dog_winter", 0.8, -2, -14)
        playSong("options_winter")
    end
end

function DogCheck:getDebugInfo()
    if not self.started then
        return { string.format("Starting in: %gs", self.start_wait_handle.limit - self.start_wait_handle.time) }
    end
    return {
        "Variant: " .. self.variant,
        string.format("Song: %s (%gx)", self.song, self.song_pitch)
    }
end

return DogCheck