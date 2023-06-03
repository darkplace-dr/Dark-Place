local preview = {}

preview.hide_background = true

function preview:init(mod, button, menu)
    self.particles = {}
    self.particle_timer = 0

    self.texture = love.graphics.newImage(mod.path.."/star.png")

    button:setColor(1, 1, 1)
    button:setFavoritedColor(0.9, 0.8, 1)

    self.menu = menu
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
end

function preview:draw()
    if self.fade > 0 then
        for _,particle in ipairs(self.particles) do
            local alpha = (particle.radius / particle.max_radius) * self.fade

            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.draw(self.texture, particle.x, particle.y, particle.radius)
        end

        love.graphics.setBlendMode("alpha")
    end
end

return preview
