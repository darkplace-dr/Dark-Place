local DogCheck, super = Class(Rectangle) -- lmao

function DogCheck:init(variant)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.color = COLORS.black
    self.parallax_x = 0
    self.parallax_y = 0
	self.layer = WORLD_LAYERS["top"]
    self.debug_select = false

    ---@type ""|"IDLE"|"EXITING"
    self.state = ""

    if variant then self.variant = variant end

    self.dog = nil
    self.song = nil
    self.song_pitch = 1

    self.timer = Timer()
    self:addChild(self.timer)

    self.summer_siner = 0
    self.stretch_ex_start = 0
    self.stretch_ex_timer = 0
end

function DogCheck:onAdd(parent)
    if parent:includes(World) then
        self.world = parent
    elseif parent.world then
        self.world = parent.world
    end
    if parent.music then
        self.music = parent.music
    elseif self.world and self.world.music then
        self.music = self.world.music
    elseif Game.music then
        self.music = Game.music
    end

    -- Undertale does this
    self.start_wait_handle = self.timer:after(5/30, function() self:start() end)
end

function DogCheck:start()
    if self.state ~= "" then return end
    self.state = "IDLE"

    local function createDog(sprite, anim_speed, x_off, y_off, scale)
        x_off = x_off or 0
        y_off = y_off or 0
        scale = scale or 4

        self.dog = Sprite(sprite, self.width / 2 + x_off, self.height / 2 + y_off)
        self.dog:setOrigin(0.5, 0.5)
        if scale == "fitscreen" then
            scale = math.min(self.width / self.dog.width, self.height / self.dog.height)
            scale = math.floor(scale * 100) / 100
        end
        self.dog:setScale(scale)
        self.dog:play(anim_speed, true)
        self:addChild(self.dog)
    end

    local function playSong(path, pitch_rand_min, pitch_rand_max)
        pitch_rand_min = pitch_rand_min or 1
        pitch_rand_max = pitch_rand_max or pitch_rand_min

        self.song = path
        self.song_pitch = Utils.random(pitch_rand_min, pitch_rand_max)
        if self.music then
            self.music:play(path, nil, self.song_pitch)
        end
    end

    if not self.variant then
        local month = os.date("*t").month
        local variant_choices = {"dance", "sleep", "maracas", "piano", "banned", "banned2", "chapter2"}
        if month >= 3 and month <= 5 then
            table.insert(variant_choices, "spring")
        elseif month >= 6 and month <= 8 then
            table.insert(variant_choices, "summer")
        elseif month >= 9 and month <= 11 then
            table.insert(variant_choices, "autumn")
        elseif month == 12 and month <= 2 then
            table.insert(variant_choices, "winter")
        end
        self.variant = Utils.pick(variant_choices)
    end

    local cust_sprites_base = "world/cutscenes/dogcheck"

    if self.variant == "dance" then
        createDog(cust_sprites_base.."/dog_dance", 0.2)
        playSong("dance_of_dog", 0.95, 1.05)
    elseif self.variant == "sleep" then
        createDog("misc/dog_sleep", 0.8)
        local song_here = Utils.pick({"dogcheck", "results", "sigh_of_dog", "dogcheck_anniversary"})
        local song_is_sog = song_here == "sigh_of_dog" or song_here == "dogcheck"

        if song_here == "dogcheck" then
            playSong(song_here, song_is_sog and 0.9 or 1, 1)
		else
            playSong(song_here, song_is_sog and 0.8 or 1, 1)
        end
    elseif self.variant == "maracas" then
        createDog(cust_sprites_base.."/dog_maracas", 0.1, 20, -20)
        playSong("baci_perugina2")
    elseif self.variant == "piano" then
        createDog(cust_sprites_base.."/dog_piano", 0.5)
        local song_here = Utils.pick({"legend_piano", "snowdin_piano", "home_piano", "5_4_improv", "bowser_piano_victory"})
        playSong(song_here)
    elseif self.variant == "spring" then
        createDog(cust_sprites_base.."/dog_spring", 0.2, -2, -13)
        playSong("options_fall")
    elseif self.variant == "summer" then
        createDog(cust_sprites_base.."/dog_summer", 0.8, 0, 24)
        self.dog:setOrigin(0.5, 1)
        playSong("options_summer")
    elseif self.variant == "autumn" then
        createDog(cust_sprites_base.."/dog_autumn", 0.8, -2, -10)
        playSong("options_fall")
    elseif self.variant == "winter" then
        createDog(cust_sprites_base.."/dog_winter", 0.8, -2, -14)
        playSong("options_winter")
    elseif self.variant == "banned" then
        createDog(cust_sprites_base.."/banned", 1, 0, 0, 2)
        playSong("AUDIO_DEFEAT", 1.5)
    elseif self.variant == "banned2" then
        local window_scale_orig = Kristal.Config["windowScale"]
        if window_scale_orig < 2 then
            Mod.dogcheck_banned2_window_hacks = true
            Kristal.Config["windowScale"] = 2
        end
        if Kristal.Config["borders"] ~= "off" then
            Mod.dogcheck_banned2_window_hacks = true
            Mod.dogcheck_banned2_orig_banner = Kristal.Config["borders"]
            Kristal.Config["borders"] = "off"
        end
        if Mod.dogcheck_banned2_window_hacks then
            Kristal.resetWindow()
            Kristal.Config["windowScale"] = window_scale_orig
        end

        createDog(cust_sprites_base.."/banned_b", 1, 0, 0, "fitscreen")
        if self.music then
            self.timer:after(1.25, function()
                self.music:play("mutation", 0)
                self.music:fade(0.85, 1.5)
            end)
        end
    elseif self.variant == "chapter2" then
        createDog("misc/dog_sleep", 0.8, -960, -580)
        playSong("alarm_titlescreen", 1, 1)
        self.timer:script(function(...) self:chapter2Script(...) end)
    end
