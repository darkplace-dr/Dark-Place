local DarkPlaceLogo, super = Class(Event)

function DarkPlaceLogo:init(x, y, width, height)
    super:init(self, x, y, SCREEN_WIDTH, SCREEN_HEIGHT)

    self:setParallax(0, 0)
    self.layer = WORLD_LAYERS["top"]
	
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
    self.offsets = {
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0},
        {-20, 0, 0}
    }
    self.text_timer = 0
    self.current_letter = 1
    self.played_intro_sound = false
	
    self.tagline = Assets.getTexture("ui/title/tagline")
    self.tagline_alpha = 0
	
    Game.world.music:stop()
end

function DarkPlaceLogo:update()
    if self.phase < 4 then
        self.timer = self.timer - DTMULT
    end
	
    if self.timer <= 0 and self.phase < 4 and self.change_time == false then
        self.phase = self.phase + 1
        self.change_time = true
    end
	
    if self.phase >= 1 then 
        self.star_timer = self.star_timer + 0.1 * DTMULT
        local idle_rot = (math.sin((((self.star_timer-2)* self.star_rotspeed) / 10))) * 0.25
        self.star_rot = Utils.lerp(self.star_rot, idle_rot, 0.1)
		
		local idle_scale = 1 + (math.sin((((self.star_timer-2)* 4) / 10))) * 0.1
        self.star_scale = Utils.lerp(self.star_scale, idle_scale, 0.1)
    end

    if self.phase == 1 then
        if self.change_time then
            self.timer = 60
            self.change_time = false
        end
        if self.played_intro_sound == false then
            self.played_intro_sound = true
            Assets.playSound("darkplace_intro")
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
            self.offsets[i][2] = (math.sin(((self.text_timer + (i * 10)) / 20)) * 20) - 5
        end

        for i = 1, math.min(10, math.floor((self.text_timer + 4) / 4)) do
            self.offsets[i][1] = Ease.outCubic(self.offsets[i][3], -10, 10, 1)
            self.offsets[i][3] = math.min(1, self.offsets[i][3] + (0.05 * DTMULT))
        end
    end
	
    if self.phase == 3 then
        if self.change_time then
            self.timer = 160
            self.change_time = false
        end
    end
	
    if self.phase >= 3 then
        self.tagline_alpha = self.tagline_alpha + 0.01 * DTMULT
    end
end

function DarkPlaceLogo:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, 640, 480)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(self.big_star, 320, 240, self.star_rot, self.star_scale, self.star_scale, 270/2, 270/2)

    if self.phase >= 2 then
        for i = 1, 10 do
            love.graphics.setColor(1, 1, 1, self.offsets[i][3])
            love.graphics.translate(self.offsets[i][1], self.offsets[i][2])
            Draw.pushScissor()
            Draw.scissor(66 + ((i - 1) * 52), 0, 52, 480)
            love.graphics.draw(self.logo_text, 66, 220)
            Draw.popScissor()
            love.graphics.translate(-self.offsets[i][1], -self.offsets[i][2])
        end
    end
	
    if self.phase >= 3 then
        love.graphics.setColor(1, 1, 1, self.tagline_alpha)
        love.graphics.draw(self.tagline, 320, 320, 0, 1, 1, 210/2, 22/2)
    end
	
    if self.phase >= 4 then
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.setFont(Assets.getFont("battlehud"))
        love.graphics.printf("[PRESS Z OR ENTER]", 0, 420, SCREEN_WIDTH, "center", 0, 1, 1)
    end
	
	if DEBUG_RENDER then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.setFont(Assets.getFont("sans"))
		
        local dbg1 = string.format(
            [[timer = %d
phase = %d
star_scale = %.2f
star_rot = %.2f
            ]],
            self.timer,
            self.phase,
            self.star_scale,
            self.star_rot
        )

        love.graphics.printf(dbg1, 0, 0, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
    end
	
    super.draw(self)
end

return DarkPlaceLogo