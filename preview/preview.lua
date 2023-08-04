local preview = {}

function preview:init(mod, button, menu)
    button:setColor(1, 1, 1)
    button:setFavoritedColor(0.9, 0.8, 1)

    self.mod_id = mod.id
    self.menu = menu
    self.base_path = mod.path.."/preview"

    self.particles = {}
    self.particle_timer = 0
    self.particle_tex = love.graphics.newImage(self.base_path.."/star.png")

    self.swellow = nil
    self.swellow_timer = 0

	self.paul_played = false
    self.paul_stream = nil

    self.croak_played = false
    self.croak_stream = nil
end

function preview:update()
    local to_remove = {}
    for _,particle in ipairs(self.particles) do
        particle.radius = particle.radius - DT
        particle.y = particle.y - particle.speed * (DTMULT * 2)

        if particle.radius <= 0 then
            table.insert(to_remove, particle)
        end
    end

    for _,particle in ipairs(to_remove) do
        Utils.removeFromTable(self.particles, particle)
    end

    self.particle_timer = self.particle_timer + DT
    if self.particle_timer >= 0.4 then
        self.particle_timer = 0
        local radius = Utils.random(12)
        table.insert(self.particles, {
            radius = radius, max_radius = radius,
            x = Utils.random(SCREEN_WIDTH), y = SCREEN_HEIGHT + radius,
            speed = Utils.random(0.5, 1)
        })
    end

    if self:shouldShowSwellow() then
        if not self.swellow then
            self.swellow = love.graphics.newImage(self.base_path.."/swellow.png")
        end
        self.swellow_timer = self.swellow_timer + DT
    else
        self.swellow_timer = 0
    end

    if self:shouldPaul() then
        if not self.paul_played then
            if not self.paul_stream then
                self.paul_stream = love.audio.newSource(self.base_path.."/paul.ogg", "stream")
            end
            self.paul_stream:play()
            self.paul_played = true
        end
    else
        if self.paul_played then
            self.paul_stream:stop()
        end
        self.paul_played = false
    end

    if self:shouldCroak() then
        if not self.croak_played then
            if not self.croak_stream then
                self.croak_stream = love.audio.newSource(self.base_path.."/croakreverb.ogg", "stream")
            end
            self.croak_stream:play()
            self.croak_played = true
        end
    else
        if self.croak_played then
            self.croak_stream:stop()
        end
        self.croak_played = false
    end
end

function preview:draw()
    if self.fade <= 0 then return end

    for _,particle in ipairs(self.particles) do
        local alpha = (particle.radius / particle.max_radius) * self.fade

        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(self.particle_tex, particle.x, particle.y, particle.radius)
    end
    love.graphics.setColor(1, 1, 1)

    if self:shouldShowSwellow() and self.swellow then
        local alpha = math.min((self.swellow_timer - 1.8) * 0.2, 0.8)
        ---@type FileNamer
        local naming_screen = self.menu.naming_screen
        local xs_inc = math.max(0, (self.swellow_timer - 3) * 0.02 + naming_screen.whiten)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(self.swellow,
            SCREEN_WIDTH/2, SCREEN_HEIGHT/2-30, 0,
            2 + xs_inc, 2,
            self.swellow:getWidth()/2, self.swellow:getHeight()/2
        )
    end
end

function preview:areWeSelected()
    return self.menu.selected_mod and self.menu.selected_mod.id == self.mod_id
end

function preview:shouldShowSwellow()
    ---@type FileNamer
    local naming_screen = self.menu.naming_screen
    return self:areWeSelected() and naming_screen
        and string.upper(naming_screen.name) == "SWELLOW"
        and (naming_screen.state == "CONFIRM" or naming_screen.state == "FADEOUT")
end

function preview:shouldPaul()
    ---@type FileNamer
    local naming_screen = self.menu.naming_screen
    return self:areWeSelected() and naming_screen
        and string.upper(naming_screen.name) == "PAUL"
        and naming_screen.state == "CONFIRM"
end

function preview:shouldCroak()
    ---@type FileNamer
    local naming_screen = self.menu.naming_screen
    return self:areWeSelected() and naming_screen
        and string.upper(naming_screen.name) == "YOU"
        and naming_screen.state == "CONFIRM"
end

return preview