end

function DogCheck:update()
    super.update(self)

    -- Make sure we *do* have the menu turned off (zero WIP)
    Game.lock_movement = true

    if self.state == "" then return end

    if self.state == "IDLE" and not self.world:hasCutscene() --[[for zero WIP]] and not OVERLAY_OPEN
        and Input.pressed("confirm")
    then
        self.state = "EXITING"
        Game.fader:fadeOut(nil, { speed = 0.5 })
        if self.music then self.music:fade(0, 20/30) end
        self.timer:after(1, function ()
            self:remove()
            Game:returnToMenu()
        end)
    end

    if self.variant == "summer" then
        self.stretch_ex_start = self.stretch_ex_start + DTMULT
        if self.stretch_ex_start >= 240 then
            self.stretch_ex_timer = self.stretch_ex_timer + DTMULT
            if self.stretch_ex_timer >= 1100 and math.abs(math.sin(self.summer_siner / 15)) < 0.1 then
                self.stretch_ex_timer = 0
                self.stretch_ex_start = 0
            end
        end
        self.summer_siner = self.summer_siner + DTMULT
        local extra_stretch = math.sin(self.summer_siner / 15) * (0.2 + (self.stretch_ex_timer / 900))
        self.dog:setScale(4 + 1 + extra_stretch, 4 + 1 - extra_stretch)
    end
end

function DogCheck:getDebugInfo()
    if self.state == "" then
        return { string.format("Starting in: %gs", self.start_wait_handle.limit - self.start_wait_handle.time) }
    end

    return {
        "State: " .. self.state,
        "Variant: " .. self.variant,
        string.format("Song: %s (%gx)", self.song, self.song_pitch)
    }
end

function DogCheck:draw()
    super.draw(self)

    if self.variant == "summer" then
        Draw.setColor(1, 1, 0)
        love.graphics.circle("fill",
            420 + math.cos(self.summer_siner / 18) * 6, 40 + math.sin(self.summer_siner / 18) * 6,
            28 + math.sin(self.summer_siner / 6) * 4, 100
        )
    end
end

function DogCheck:chapter2Script(wait)
    local sprite = "world/cutscenes/dogcheck/dog_car"

    local dog = Sprite(sprite, -40, 240)
    dog:setScale(2)
    dog.layer = 1
    self:addChild(dog)

    local function animateMainDog(speed, dont_reset)
        if not dont_reset then
            if speed > 0 then
                dog.x = -40
            else
                dog.x = SCREEN_WIDTH
            end
        end
        dog.flip_x = speed > 0
        dog.physics.speed = speed
        if not dont_reset then
            dog:play(0.25, true)
        end
    end
    local function makeSmallDogHorde(axis, num)
        for _ = 1, num do
            local small_dog = Sprite(sprite, 0, 240 + love.math.random(-80, 80))
            if axis > 0 then
                small_dog.x = -40
            else
                small_dog.x = SCREEN_WIDTH
            end
            small_dog.flip_x = axis > 0
            small_dog.physics.speed = axis * love.math.random(10, 16)
            small_dog.physics.friction = Utils.random(0.01, -0.01)
            local anim_speed = (1 + (small_dog.physics.speed / 4)) * 0.25
            small_dog:play(anim_speed, true)
            -- auto-cleanup
            ---@diagnostic disable-next-line: redefined-local
            Utils.hook(small_dog, "update", function(orig, self, ...)
                orig(self, ...)
                local max_dist = 3*TILE_WIDTH
                if self.x < -max_dist or self.x > SCREEN_WIDTH + max_dist then
                    self:remove()
                end
            end)
            self:addChild(small_dog)
        end
    end

    while true do
        for _ = 1, 2 do
            if dog.x < 0 then animateMainDog(10) end
            wait(2.75)
            animateMainDog(-10)
            wait(3)
        end

        makeSmallDogHorde(1, love.math.random(4, 8))
        animateMainDog(12)
        wait(2.5)
        makeSmallDogHorde(-1, love.math.random(5, 12))
        animateMainDog(-12)
        wait(2.5)

        animateMainDog(8)
        wait(1.03)
    end
end

function DogCheck:onRemove()
    if Mod.dogcheck_banned2_window_hacks then
        Mod.dogcheck_banned2_window_hacks = false
        Kristal.Config["borders"] = Mod.dogcheck_banned2_orig_banner
        Kristal.resetWindow()
    end
end

return DogCheck