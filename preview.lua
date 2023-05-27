local preview = {}

-- whether to fade out the default background
preview.hide_background = false

function preview:init(mod, button, menu)
    -- code here gets called when the mods are loaded
    self.particles = {}
    self.particle_timer = 0
	
    self.texture = ""

    if love.filesystem.getInfo("mods/Dark-Place-main/star.png") then
        self.texture = love.graphics.newImage("mods/Dark-Place-main/star.png")
    elseif love.filesystem.getInfo("mods/Dark-Place/star.png") then
        self.texture = love.graphics.newImage("mods/Dark-Place/star.png")
    elseif love.filesystem.getInfo("mods/DarkPlacemain/star.png") then
        self.texture = love.graphics.newImage("mods/DarkPlacemain/star.png")
    elseif love.filesystem.getInfo("mods/DarkPlace/star.png") then
        self.texture = love.graphics.newImage("mods/Dark-Place/star.png")
    elseif love.filesystem.getInfo("mods/Dark Place/star.png") then
        self.texture = love.graphics.newImage("mods/Dark Place/star.png")
    end

    button:setColor(1, 1, 1)
    button:setFavoritedColor(0.9, 0.8, 1)

    self.menu = menu
end

function preview:update()
    -- code here gets called every frame, before any draws
    -- to only update while the mod is selected, check self.selected (or self.fade)

    local to_remove = {}
    for _,particle in ipairs(self.particles) do
        particle.radius = particle.radius
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
    -- code here gets drawn to the background every frame!!
    -- make sure to check  self.fade  or  self.selected  here

    if self.fade > 0 then

        for _,particle in ipairs(self.particles) do
            local alpha = (particle.radius / particle.max_radius) * self.fade

            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.draw(self.texture, particle.x, particle.y, particle.radius)
        end

        love.graphics.setBlendMode("alpha")
    end
end

function preview:drawOverlay()
    -- code here gets drawn above the menu every frame
    -- so u can make cool effects
    -- if u want
end

return preview
