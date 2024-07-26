---@class DarkPlaceLogo : Object
---@overload fun(...) : DarkPlaceLogo
local DarkPlaceLogo, super = Class(Object)

function DarkPlaceLogo:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self:setParallax(0, 0)

    self.phase = 0
    self.timer = 120
    self.max_timer = 0
    self.change_time = false

    self.big_star = Assets.getTexture("ui/title/big_star")
    self.star_timer = 0
    self.star_scale = 0
    self.star_rot = -math.rad(90)
    self.star_rotspeed = 2

    self.logo_text = Assets.getTexture("ui/title/text")
    self.letter_offsets = {}
    self.letter_w = 52
    for i = 1, 10 do
        self.letter_offsets[i] = {
            quad = love.graphics.newQuad((i - 1) * self.letter_w, 0,
                self.letter_w, self.logo_text:getHeight(),
                self.logo_text:getWidth(), self.logo_text:getHeight()),
            x = -20, y = 0, alpha = 0
        }
    end
    self.text_timer = 0

    self.intro_sound = love.audio.newSource(Assets.getMusicPath("darkplace_intro"), "stream")

    self.tagline = Assets.getTexture("ui/title/tagline")
    self.tagline_alpha = 0

    self.small_font = Assets.getFont("battlehud")

    self.debug_font = Assets.getFont("sans")
end

function DarkPlaceLogo:update()
    if self.phase < 4 then
        self.timer = Utils.approach(self.timer, 0, DTMULT)
    end

    if self.timer <= 0 and self.phase < 4 and self.change_time == false then
        self.phase = self.phase + 1
        self.change_time = true
    end

    if self.phase >= 1 then
        self.star_timer = self.star_timer + 0.1 * DTMULT

        local idle_rot = math.sin((self.star_timer - 2) * self.star_rotspeed / 10) / 4
        self.star_rot = Mod:lerpSnap(self.star_rot, idle_rot, 0.1 * DTMULT)

		local idle_scale = 1 + math.sin((self.star_timer - 2) * 0.4) * 0.1
        self.star_scale = Mod:lerpSnap(self.star_scale, idle_scale, 0.1 * DTMULT)
    end

    if self.phase == 1 then
        if self.change_time then
            self.timer = 60
            self.intro_sound:play()
            self.change_time = false
        end
    end

    if self.phase == 2 then
        if self.change_time then
            self.timer = 120
            self.change_time = false
        end
    end

    if self.phase >= 2 then
        self.text_timer = self.text_timer + DTMULT

        for i = 1, 10 do
            local off = self.letter_offsets[i]
            off.y = math.sin((self.text_timer + i * 10) / 20) * 20 - 5

            if i <= math.min(10, math.floor((self.text_timer + 4) / 4)) then
                off.x = Utils.ease(-10, 10, off.alpha, "out-cubic")
                off.alpha = Utils.approach(off.alpha, 1, 0.05 * DTMULT)
            end
        end
    end

    if self.phase == 3 then
        if self.change_time then
            self.timer = 160
            self.change_time = false
        end
    end

    if self.phase >= 3 then
        self.tagline_alpha = Utils.approach(self.tagline_alpha, 1, 0.01 * DTMULT)
    end

    super.update(self)
end

function DarkPlaceLogo:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.big_star, self.width/2, self.height/2,
        self.star_rot, self.star_scale, self.star_scale,
        self.big_star:getWidth()/2, self.big_star:getHeight()/2)

    if self.phase >= 2 then
        for i = 1, 10 do
            local off = self.letter_offsets[i]
            love.graphics.setColor(1, 1, 1, off.alpha)
            love.graphics.draw(self.logo_text, off.quad, 66 + (i - 1) * self.letter_w + off.x, 220 + off.y)
        end
    end

    if self.phase >= 3 then
        love.graphics.setColor(1, 1, 1, self.tagline_alpha)
        love.graphics.draw(self.tagline,
            self.width/2, self.height/2+120,
            0, 1, 1,
            self.tagline:getWidth()/2, self.tagline:getHeight()/2)
    end

    if self.phase >= 4 then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.setFont(self.small_font)
        love.graphics.printf("[PRESS Z OR ENTER]", 0, self.height-80, SCREEN_WIDTH, "center")
    end

	if DEBUG_RENDER then
        love.graphics.setColor(1, 0, 0)
        love.graphics.setFont(self.debug_font)

        local dbg = string.format(
            [[phase=%d
timer=%d
star_scale=%.2f
star_rot=%.2f
            ]],
            self.phase,
            self.timer,
            self.star_scale,
            self.star_rot
        )

        love.graphics.printf(dbg, 0, 0, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
    end

    super.draw(self)
end

return DarkPlaceLogo