local preview = {}

function preview:init(mod, button, menu)
    ---@type MainMenu
    self.menu = menu or MainMenu
    button:setColor(1, 1, 1)
    button:setFavoritedColor(138/255, 138/255, 207/255)

    self.mod_id = mod.id
    self.base_path = mod.path.."/preview"
    local function p(f) return self.base_path .. "/" .. f end

    self.particles = {}
    self.particle_interval = 0
    self.particle_tex = love.graphics.newImage(p("star.png"))
    self.particle_interval_dess = Utils.random(1*2.2, 6.9*4*20*3, 0.25)
    self.particle_tex_dess = love.graphics.newImage(p("dess.png"))

    local date = os.date("*t")
    if date.month == 4 and date.day == 1 then
        self.april_fools = true
        local function p_a(f) return self.base_path .. "/april_1/" .. f end

        self.particle_tex = love.graphics.newImage(p_a("star.png"))
        mod.preview_music_path = p_a("preview.ogg")
    end

    if date.month == 4 and date.day == 20 then
        self.particle_tex = love.graphics.newImage(p("doobie.png"))
    end

    self.bg_gradient_siner = 0

    self.naming_swellow = nil
    self.naming_swellow_timer = 0

    self.naming_sound = nil

    self.naming_video = nil
    self.naming_video_fade_phase = -1
    self.naming_video_fade_timer = 0

    self.splash_list = self:require("splashes")
    self.splash = Utils.pick(self.splash_list)

    self.splash_timer = 0
end

function preview:update()
    self.bg_gradient_siner = self.bg_gradient_siner + 0.2 * DTMULT

    local particle_to_remove = {}
    for _,particle in ipairs(self.particles) do
        particle.radius = Utils.approach(particle.radius, 0, DT)
        particle.y = particle.y - particle.speed * DTMULT

        if particle.radius <= 0 then
            table.insert(particle_to_remove, particle)
        end
    end
    for _,particle in ipairs(particle_to_remove) do
        Utils.removeFromTable(self.particles, particle)
    end

    self.particle_interval = self.particle_interval + DT
    if self.particle_interval >= 0.4 then
        self.particle_interval = 0
        local radius = Utils.random(2, 12)
        table.insert(self.particles, {
            type = "star",
            radius = radius, max_radius = radius,
            x = Utils.random(SCREEN_WIDTH), y = SCREEN_HEIGHT + radius,
            speed = 2 * Utils.random(0.5, 1)
        })
    end

    self.particle_interval_dess = Utils.approach(self.particle_interval_dess, 0, DT)
    if self.particle_interval_dess <= 0 then
        self.particle_interval_dess = Utils.random(1*2.2, 6.9*4*20*3, 0.25)
        table.insert(self.particles, {
            type = "dess",
            radius = 12, max_radius = 12,
            x = Utils.random(SCREEN_WIDTH), y = SCREEN_HEIGHT + 12,
            speed = 6 * Utils.random(0.5, 1)
        })
    end

    if self:isNameChosen("SWELLOW", true) then
        if not self.naming_swellow then
            self.naming_swellow = love.graphics.newImage(self.base_path.."/swellow.png")
        end
        self.naming_swellow_timer = self.naming_swellow_timer + DT
    else
        self.naming_swellow_timer = 0
    end

    local function setSound(file, type)
        if not self.naming_sound then
            self.naming_sound = love.audio.newSource(self.base_path.."/"..file, type or "stream")
            self.naming_sound:play()
        end
    end
    if self:isNameChosen("PAUL", false) then
        setSound("paul.ogg")
    elseif self:isNameChosen("YOU", false) then
        setSound("croakreverb.ogg", "static")
    elseif self.naming_sound then
        self.naming_sound:stop()
        self.naming_sound = nil
    end

    local function setVideo(file)
        if not self.naming_video then
            self.naming_video = love.graphics.newVideo(self.base_path.."/"..file..".ogv", {audio = true})
            self.naming_video:setFilter("linear", "linear")
            self.naming_video:play()
            self.naming_video_fade_phase = 0
        end
    end
    if self:isNameChosen("RICK", false) then
        setVideo(love.math.random(50) <= 12 and "the_new_rick_rolld" or "rickroll")
    elseif self:isNameChosen("ASRIEL", false) then
        setVideo("piles")
    elseif self:isNameChosen("DECEMBER", false) then
        setVideo("december")
    elseif self.naming_video then
        self.naming_video_fade_phase = 1
    end
    local mod_music_table = self.menu.mod_list and self.menu.mod_list.music
    if not mod_music_table then mod_music_table = self.menu.mod_music end
    if self.naming_video then
        if self.naming_video_fade_phase == 0 then
            self.naming_video_fade_timer = Utils.approach(self.naming_video_fade_timer, 1, 0.02*DTMULT)
        else
            self.naming_video_fade_timer = Utils.approach(self.naming_video_fade_timer, 0, 0.06*DTMULT)
            if self.naming_video_fade_timer == 0 then
                self.naming_video:pause()
                self.naming_video = nil
                mod_music_table[self.mod_id]:setVolume(1)
            end
        end
    end
    if self.naming_video then
        self.naming_video:getSource():setVolume(math.min(self.naming_video_fade_timer/0.2, 1) * 0.6)
        mod_music_table[self.mod_id]:setVolume(1 - (self.naming_video_fade_timer * 1))
        -- loop video
        if not self.naming_video:isPlaying() then
            self.naming_video:rewind()
            self.naming_video:play()
        end
    else
        self.naming_video_fade_phase = -1
        self.naming_video_fade_timer = 0
    end

    self.splash_timer = self.splash_timer + DT
