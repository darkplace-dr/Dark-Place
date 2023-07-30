local preview = {}

preview.hide_background = true

function preview:init(mod, button, menu)
    button:setColor(1, 1, 1)
    button:setFavoritedColor(0.9, 0.8, 1)

    self.menu = menu
    self.base_path = mod.path.."/preview"

    self.particles = {}
    self.particle_timer = 0
    self.particle_texture = love.graphics.newImage(self.base_path.."/star.png")

    self.swellow = nil
    self.swellow_timer = 0
	
	self.paul = false
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
        local radius = Utils.random() * 12
        table.insert(self.particles, {radius = radius, x = Utils.random() * SCREEN_WIDTH, y = SCREEN_HEIGHT + radius, max_radius = radius, speed = Utils.random() * 0.5 + 0.5})
    end

    if self:canShowSwellow() then
        if not self.swellow then
            self.swellow = love.graphics.newImage(self.base_path.."/swellow.png")
        end
        self.swellow_timer = self.swellow_timer + DT
    else
        self.swellow_timer = 0
    end
	
	if self:canPaul() and not self.paul then
		local paul = love.sound.newSoundData(self.base_path.."/paul.wav")
		local paul_is_the_favorite_of_all = love.audio.newSource(paul)
		paul_is_the_favorite_of_all:setVolume(1)
		paul_is_the_favorite_of_all:setPitch(1)
		paul_is_the_favorite_of_all:play()
		self.paul = true
	end
end

function preview:draw()
    if self.fade > 0 then
        for _,particle in ipairs(self.particles) do
            local alpha = (particle.radius / particle.max_radius) * self.fade

            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.draw(self.particle_texture, particle.x, particle.y, particle.radius)
        end
        love.graphics.setColor(1, 1, 1)

        if self:canShowSwellow() and self.swellow then
            local alpha = (self.swellow_timer - 1.8) * 0.2
            ---@type FileNamer
            local naming_screen = self.menu.naming_screen
            love.graphics.setColor(1, 1, 1, math.min(alpha, 0.8))
            love.graphics.draw(self.swellow,
                SCREEN_WIDTH/2, SCREEN_HEIGHT/2-30, 0,
                2 + math.max(0, (self.swellow_timer - 3) * 0.01 + naming_screen.whiten * 1), 2,
                self.swellow:getWidth()/2, self.swellow:getHeight()/2
            )
        end
    end
end

function preview:canShowSwellow()
    ---@type FileNamer
    local naming_screen = self.menu.naming_screen
    return naming_screen
        and string.upper(naming_screen.name) == "SWELLOW"
        and (naming_screen.state == "CONFIRM" or naming_screen.state == "FADEOUT")
end

function preview:canPaul()
    ---@type FileNamer
    local naming_screen = self.menu.naming_screen
    return naming_screen
        and string.upper(naming_screen.name) == "PAUL"
        and (naming_screen.state == "CONFIRM" or naming_screen.state == "FADEOUT")
end

return preview