end

function preview:draw()
    if self.fade <= 0 then return end

    if self.april_fools then
        love.graphics.setColor(1, 1, 1, self.fade)
    else
        love.graphics.setColor(0, 0, 0, self.fade)
    end
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    -- gradient background ported over from Asgore's fight in UT
    local gradient_weave = 1.5 + math.sin(self.bg_gradient_siner / 20)
    for i = 0, 10 do
        local gradient_alpha = 0.8 - i / 16
        if self.april_fools then
            love.graphics.setColor(186/255, 186/255, 97/255, gradient_alpha * self.fade)
        else
            love.graphics.setColor(69/255, 69/255, 158/255, gradient_alpha * self.fade)
        end
        love.graphics.rectangle("fill",
            0, SCREEN_HEIGHT - math.pow(i, 2) * gradient_weave,
            SCREEN_WIDTH, SCREEN_HEIGHT - math.pow(i + 1, 2) * gradient_weave
        )
    end

    love.graphics.setColor(1, 1, 1, self.fade)

    if self.naming_video then
        local vid_alpha = Utils.approach(0, 0.5, self.naming_video_fade_timer)

        love.graphics.setColor(0, 0, 0, vid_alpha * 0.8 * self.fade)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1, vid_alpha * self.fade)
        local vid_w, vid_h = self.naming_video:getWidth(), self.naming_video:getHeight()
        local vid_scale = math.min(SCREEN_WIDTH/vid_w, SCREEN_HEIGHT/vid_h)
        love.graphics.draw(self.naming_video, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, vid_scale, vid_scale, vid_w/2, vid_h/2)
	end

    for _,particle in ipairs(self.particles) do
        love.graphics.setColor(1, 1, 1, particle.radius / particle.max_radius * self.fade)
        local particle_tex = self.particle_tex
        local particle_ox, particle_oy = 0, 0
        if particle.type == "dess" then
            particle_tex = self.particle_tex_dess
            particle_ox, particle_oy = particle_tex:getWidth()/2, particle_tex:getHeight()/2
        end
        love.graphics.draw(particle_tex, particle.x, particle.y, particle.radius, 1, 1, particle_ox, particle_oy)
    end

    if self:isNameChosen("SWELLOW", true) and self.naming_swellow then
        local alpha = math.min((self.naming_swellow_timer - 1.8) * 0.2 + self:getNamer().whiten, 0.8)
        local xs_inc = math.max(0, (self.naming_swellow_timer - 3) * 0.02 + self:getNamer().whiten)
        love.graphics.setColor(1, 1, 1, alpha * self.fade)
        love.graphics.draw(self.naming_swellow,
            SCREEN_WIDTH/2, SCREEN_HEIGHT/2-30, 0,
            2 + xs_inc, 2,
            self.naming_swellow:getWidth()/2, self.naming_swellow:getHeight()/2
        )
    end
end

function preview:drawOverlay()
    if (TARGET_MOD == self.mod_id and self.menu.state == "TITLE")
        or (self:areWeSelected() and self.menu.state == "FILESELECT") then
        self:drawSplashText()
    end

    if self:areWeSelected() and DEBUG_RENDER then
        love.graphics.setColor(Utils.hexToRgb("#0AC1FF"), 1)
        local font = Assets.getFont("main")
        love.graphics.setFont(font)
        local namer = self:getNamer()
        local dbg = string.format(
[[fade=%.2f sel=%s%s

bright=%s
gra_s=%.2f sp_t=%.2f
p_int=%.2f dess=%.2f

namer : %s name=%s
swellow=%s(t=%.2f nam_f=%.2f)
sound=%s
video=%s(p=%d f=%.2f)]],
            self.fade, self.menu.selected_mod and self.menu.selected_mod.id, TARGET_MOD and string.format("(%s)", TARGET_MOD) or "",
            self.april_fools and "y" or "n",
            self.bg_gradient_siner, self.splash_timer,
            self.particle_interval, self.particle_interval_dess,
            namer and namer.state or "", namer and string.upper(namer.name) or "",
            self.naming_swellow and "y" or "n", self.naming_swellow_timer, namer and namer.whiten or 0,
            self.naming_sound and "y" or "n",
            self.naming_video and "y" or "n", self.naming_video_fade_phase, self.naming_video_fade_timer
        )
        local _, dbg_wrap = font:getWrap(dbg, SCREEN_WIDTH)
        love.graphics.printf(dbg, 0, SCREEN_HEIGHT-font:getHeight()*0.5*#dbg_wrap, SCREEN_WIDTH*2, "right", 0, 0.5, 0.5)
    end
end

function preview:drawSplashText()
    love.graphics.setColor(1, 1, 0, self.fade)
    local font = Assets.getFont("main")
    love.graphics.setFont(font)
    local scale = 1 + math.sin(self.splash_timer) / 10
    local splash_angle, splash_x, splash_y
    if self.menu.state == "TITLE" then
        splash_angle = math.rad(-16)
        splash_x, splash_y = SCREEN_WIDTH/2+120, 105+48
    else
        splash_angle = math.rad(16)
        splash_x, splash_y = SCREEN_WIDTH-115, 40
        --splash_x, splash_y = SCREEN_WIDTH-120, 32
    end
    if DEBUG_RENDER then
        love.graphics.setColor(0.9, 0, 0.75, self.fade)
        love.graphics.rectangle("fill", splash_x, splash_y-5, 2, font:getHeight()+10)
        love.graphics.push()
        love.graphics.translate(splash_x, splash_y)
        love.graphics.rotate(splash_angle)
        love.graphics.setColor(0.5, 0.1, 0.5, self.fade)
        love.graphics.rectangle("fill", -2, 0, 2, font:getHeight()*scale)
        love.graphics.setColor(0.1, 0.5, 0.5, 0.5 * self.fade)
        love.graphics.rectangle("fill", -font:getWidth(self.splash)/2*scale, 0, font:getWidth(self.splash)*scale, font:getHeight()*scale)
        love.graphics.pop()
    end
    love.graphics.setColor(not self.april_fools and {1, 1, 0} or {0, 0, 1}, self.fade)
    love.graphics.print(self.splash, splash_x, splash_y, splash_angle, scale, scale, font:getWidth(self.splash)/2, 0)
end

function preview:areWeSelected()
    return self.menu.selected_mod and self.menu.selected_mod.id == self.mod_id
        or TARGET_MOD == self.mod_id
end

---@return FileNamer?
function preview:getNamer()
    if not self:areWeSelected() then return nil end
    return
        (self.menu.state == "FILENAME" and self.menu.file_name_screen and self.menu.file_name_screen.file_namer)
        or (self.menu.state == "DEFAULTNAME" and self.menu.default_name_screen and self.menu.default_name_screen.file_namer)
        ---@diagnostic disable-next-line: undefined-field
        or self.menu.naming_screen
end

function preview:isNameChosen(name, include_fadeout)
    local naming_screen = self:getNamer()
    return naming_screen
        and string.upper(naming_screen.name) == string.upper(name)
        and (
            naming_screen.state == "CONFIRM"
            or (include_fadeout and naming_screen.state == "FADEOUT")
        )
end

function preview:require(module, ...)
    return love.filesystem.load(self.base_path .. "/" .. module:gsub("%.", "/") .. ".lua")(...)
end

return preview
